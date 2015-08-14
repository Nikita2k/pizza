//
//  NTListViewController.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "NTListViewController.h"
#import "NTPizzaCell.h"
#import "NTPizzaDetailsViewController.h"
#import "NTFourSquareApiClient.h"
#import "Venue.h"
#import "Location.h"

static NSString *const kPizzaPlaceCellIdentifier = @"kPizzaPlaceCellIdentifier";
static NSString *const kShowDetailsSegue = @"showPizzaDetail";

@interface NTListViewController () < UITableViewDataSource, UITableViewDelegate >

@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
@property (strong, nonatomic) NSArray *venues;

@end

@implementation NTListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //[[NTFourSquareApiClient sharedInstance] updateVenues];
    
    // TODO: background?
    self.venues = [Venue MR_findAllSortedBy:@"name" ascending:YES];
    
    [self registerTableViewCells];

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
    
    // TODO: find object & send it
    [self performSegueWithIdentifier:kShowDetailsSegue sender:self];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kShowDetailsSegue]) {
        
        NSAssert([segue.destinationViewController isKindOfClass:[NTPizzaDetailsViewController class]],
                 @"showPizzaDetail should have NTPizzaDetailsViewController as a destination");
        
        NTPizzaDetailsViewController *detailsController = segue.destinationViewController;
        detailsController.modelObject = sender;
        
    }
    
}

#pragma mark - Helpers

- (void)registerTableViewCells {
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    UINib *cellNib =
    [UINib nibWithNibName:NSStringFromClass([NTPizzaCell class]) bundle:mainBundle];
    
    [self.placesTableView registerNib:cellNib forCellReuseIdentifier:kPizzaPlaceCellIdentifier];
    
}

@end
