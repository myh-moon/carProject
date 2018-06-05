//
//  BaseRemindCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/28.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseRemindCell.h"

@implementation BaseRemindCell

//+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
////    return [UIScreen mainScreen].bounds.size.height;
//    
//    return 300;
//}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    self.backgroundColor = MLBackGroundColor;
    
    [self.contentView addSubview:self.remindImageView];
    [self.contentView addSubview:self.remindLabel];
    [self.contentView addSubview:self.remindButton];

    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        NSArray *views = @[self.remindImageView,self.remindLabel,self.remindButton];
        [views autoAlignViewsToAxis:ALAxisVertical];
        
        [self.remindImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
        [self.remindImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.remindLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.remindImageView withOffset:middleSpacing];
        
        [self.remindButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.remindLabel withOffset:20];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIImageView *)remindImageView {
    if (!_remindImageView) {
        _remindImageView = [UIImageView newAutoLayoutView];
    }
    return _remindImageView;
}

- (UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [UILabel newAutoLayoutView];
        _remindLabel.textColor = MLLightGrayColor;
        _remindLabel.font = MLFont8;
        _remindLabel.numberOfLines = 0;
    }
    return _remindLabel;
}

- (UIButton *)remindButton {
    if (!_remindButton) {
        _remindButton = [UIButton newAutoLayoutView];
        _remindButton.titleLabel.font = MLFont5;
    }
    return _remindButton;
}


- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.remindImageView.image = [UIImage imageNamed:self.item.remindImage];
    self.remindLabel.text = self.item.remindText;
    
    MLWeakSelf;
    if ([self.item.remindAction isEqualToString:@"去逛逛"]) {//我的订单
        [self.remindButton setTitle:self.item.remindAction forState:0];
        [self.remindButton setTitleColor:MLWhiteColor forState:0];
        self.remindButton.layer.cornerRadius = 17.5;
        self.remindButton.backgroundColor = MLOrangeColor;
        [self.remindButton autoSetDimensionsToSize:CGSizeMake(230, 35)];
        [self.remindButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedAction) {
                weakself.item.didSelectedAction(weakself.item.remindAction);
            }
        }];
    }else if([self.item.remindAction isEqualToString:@"去发现精彩"]){//我的收藏
        [self.remindButton setTitle:self.item.remindAction forState:0];
        [self.remindButton setTitleColor:MLWhiteColor forState:0];
        self.remindButton.layer.cornerRadius = 17.5;
        self.remindButton.backgroundColor = MLOrangeColor;
        [self.remindButton autoSetDimensionsToSize:CGSizeMake(230, 35)];
        [self.remindButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedAction) {
                weakself.item.didSelectedAction(weakself.item.remindAction);
            }
        }];
    }else{
        [self.remindButton setHidden:YES];
    }
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
