//
//  NTFourSquareApiClient.h
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

UIKIT_EXTERN NSString *const kNTFourSquareApiDidSaveVenueData;

@class CLLocation;

@interface NTFourSquareApiClient : AFHTTPSessionManager

+ (instancetype)sharedInstance;
- (void)updateVenuesNearLocation:(CLLocation *)location withCompletionBlock:(void (^)(NSError *error))completionBlock;

@end
