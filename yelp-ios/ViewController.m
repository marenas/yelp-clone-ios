//
//  ViewController.m
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/11/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import "ViewController.h"
#import "YelpClient.h"
#import "BusinessCell.h"
#import "Business.h"
#import "UIImageView+AFNetworking.h"
#import "YelpBusiness.h"

@interface ViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) NSMutableArray *selectedCategoriesNames;
@property (nonatomic) BOOL dealsEnabled;
@property (nonatomic, strong) NSString *distanceFilter;
@property (nonatomic) NSInteger *sortModeFilter;
@property (strong, nonatomic) YelpFilters *mainYelpFilters;

@property (nonatomic, strong) UISearchBar *searchBar;

- (void)fetchBusinessesWithTerm:(NSString *)term categories:(NSArray *)categories deals:(BOOL)deals sortMode:(NSInteger *)sortMode distance:(NSString *)distance;
                                                                                                              
@end

@implementation ViewController

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        NSLog(@"main view init with coder");
        self.mainYelpFilters = [[YelpFilters alloc] initWithDefaults];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    self.tableView.estimatedRowHeight = 120;
    
    self.dealsEnabled = NO;
    self.distanceFilter = nil;
    [self.selectedCategoriesNames addObjectsFromArray:@[@"burgers"]];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.tintColor = [UIColor colorWithRed:85.0 green:239.0 blue:203.0 alpha:1.0];
    self.searchBar.showsCancelButton = TRUE;
    
    self.searchBar.delegate = self;
    
    self.navigationItem.titleView = self.searchBar;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self fetchBusinessesWithTerm:@"Restaurants" categories:self.selectedCategoriesNames deals:self.dealsEnabled sortMode:self.sortModeFilter distance:self.distanceFilter];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell" forIndexPath:indexPath];
    
    YelpBusiness *business = self.businesses[indexPath.row];
    cell.nameLabel.text = business.name;
    [cell.thumbImageView setImageWithURL:business.imageUrl];
    cell.categoriesLabel.text = business.categories;
    cell.addressLabel.text = business.address;
    cell.reviewsCountLabel.text = [NSString stringWithFormat:@"%@ Reviews", business.reviewCount];
    [cell.ratingImageView setImageWithURL:business.ratingImageUrl];
    cell.distanceLabel.text = business.distance;

    return cell;
}

- (void) fetchBusinessesWithTerm:(NSString *)term categories:(NSArray *)categories deals:(BOOL)deals sortMode:(NSInteger *)sortMode distance:(NSString *)distance {
    YelpSortMode selectedSortMode = YelpSortModeBestMatched;
    if (sortMode != nil) {
        selectedSortMode = (YelpSortMode)sortMode;
    }
    
    [YelpBusiness searchWithTerm:term
                        sortMode:selectedSortMode
                      categories:categories
                           deals:deals
                        distance:distance
                      completion:^(NSArray *businesses, NSError *error) {
                          self.businesses = businesses;
                          [self.tableView reloadData];
                      }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // hide keyboard
    [searchBar resignFirstResponder];
    
    NSString *searchTerm = searchBar.text;
    [self fetchBusinessesWithTerm:searchTerm categories:self.selectedCategoriesNames deals:self.dealsEnabled sortMode:self.sortModeFilter distance:self.distanceFilter];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // hide keyboard
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // hide keyboard
    [searchBar resignFirstResponder];
}

#pragma mark - Filter Delegate methods
- (void)filtersViewController:(FiltersViewController *)filterViewController newFilters:(YelpFilters *)filterVCyelpFilters {

    //fire a new network event
    self.mainYelpFilters = [filterVCyelpFilters copy];
    [self.mainYelpFilters setSelectedCategoriesNames];
    self.selectedCategoriesNames = self.mainYelpFilters.selectedCategoriesNames;
    self.dealsEnabled = self.mainYelpFilters.dealSelected;
    
    if (![[self.mainYelpFilters.firstDistance[0] valueForKey:@"name"] isEqualToString:@"Auto"]) {
        self.distanceFilter = [self.mainYelpFilters.firstDistance[0] valueForKey:@"code"];
    } else {
        self.distanceFilter = nil;
    }
    
    self.sortModeFilter = (NSInteger *)[[self.mainYelpFilters.firstSort[0] valueForKey:@"code"] integerValue];
    
    [self fetchBusinessesWithTerm:@"Restaurants" categories:self.selectedCategoriesNames deals:self.dealsEnabled sortMode:self.sortModeFilter distance:self.distanceFilter];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showFiltersView"]) {
        NSLog(@"going to filters");
        UINavigationController *filtersNC = (UINavigationController*)segue.destinationViewController;
        filtersNC.navigationBar.barStyle = UIBarStyleBlack;
        FiltersViewController *filtersViewController = [filtersNC.viewControllers objectAtIndex:0];
        filtersViewController.delegate = self;
        filtersViewController.filterVCyelpFilters = [self.mainYelpFilters copy];
    }
}
@end
