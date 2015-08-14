//
//  NTBarButtonItem.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "NTBarButtonItem.h"

@interface NTBarButtonItem ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) NTBarButtonItemAction actionBlock;
@end

@implementation NTBarButtonItem

- (instancetype)initWithImage:(UIImage *)image actionBlock:(NTBarButtonItemAction)actionBlock {
    
    self = [super init];
    
    if (self) {
        
        _actionBlock = [actionBlock copy];
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.customView = _button;
        [_button setImage:image forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
        _button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
        _button.userInteractionEnabled = YES;
        
    }
    
    return self;
    
}

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem action:(NTBarButtonItemAction)actionBlock {
    
    self = [super initWithBarButtonSystemItem:systemItem target:nil action:@selector(buttonTouched)];
    
    if (self) {
        
        self.target = self;
        _actionBlock = [actionBlock copy];
        
    }
    
    return self;
    
}

- (void)buttonTouched {
    
    if (self.actionBlock) {
        
        self.actionBlock(self);
        
    }
    
}

@end
