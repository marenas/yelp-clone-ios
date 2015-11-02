//
//  Business.m
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/13/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import "Business.h"

@implementation Business

- (id)initWithBusinessData:(NSDictionary *)businessData {
    self = [super init];
    if (self) {

        _name = businessData[@"name"];
        NSString *imageURLString = businessData[@"image_url"];
        if (imageURLString != nil) {
            _imageURL = [NSURL URLWithString:imageURLString];
        } else {
            _imageURL = nil;
        }
        
        NSDictionary *location = businessData[@"location"];
        NSString *address = @"";
        if (location != nil) {
            NSArray *addressArray = location[@"address"];
            if (addressArray != nil && addressArray.count > 0) {
                address = addressArray[0];
            }
            
            NSArray *neighborhoods = location[@"neighborhoods"];
            if (neighborhoods != nil && neighborhoods.count > 0) {
                if (!([address length] == 0)) {
                    address = [address stringByAppendingString:@", "];
                }
                address = [address stringByAppendingString:neighborhoods[0]];
            }
        }
        _address = address;
        
        NSArray *categoriesArray = businessData[@"categories"];
        if (categoriesArray != nil) {
            NSMutableArray *categoryNames = [NSMutableArray array];
            for (id category in categoriesArray) {
                NSString *categoryName = category[0];
                [categoryNames addObject:categoryName];
            }
            _categories = [categoryNames componentsJoinedByString:@", "];
        } else {
            _categories = nil;
        }

        NSNumber *distanceMeters = businessData[@"distance"];
        if (distanceMeters != nil) {
            //milesPerMeter = 0.000621371 => I dont care about miles :D
            _distance = [NSString stringWithFormat:@"%.2f km", distanceMeters.doubleValue / 1000];
        } else {
            _distance = nil;
        }

        NSString *ratingImageURLString = businessData[@"rating_img_url_large"];
        if (ratingImageURLString != nil) {
            _ratingImageURL = [NSURL URLWithString:ratingImageURLString];
        } else {
            _ratingImageURL = nil;
        }
        
        _reviewCount = businessData[@"review_count"];
    }
    return self;
}

+ (NSArray *)businessesFromArrayOfDictionaries:(NSArray *)businessDicts {
    NSArray *businesses = [NSArray array];
    for (NSDictionary *businessData in businessDicts) {
        Business *business = [[Business alloc] initWithBusinessData:businessData];
        businesses = [businesses arrayByAddingObject:business];
    }
    return businesses;
}

@end
