//
//  AuthenCompleteCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AuthenCompleteCell.h"

@implementation AuthenCompleteCell
@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 400;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    
    [self.contentView addSubview:self.completeImageView];
    [self.contentView addSubview:self.completeLabel];
    [self.contentView addSubview:self.completeButton];

    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        NSArray *views = @[self.completeImageView,self.completeLabel,self.completeButton];
        [views autoAlignViewsToAxis:ALAxisVertical];
        
        [self.completeImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
        [self.completeImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.completeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.completeImageView];
        
        [self.completeButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.completeLabel withOffset:40];
        [self.completeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
        [self.completeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:80];
        [self.completeButton autoSetDimension:ALDimensionHeight toSize:35];
        
    }
    [super updateConstraints];
}

- (UIImageView *)completeImageView {
    if (!_completeImageView) {
        _completeImageView = [UIImageView newAutoLayoutView];
        [_completeImageView setImage:[UIImage imageNamed:@"authenticationok"]];
    }
    return _completeImageView;
}

- (UILabel *)completeLabel {
    if (!_completeLabel) {
        _completeLabel = [UILabel newAutoLayoutView];
        _completeLabel.textColor = MLDrakGrayColor;
        _completeLabel.font = MLFont4;
        _completeLabel.text = @"恭喜，你已通过实名验证";
    }
    return _completeLabel;
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [UIButton newAutoLayoutView];
        _completeButton.layer.cornerRadius = 17.5;
        [_completeButton setTitle:@"我知道了" forState:0];
        [_completeButton setTitleColor:MLWhiteColor forState:0];
        _completeButton.titleLabel.font = MLFont5;
        _completeButton.backgroundColor = MLOrangeColor;
        
        MLWeakSelf;
        [_completeButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(1212);
            }
        }];
    }
    return _completeButton;
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
