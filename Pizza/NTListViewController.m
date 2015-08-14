//
//  NTListViewController.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "NTListViewController.h"
#import "NTPizzaCell.h"

NSString *const kPizzaPlaceCellIdentifier = @"kPizzaPlaceCellIdentifier";

@interface NTListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *placesTableView;

@end

@implementation NTListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerTableViewCells];

}

#pragma mark - Helpers

- (void)registerTableViewCells {
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    UINib *cellNib =
    [UINib nibWithNibName:NSStringFromClass([NTPizzaCell class]) bundle:mainBundle];
    
    [self.placesTableView registerNib:cellNib forCellReuseIdentifier:kPizzaPlaceCellIdentifier];
    
}

@end
