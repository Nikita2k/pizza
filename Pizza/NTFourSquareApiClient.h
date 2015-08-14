//
//  NTFourSquareApiClient.h
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@interface NTFourSquareApiClient : AFHTTPSessionManager

+ (instancetype)sharedInstance;

- (void)updateVenues;

@end
