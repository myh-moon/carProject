//
//  AuthenRemindCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/10.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AuthenRemindCell.h"

@implementation AuthenRemindCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 40;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    self.backgroundColor = MLBackGroundColor;
    
    [self.contentView addSubview:self.rrLabel];
    
    [self setNeedsUpdateConstraints];
}


- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.rrLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.rrLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)rrLabel {
    if (!_rrLabel) {
        _rrLabel = [UILabel newAutoLayoutView];
        _rrLabel.textColor = UIColorFromRGB(0xbebebe);
        _rrLabel.text = @"* 方便尽快通过审核，请保证你所提交的信息真实有效。";
        _rrLabel.font = MLFont3;
    }
    return _rrLabel;
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
