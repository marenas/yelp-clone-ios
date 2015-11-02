//
//  BusinessCell.m
//  yelp-ios
//
//  Created by Matias Arenas Sepulveda on 10/12/15.
//  Copyright © 2015 Matias Arenas Sepulveda. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell

- (void)awakeFromNib {
    // Initialization code
    self.thumbImageView.layer.cornerRadius = 4;
    self.thumbImageView.clipsToBounds = true;
    
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
