//
//  NTFourSquareApiClient.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>
#import "NTFourSquareApiClient.h"
#import "Venue.h"

static NSString *const kFourSquareClientId = @"OTRCMCKGQOYRP3M2HVTBOJEDSI5DHMKNCLAZVS0IGDMG1XHH";
static NSString *const kFourSquareClientSecret = @"D5PHWXIDTQMD5M2R1KN2GBAQEWJH00CDQWT0FGNFZAIAJDVX";
static NSString *const kBaseURL = @"https://api.foursquare.com/v2/";

@implementation NTFourSquareApiClient

+ (instancetype)sharedInstance {
    
    static NTFourSquareApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[NTFourSquareApiClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        
    });
    
    return _sharedClient;
    
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    
    return self;
    
}

- (void)updateVenuesWithCompletionBlock:(void (^)(NSError *error))completionBlock {
    
    NSParameterAssert(completionBlock);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"ll"] = @"48.858,2.2944";
    parameters[@"limit"] = @10;
    parameters[@"v"] = @"20140806";
    parameters[@"client_id"] = kFourSquareClientId;
    parameters[@"client_secret"] = kFourSquareClientSecret;
    
    [self GET:@"venues/search" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            NSArray *venues = [[responseObject objectForKey:@"response"] objectForKey:@"venues"];
            [Venue MR_importFromArray:venues inContext:localContext];
            
        } completion:^(BOOL success, NSError *error) {
            
            // CMT I can refer here without checking for block, as it is checked in assertion
            // without this I'll check it like if (completionBlock)
            completionBlock(error);
            
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        completionBlock(error);
        
    }];
    
}


@end
