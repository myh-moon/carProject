//
//  AuthenConfirmView.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/10.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AuthenConfirmView.h"

@implementation AuthenConfirmView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:self.commitButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.commitButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 10, 10) excludingEdge:ALEdgeTop];
        [self.commitButton autoSetDimension:ALDimensionHeight toSize:40];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [UIButton newAutoLayoutView];
        [_commitButton setTitle:@"提交认证" forState:0];
        [_commitButton setTitleColor:MLWhiteColor forState:0];
        _commitButton.titleLabel.font = MLFont4;
        _commitButton.backgroundColor = MLOrangeColor;
    }
    return _commitButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
