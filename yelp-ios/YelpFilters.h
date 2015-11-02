//
//  YelpFilters.h
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/29/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpFilters : NSObject <NSCopying>

@property (nonatomic, copy) NSString *searchTerm;
@property (nonatomic, readonly) NSDictionary *filters;
@property (nonatomic) NSArray *categories;
@property (nonatomic, strong) NSMutableSet *selectedCategories;
@property (nonatomic, strong) NSMutableArray *selectedCategoriesNames;
@property (nonatomic, strong) NSArray *distances;
@property (nonatomic, strong) NSMutableArray *firstDistance;
@property (nonatomic, strong) NSArray *sort;
@property (nonatomic, strong) NSMutableArray *firstSort;
@property (nonatomic) BOOL dealSelected;

- (void)initFilterParameters;
- (id)initWithDefaults;
- (void)setSelectedCategoriesNames;

@end


