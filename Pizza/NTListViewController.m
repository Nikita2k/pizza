//
//  NTListViewController.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>
#import "NTListViewController.h"
#import "NTPizzaCell.h"
#import "NTPizzaDetailsViewController.h"
#import "NTFourSquareApiClient.h"
#import "Venue.h"
#import "Location.h"
#import "NTBarButtonItem.h"

static NSString *const kPizzaPlaceCellIdentifier = @"kPizzaPlaceCellIdentifier";
static NSString *const kShowDetailsSegue = @"showPizzaDetail";

@interface NTListViewController () < UITableViewDataSource, UITableViewDelegate >

@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
@property (strong, nonatomic) NSArray *venues;

@end

@implementation NTListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // CMT: showing last request data. May be good to move to bg queue and fetch there
    // also can show empty list
    self.venues = [Venue MR_findAllSortedBy:@"name" ascending:YES];
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
    
    Venue *venue = [self.venues objectAtIndex:indexPath.row];
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

#pragma mark - Helpers

- (void)registerTableViewCells {
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    UINib *cellNib =
    [UINib nibWithNibName:NSStringFromClass([NTPizzaCell class]) bundle:mainBundle];
    
    [self.placesTableView registerNib:cellNib forCellReuseIdentifier:kPizzaPlaceCellIdentifier];
    
}

- (void)addRefreshButton {
    
    __weak __typeof(self) weakSelf = self;
    NTBarButtonItem *item = [[NTBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh action:^(UIBarButtonItem *sender) {
        
        [weakSelf fetchDataFromServer];
        
    }];
    
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)fetchDataFromServer {
    
    __weak __typeof(self) weakSelf = self;
    [[NTFourSquareApiClient sharedInstance] updateVenuesWithCompletionBlock:^(NSError *error) {
        
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
        
    }];
    
}

@end
