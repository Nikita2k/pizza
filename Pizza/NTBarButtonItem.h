//
//  NTBarButtonItem.h
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NTBarButtonItemAction)(UIBarButtonItem *sender);

@interface NTBarButtonItem : UIBarButtonItem

- (instancetype)initWithImage:(UIImage *)image actionBlock:(NTBarButtonItemAction)actionBlock;
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem action:(NTBarButtonItemAction)actionBlock;

@end
