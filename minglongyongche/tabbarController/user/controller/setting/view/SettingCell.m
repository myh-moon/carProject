//
//  SettingCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/11.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return MLCellHeight;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    [self.contentView addSubview:self.settingLabel];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.settingLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.settingLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)settingLabel {
    if (!_settingLabel) {
        _settingLabel = [UILabel newAutoLayoutView];
        _settingLabel.text = @"退出登录";
        _settingLabel.font = MLFont2;
        _settingLabel.textColor = MLOrangeColor;
    }
    return _settingLabel;
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
