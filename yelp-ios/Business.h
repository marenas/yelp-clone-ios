//
//  Business.h
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/13/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSURL *ratingImageURL;
@property (nonatomic, strong) NSNumber *reviewCount;

- (id)initWithBusinessData:(NSDictionary *)businessData;
+ (NSArray *)businessesFromArrayOfDictionaries:(NSArray *)businessDicts;

@end
