//
//  NTPizzaCell.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "NTPizzaCell.h"
#import "Venue.h"

@interface NTPizzaCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation NTPizzaCell

- (void)configureForVenue:(Venue *)venue {
    
    self.nameLabel.text = venue.name;
    
}

@end
