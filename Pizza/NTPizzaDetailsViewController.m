//
//  NTPizzaDetailsViewController.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "NTPizzaDetailsViewController.h"

@interface NTPizzaDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *venueTitle;

@end

@implementation NTPizzaDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.venueTitle.text = self.venue.name;
    
}

@end
