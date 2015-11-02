//
//  SwitchCell.h
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/15/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchCellDelegate;

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (weak, nonatomic) IBOutlet UISwitch *onSwitch;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;
@property (nonatomic, assign) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end

@protocol SwitchCellDelegate <NSObject>
//    - (void)didSelectCodeLabel:(BOOL *)didChangeValue;
@optional
- (void)switchCell:(SwitchCell*)switchCell didChangeValue:(BOOL)didChangeValue;


@end

