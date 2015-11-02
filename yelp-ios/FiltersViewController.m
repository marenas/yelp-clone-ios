//
//  FiltersViewController.m
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/15/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FiltersViewController {
        BOOL categorySectionIsExpanded;
        BOOL distanceSectionIsExpanded;
        BOOL sortSectionIsExpanded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load VC");
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (categorySectionIsExpanded) {
            return [self.filterVCyelpFilters.categories count];
        } else {
            return 4;
        }
    } else if (section == 1) {
        if (distanceSectionIsExpanded) {
            return [self.filterVCyelpFilters.distances count];
        } else {
            return [self.filterVCyelpFilters.firstDistance count];
        }
    } else if (section == 2) {
        if (sortSectionIsExpanded) {
            return [self.filterVCyelpFilters.sort count];
        } else {
            return [self.filterVCyelpFilters.firstSort count];
        }
    } else if (section == 3) {
        return 1;
    }
    
    return 4;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Categories";
    } else if (section == 1) {
        return @"Distance";
    } else if (section == 2) {
        return @"Sort By";
    } else {
        return @"Deals";
    }
}

- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
    
- (IBAction)onSearchButton:(id)sender {

    [self.delegate filtersViewController:self newFilters:self.filterVCyelpFilters];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (!categorySectionIsExpanded && indexPath.row == 3) {
            categorySectionIsExpanded = YES;
            [self.tableView reloadData];
        }
    } else if (indexPath.section == 1) {
        
        if (distanceSectionIsExpanded) {
            self.filterVCyelpFilters.firstDistance[0] = [self.filterVCyelpFilters.distances[indexPath.row] mutableCopy];
        }
        distanceSectionIsExpanded = !distanceSectionIsExpanded;
        [tableView reloadData];
    } else if (indexPath.section == 2) {
        if (sortSectionIsExpanded) {
            self.filterVCyelpFilters.firstSort[0] = [self.filterVCyelpFilters.sort[indexPath.row] mutableCopy];
        }
        sortSectionIsExpanded = ! sortSectionIsExpanded;
        [tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (categorySectionIsExpanded || indexPath.row <3) {
            SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];
            
            cell.switchLabel.text = self.filterVCyelpFilters.categories[indexPath.row][@"name"];
            cell.delegate = self;
            cell.on = [self.filterVCyelpFilters.selectedCategories containsObject:self.filterVCyelpFilters.categories[indexPath.row]];
            
            return cell;
        } else {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
            cell.textLabel.text = @"More Categories";
            return cell;
        }
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        if (distanceSectionIsExpanded) {
            cell.textLabel.text = self.filterVCyelpFilters.distances[indexPath.row][@"name"];
        } else {
            cell.textLabel.text = self.filterVCyelpFilters.firstDistance[indexPath.row][@"name"];
        }
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
        return cell;
    } else if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        if (sortSectionIsExpanded) {
            cell.textLabel.text = self.filterVCyelpFilters.sort[indexPath.row][@"name"];
        } else {
            cell.textLabel.text = self.filterVCyelpFilters.firstSort[indexPath.row][@"name"];
        }
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
        return cell;
    } else if (indexPath.section == 3) {
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];
        cell.switchLabel.text = @"Deals";
        cell.on = self.filterVCyelpFilters.dealSelected;
        cell.delegate = self;
        
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"Something";
    return cell;
}

-(SwitchCell *)parentCellForView:(id)theView
{
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[SwitchCell class]]) {
            return (SwitchCell *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}

#pragma mark - Switch Cell delegate methods
- (void)switchCell:(SwitchCell*)switchCell didChangeValue:(BOOL)didChangeValue {
    if (switchCell != nil) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:switchCell];
    
        if (indexPath.section == 0) {
            NSLog(@"show detail for item at row %ld", indexPath.row);
        
            if(didChangeValue) {
                [self.filterVCyelpFilters.selectedCategories addObject:self.filterVCyelpFilters.categories[indexPath.row]];
            } else {
                [self.filterVCyelpFilters.selectedCategories removeObject:self.filterVCyelpFilters.categories[indexPath.row]];
            }
        } else if (indexPath.section == 3) {
            NSLog(@"show detail for item at row %ld", indexPath.row);
        
            if(didChangeValue) {
                self.filterVCyelpFilters.dealSelected = YES;
            } else {
                self.filterVCyelpFilters.dealSelected = NO;
            }
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width, 30)];
//    [label setFont:[UIFont boldSystemFontOfSize:16]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
    [label setTextColor:[UIColor whiteColor]];
    
    NSString *string;
    
    if (section == 0) {
        string = @"Categories";
    }
    else if (section == 1) {
        string = @"Distance";
    } else if (section == 2) {
        string = @"Sort By";
    } else {
        string = @"Deals";
    }
    
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    
    if (section == 0) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(230, 0, 80, 30)];
        [btn setTitle:@"Compress" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(unExpand) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    [view setBackgroundColor:[UIColor colorWithRed:62.0/255.0f green:198.0/255.0f blue:170.0/255.0f alpha:1.0f]];
    
    return view;
}


- (void)unExpand
{
    categorySectionIsExpanded = NO;
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                          atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
