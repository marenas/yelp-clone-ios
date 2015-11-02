//
//  YelpClient.h
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/11/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

//#ifndef YelpClient_h
//#define YelpClient_h

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface YelpClient : BDBOAuth1RequestOperationManager

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

//#endif /* YelpClient_h */
