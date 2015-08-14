//
//  UIBarButtonItem+NTActivityViewButton.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import "UIBarButtonItem+NTActivityViewButton.h"

@implementation UIBarButtonItem (NTActivityViewButton)

+ (UIBarButtonItem *)nt_activityViewButton {
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator startAnimating];
    
    return [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
}

@end
