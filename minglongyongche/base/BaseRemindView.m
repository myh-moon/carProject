//
//  BaseRemindView.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/10.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseRemindView.h"

@implementation BaseRemindView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.remindImageView];
        [self addSubview:self.remindLabel];
        [self addSubview:self.remindButton];

        [self setNeedsUpdateConstraints];
 
        self.btnWidthConstraints = [self.remindButton autoSetDimension:ALDimensionWidth toSize:MLWindowWidth/2];
        self.btnHeightConstraints = [self.remindButton autoSetDimension:ALDimensionHeight toSize:35];
        
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        NSArray *views = @[self.remindImageView,self.remindLabel,self.remindButton];
        [views autoAlignViewsToAxis:ALAxisVertical];
        
        [self.remindImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
