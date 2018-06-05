//
//  ShortConditionView.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/16.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "ShortConditionView.h"

@implementation ShortConditionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = MLWhiteColor;
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 49, MLWindowWidth, 1);
        layer.backgroundColor = MLBackGroundColor.CGColor;
        [self.layer addSublayer:layer];
        
        [self addSubview:self.comprehensiveBtn];
        [self addSubview:self.typeBtn];
        [self addSubview:self.rentBtn];
        [self addSubview:self.brandBtn];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        NSArray *views = @[self.comprehensiveBtn,self.typeBtn,self.rentBtn,self.brandBtn];
        //        [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:20 insetSpacing:YES matchedSizes:YES];
        [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0];
        [views autoSetViewsDimension:ALDimensionHeight toSize:50];
        
        [[views firstObject ] autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
        
//        [[views firstObject] autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:bigSpacing];
//        [[views lastObject] autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:bigSpacing];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)comprehensiveBtn {
    if (!_comprehensiveBtn) {
        _comprehensiveBtn = [UIButton newAutoLayoutView];
        [_comprehensiveBtn setTitle:@"  综合排序  " forState:0];
        [_comprehensiveBtn setTitleColor:MLBlackColor forState:0];
        _comprehensiveBtn.titleLabel.font = MLFont;
        [_comprehensiveBtn setImage:[UIImage imageNamed:@"sort"] forState:0];
        [_comprehensiveBtn swapImage];
        _comprehensiveBtn.tag = 111;
        
        MLWeakSelf;
        [_comprehensiveBtn addAction:^(UIButton *btn) {
            
            if (weakself.typeBtn.selected) {
                [weakself.typeBtn swapOnlyImage];
            }
            
            if (weakself.rentBtn.selected) {
                [weakself.rentBtn swapOnlyImage];
            }
            
            if (weakself.brandBtn.selected) {
                [weakself.brandBtn swapOnlyImage];
            }
            
            [weakself.typeBtn setTitle:@"类型  " forState:0];
            [weakself.rentBtn setTitle:@"租金  " forState:0];
            [weakself.brandBtn setTitle:@"品牌  " forState:0];
            
            weakself.typeBtn.selected = NO;
            weakself.rentBtn.selected = NO;
            weakself.brandBtn.selected = NO;
            
            if (weakself.didSelectBtn) {
                weakself.didSelectBtn(btn);
            }
//            btn.selected = !btn.selected;
        }];
        
    }
    return _comprehensiveBtn;
}

- (UIButton *)typeBtn {
    if (!_typeBtn) {
        _typeBtn = [UIButton newAutoLayoutView];
        [_typeBtn setTitle:@"类型  " forState:0];
        [_typeBtn setTitleColor:MLBlackColor forState:0];
        _typeBtn.titleLabel.font = MLFont;
        [_typeBtn swapImage];
        [_typeBtn setImage:[UIImage imageNamed:@"xiala"] forState:0];
//        [_typeBtn setTitleColor:MLRedColor forState:UIControlStateSelected];
        _typeBtn.tag = 112;

        MLWeakSelf;
        [_typeBtn addAction:^(UIButton *btn) {
            
            if (weakself.rentBtn.selected) {
                [weakself.rentBtn swapOnlyImage];
            }
            if (weakself.brandBtn.selected) {
                [weakself.brandBtn swapOnlyImage];
            }
            
            weakself.rentBtn.selected = NO;
            weakself.brandBtn.selected = NO;
            
            [btn swapOnlyImage];
            
            if (weakself.didSelectBtn) {
                weakself.didSelectBtn(btn);
            }
            
            btn.selected = !btn.selected;
        }];
    }
    return _typeBtn;
}

- (UIButton *)rentBtn {
    if (!_rentBtn) {
        _rentBtn = [UIButton newAutoLayoutView];
        [_rentBtn setTitle:@"租金  " forState:0];
        [_rentBtn setTitleColor:MLBlackColor forState:0];
        _rentBtn.titleLabel.font = MLFont;
        [_rentBtn swapImage];
        [_rentBtn setImage:[UIImage imageNamed:@"xiala"] forState:0];
//        [_rentBtn setTitleColor:MLRedColor forState:UIControlStateSelected];
        _rentBtn.tag = 114;

        
        MLWeakSelf;
        [_rentBtn addAction:^(UIButton *btn) {
            
            if (weakself.typeBtn.selected) {
                [weakself.typeBtn swapOnlyImage];
            }
            
            if (weakself.brandBtn.selected) {
                [weakself.brandBtn swapOnlyImage];
            }
//            weakself.comprehensiveBtn.selected = NO;
            weakself.typeBtn.selected = NO;
            weakself.brandBtn.selected = NO;
            
            [btn swapOnlyImage];
            
            
            if (weakself.didSelectBtn) {
                weakself.didSelectBtn(btn);
            }
            btn.selected = !btn.selected;
        }];
    }
    return _rentBtn;
}

- (UIButton *)brandBtn {
    if (!_brandBtn) {
        _brandBtn = [UIButton newAutoLayoutView];
        [_brandBtn setTitle:@"品牌  " forState:0];
        [_brandBtn setTitleColor:MLBlackColor forState:0];
        _brandBtn.titleLabel.font = MLFont;
        [_brandBtn swapImage];
        [_brandBtn setImage:[UIImage imageNamed:@"xiala"] forState:0];
//        [_brandBtn setTitleColor:MLRedColor forState:UIControlStateSelected];
        _brandBtn.tag = 113;


        MLWeakSelf;
        [_brandBtn addAction:^(UIButton *btn) {
            
            
            if (weakself.typeBtn.selected) {
                [weakself.typeBtn swapOnlyImage];
            }
            
            if (weakself.rentBtn.selected) {
                [weakself.rentBtn swapOnlyImage];
            }
            
//            weakself.comprehensiveBtn.selected = NO;
            weakself.typeBtn.selected = NO;
            weakself.rentBtn.selected = NO;
            
            [btn swapOnlyImage];
            
            if (weakself.didSelectBtn) {
                weakself.didSelectBtn(btn);
            }
            btn.selected = !btn.selected;
        }];
        
    }
    return _brandBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
