//
//  NTPizzaCell.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "NTPizzaCell.h"

@interface NTPizzaCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation NTPizzaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
