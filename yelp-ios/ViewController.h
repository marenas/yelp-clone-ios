//
//  ViewController.h
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/11/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersViewController.h"
#import "YelpFilters.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate>

@end

