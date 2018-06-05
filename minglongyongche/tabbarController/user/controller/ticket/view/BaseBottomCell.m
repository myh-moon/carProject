//
//  BaseBottomCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/28.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseBottomCell.h"

@implementation BaseBottomCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 80;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    self.backgroundColor = MLBackGroundColor;
    
    [self.contentView addSubview:self.bottomLabel];

    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.bottomLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.bottomLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [UILabel newAutoLayoutView];
        _bottomLabel.textColor = MLLightGrayColor;
        _bottomLabel.text = @"——  我也是有底线的  ——";
        _bottomLabel.font = MLFont;
    }
    return _bottomLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
