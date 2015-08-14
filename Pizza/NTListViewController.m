//
//  NTListViewController.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "NTListViewController.h"
#import "NTPizzaCell.h"
#import "NTPizzaDetailsViewController.h"

static NSString *const kPizzaPlaceCellIdentifier = @"kPizzaPlaceCellIdentifier";
static NSString *const kShowDetailsSegue = @"showPizzaDetail";

@interface NTListViewController () < UITableViewDataSource, UITableViewDelegate >

@property (weak, nonatomic) IBOutlet UITableView *placesTableView;

@end

@implementation NTListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerTableViewCells];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSAssert(tableView == self.placesTableView, @"NTListViewController works only with placesTableView");
    
    // TODO: find number of objects
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSAssert(tableView == self.placesTableView, @"NTListViewController works only with placesTableView");
    
    NTPizzaCell *cell = [tableView dequeueReusableCellWithIdentifier:kPizzaPlaceCellIdentifier];
    
    // TODO: configure cell
    
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
