//
//  OrderTicketView.m
//  minglongyongche
//
//  Created by jiamanu on 2018/6/4.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "OrderTicketView.h"

@implementation OrderTicketView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.noLimitButton];
        
        [self setNeedsUpdateConstraints];
    }
    
    return self;
    
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.noLimitButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
        [self.noLimitButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
        [self.noLimitButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
        [self.noLimitButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)noLimitButton {
    if (!_noLimitButton) {
        _noLimitButton = [UIButton newAutoLayoutView];
        [_noLimitButton setTitle:@"不使用优惠券" forState:0];
        [_noLimitButton setTitleColor:MLDrakGrayColor forState:0];
        _noLimitButton.titleLabel.font = MLFont;
        _noLimitButton.backgroundColor = MLWhiteColor;
    }
    return _noLimitButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
