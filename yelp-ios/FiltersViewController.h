//
//  FiltersViewController.h
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/15/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchCell.h"
#import "YelpFilters.h"

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filterViewController newFilters:(YelpFilters *)filterVCyelpFilters;

@end

@interface FiltersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate>

@property (nonatomic, weak) id<FiltersViewControllerDelegate>delegate;
@property (nonatomic, strong) YelpFilters *filterVCyelpFilters;

@end
