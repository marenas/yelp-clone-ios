//
//  SwitchCell.m
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/15/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.onSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.onSwitch setOn:on animated:animated];
}

- (void) switchValueChanged:(UISwitch *)paramSender{
    
    if ([paramSender isOn]){
        NSLog(@"The switch is turned on.");
    } else {
        NSLog(@"The switch is turned off.");
    }
    
    if (self.delegate != nil) {
        [self.delegate switchCell:self didChangeValue:[_onSwitch isOn]];
    }
    
}

@end
