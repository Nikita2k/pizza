//
//  NTPizzaCell.h
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Venue;

@interface NTPizzaCell : UITableViewCell

- (void)configureForVenue:(Venue *)venue;

@end
