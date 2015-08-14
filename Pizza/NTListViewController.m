//
//  NTListViewController.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>
#import <CoreLocation/CoreLocation.h>
#import "NTListViewController.h"
#import "NTPizzaCell.h"
#import "NTPizzaDetailsViewController.h"
#import "NTFourSquareApiClient.h"
#import "Venue.h"
#import "Location.h"
#import "NTBarButtonItem.h"
#import "UIBarButtonItem+NTActivityViewButton.h"

static NSString *const kPizzaPlaceCellIdentifier = @"kPizzaPlaceCellIdentifier";
static NSString *const kShowDetailsSegue = @"showPizzaDetail";

typedef void (^LocationUpdatedBlock)(CLLocation *newLocation);

@interface NTListViewController () < UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate >

@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (copy, nonatomic) LocationUpdatedBlock locationUpdatedBlock;
@property (strong, nonatomic) UIBarButtonItem *requestDataButton;

@end

@implementation NTListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // CMT: showing last request data. May be good to move to bg queue and fetch there
    // also can show empty list
    self.venues = [Venue MR_findAllSortedBy:@"name" ascending:YES];
    
    [self registerLocationManager];
    [self registerTableViewCells];
    [self addRefreshButton];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSAssert(tableView == self.placesTableView, @"NTListViewController works only with placesTableView");
    return [self.venues count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSAssert(tableView == self.placesTableView, @"NTListViewController works only with placesTableView");
    
    Venue *venue = [self.venues objectAtIndex:indexPath.row];
    NSString *dist = [NSString stringWithFormat:@"%d", [[venue.location distance] intValue]];
    
    NSLog(@"venue name: %@, distance: %@", venue.name, dist);
    
    NTPizzaCell *cell = [tableView dequeueReusableCellWithIdentifier:kPizzaPlaceCellIdentifier];
    [cell configureForVenue:venue];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSAssert(tableView == self.placesTableView, @"NTListViewController works only with placesTableView");
    
    Venue *venue = [self.venues objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:kShowDetailsSegue sender:venue];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kShowDetailsSegue]) {
        
        NSAssert([segue.destinationViewController isKindOfClass:[NTPizzaDetailsViewController class]],
                 @"showPizzaDetail should have NTPizzaDetailsViewController as a destination");
        
        NSAssert([sender isKindOfClass:[Venue class]], @"NTPizzaDetailsViewController should accept Venue only");
        
        NTPizzaDetailsViewController *detailsController = segue.destinationViewController;
        detailsController.venue = (Venue *)sender;
        
    }
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    [manager stopUpdatingLocation];

    if (self.locationUpdatedBlock) {
        self.locationUpdatedBlock(newLocation);
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    // CMT: need to check status correcty. This one should be for initial launch only
    if (status != kCLAuthorizationStatusRestricted && status != kCLAuthorizationStatusDenied) {
        
        if ([self.venues count] == 0) {
            
            [self refreshButtonClicked];
            
        }
        
    }
    
}

#pragma mark - Helpers

- (void)registerTableViewCells {
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    UINib *cellNib =
    [UINib nibWithNibName:NSStringFromClass([NTPizzaCell class]) bundle:mainBundle];
    
    [self.placesTableView registerNib:cellNib forCellReuseIdentifier:kPizzaPlaceCellIdentifier];
    
}

- (void)addRefreshButton {
    
    __weak __typeof(self) weakSelf = self;
    self.requestDataButton = [[NTBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh action:^(UIBarButtonItem *sender) {
        
        [weakSelf refreshButtonClicked];
        
    }];
    
    self.navigationItem.rightBarButtonItem = self.requestDataButton;
    
}

- (void)registerLocationManager {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // TODO: think about statuses, check ios8-, do something when disabled
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        
        NSString *title = @"Location services are off";
        NSString *message = @"Enable IT!";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    } else if (status == kCLAuthorizationStatusNotDetermined){
     
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {

            [self.locationManager requestWhenInUseAuthorization];
            
        }
        
    }
    
}

- (void)refreshButtonClicked {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.locationUpdatedBlock == nil) {
        
        self.locationUpdatedBlock = ^(CLLocation *loc) {
            
            [weakSelf fetchDataFromServerAtLocation:loc];
            
        };
        
        [self.locationManager startUpdatingLocation];
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem nt_activityViewButton];
        
    }
    
}

- (void)fetchDataFromServerAtLocation:(CLLocation *)location {
    
    __weak __typeof(self) weakSelf = self;
    [[NTFourSquareApiClient sharedInstance] updateVenuesNearLocation:location withCompletionBlock:^(NSError *error) {
        
        if (error == nil) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                // TODO: check if I can fetch with it on background
                // can use self without strongify here, because if self is deallocated
                // that means I don't need dispalying anymore, rest of commands can be ommited
                weakSelf.venues = [Venue MR_findAllSortedBy:@"name" ascending:YES];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf.placesTableView reloadData];
                    
                });
                
            });
            
        } else {
            
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            
        }
        
        [weakSelf onRequestFinished];
        
    }];
    
}

- (void)onRequestFinished {
 
    self.locationUpdatedBlock = nil;
    self.navigationItem.rightBarButtonItem = self.requestDataButton;
    
}

@end
