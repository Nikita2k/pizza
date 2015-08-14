//
//  NTPizzaDetailsViewController.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "NTPizzaDetailsViewController.h"
#import "ModelIncludes.h"


@interface NTPizzaDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *venueTitle;
@property (weak, nonatomic) IBOutlet UILabel *additionalInfo;

@end

@implementation NTPizzaDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.venueTitle.text = self.venue.name;
    self.additionalInfo.text = [NSString stringWithFormat:@"in %d meters, has %d checkins. ", self.venue.location.distanceValue, self.venue.checkinsValue];
    
}

@end
