//
//  NTFourSquareApiClient.m
//  Pizza
//
//  Created by Nikita Tuk on 14/08/15.
//  Copyright (c) 2015 Nikita Took. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>
#import <CoreLocation/CoreLocation.h>
#import "NTFourSquareApiClient.h"
#import "Venue.h"

NSString *const kNTFourSquareApiDidSaveVenueData = @"kNTFourSquareApiDidSaveVenueData";

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

- (void)updateVenuesNearLocation:(CLLocation *)location withCompletionBlock:(void (^)(NSError *error))completionBlock {
    
    NSParameterAssert(completionBlock);
    NSParameterAssert(location);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"ll"] = [NSString stringWithFormat:@"%.22f, %.2f", location.coordinate.latitude, location.coordinate.longitude];
    parameters[@"limit"] = @10;
    parameters[@"v"] = @"20140806";
    parameters[@"client_id"] = kFourSquareClientId;
    parameters[@"client_secret"] = kFourSquareClientSecret;
    // CMT: hardcoded pizza. Normally, would fetch this categories from server
    parameters[@"categoryId"] = @"4bf58dd8d48988d1ca941735";
    
    // CMT: normally I would use cocoalumberjack DDLog
    NSLog(@"Looking at %@", parameters[@"ll"]);
    
    [self GET:@"venues/search" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Deleting entries...");
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
            [Venue MR_truncateAllInContext:localContext];
            
            NSArray *venues = [[responseObject objectForKey:@"response"] objectForKey:@"venues"];
            [Venue MR_importFromArray:venues inContext:localContext];
            
        } completion:^(BOOL success, NSError *error) {
            
            // CMT I can refer here without checking for block, as it is checked in assertion
            // without this I'll check it like if (completionBlock)
            
            if (error == nil) {
                
                // CMT don't know who should read subscribe to this for now :)
                [[NSNotificationCenter defaultCenter] postNotificationName:kNTFourSquareApiDidSaveVenueData object:nil];
                
            }
            
            completionBlock(error);
            
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        completionBlock(error);
        
    }];
    
}


@end
