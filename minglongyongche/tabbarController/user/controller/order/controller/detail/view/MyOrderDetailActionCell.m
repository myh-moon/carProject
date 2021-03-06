//
//  MyOrderDetailActionCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/3.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyOrderDetailActionCell.h"

@implementation MyOrderDetailActionCell

@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 100;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.countDownButton];
    [self.contentView addSubview:self.actionButton1];
    [self.contentView addSubview:self.actionButton2];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        NSArray *views = @[self.countDownButton,self.actionButton1,self.actionButton2];
        [views autoAlignViewsToAxis:ALAxisHorizontal];
        
        [self.countDownButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.countDownButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.actionButton2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        [self.actionButton2 autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.actionButton1 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.actionButton2 withOffset:-smallSpacing];
        [self.actionButton1 autoSetDimension:ALDimensionHeight toSize:40];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)countDownButton {
    if (!_countDownButton) {
        _countDownButton = [UIButton newAutoLayoutView];
        _countDownButton.titleLabel.numberOfLines = 0;
    }
    return _countDownButton;
}

- (UIButton *)actionButton1 {
    if (!_actionButton1) {
        _actionButton1 = [UIButton newAutoLayoutView];
        _actionButton1.titleLabel.font = MLFont5;
        _actionButton1.layer.cornerRadius = 3;
    }
    return _actionButton1;
}

- (UIButton *)actionButton2 {
    if (!_actionButton2) {
        _actionButton2 = [UIButton newAutoLayoutView];
        _actionButton2.titleLabel.font = MLFont5;
        _actionButton2.layer.cornerRadius = 3;
    }
    return _actionButton2;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    NSInteger sdsdsd = [self.item.status integerValue];
    
    MLWeakSelf;
    switch (sdsdsd) {
        case 0:{//未付款
            
            self.actionButton1.layer.borderWidth = 1;
            self.actionButton1.layer.borderColor = MLDrakGrayColor.CGColor;
            [self.actionButton1 setTitleColor:MLDrakGrayColor forState:0];
            
            [self.actionButton2 setTitleColor:MLOrangeColor forState:0];
            self.actionButton2.layer.borderColor = MLOrangeColor.CGColor;
            self.actionButton2.layer.borderWidth = 1;
        }
            break;
        case 1:{//已付款
            [self.countDownButton setHidden:YES];
            [self.actionButton1 setHidden:YES];
            
            [self.actionButton2 setTitle:@"  取消订单  " forState:0];
            self.actionButton2.layer.borderColor = MLDrakGrayColor.CGColor;
            self.actionButton2.layer.borderWidth = 1;
            [self.actionButton2 setTitleColor:MLDrakGrayColor forState:0];
            [self.actionButton2 addAction:^(UIButton *btn) {
                if (weakself.item.didSelectedAction) {
                    weakself.item.didSelectedAction(@"取消订单");
                }
            }];
        }
            break;
        case 2:{//已取车
            [self.countDownButton setHidden:YES];
            [self.actionButton1 setHidden:YES];
            [self.actionButton2 setHidden:YES];
        }
            break;
        case 3:{//已还车
            [self.countDownButton setHidden:YES];
            [self.actionButton1 setHidden:YES];
            
            [self.actionButton2 setTitle:@"  删除订单  " forState:0];
            self.actionButton2.layer.borderColor = MLDrakGrayColor.CGColor;
            self.actionButton2.layer.borderWidth = 1;
            [self.actionButton2 setTitleColor:MLDrakGrayColor forState:0];
            [self.actionButton2 addAction:^(UIButton *btn) {
                if (weakself.item.didSelectedAction) {
                    weakself.item.didSelectedAction(@"删除订单");
                }
            }];
        }
            break;
        case 4:{//已取消订单
            [self.countDownButton setHidden:YES];
            
            [self.actionButton1 setTitle:@"  删除订单  " forState:0];
            self.actionButton1.layer.borderColor = MLDrakGrayColor.CGColor;
            self.actionButton1.layer.borderWidth = 1;
            [self.actionButton1 setTitleColor:MLDrakGrayColor forState:0];
            [self.actionButton1 addAction:^(UIButton *btn) {
                if (weakself.item.didSelectedAction) {
                    weakself.item.didSelectedAction(@"删除订单");
                }
            }];

            [self.actionButton2 setTitle:@"  重新下单  " forState:0];
            self.actionButton2.layer.borderColor = MLOrangeColor.CGColor;
            self.actionButton2.layer.borderWidth = 1;
            [self.actionButton2 setTitleColor:MLOrangeColor forState:0];
            [self.actionButton2 addAction:^(UIButton *btn) {
                if (weakself.item.didSelectedAction) {
                    weakself.item.didSelectedAction(@"重新下单");
                }
            }];
            
        }
            break;
        case 6:{//异常订单
            [self.countDownButton setHidden:YES];
            [self.actionButton1 setHidden:YES];
            
            [self.actionButton2 setTitle:@"  删除订单  " forState:0];
            self.actionButton2.layer.borderColor = MLDrakGrayColor.CGColor;
            self.actionButton2.layer.borderWidth = 1;
            [self.actionButton2 setTitleColor:MLDrakGrayColor forState:0];
            [self.actionButton2 addAction:^(UIButton *btn) {
                if (weakself.item.didSelectedAction) {
                    weakself.item.didSelectedAction(@"删除订单");
                }
            }];
        }
            break;
        case 5:{//已删除订单
            [self.countDownButton setHidden:YES];
            [self.actionButton1 setHidden:YES];
            [self.actionButton2 setHidden:YES];
        }
            break;
        default:
            break;
    }
    
    [[RACObserve(self.item, countDownTimeString) takeUntil:[self rac_prepareForReuseSignal]] subscribeNext:^(id timeString) {
        
        if ([weakself.item.status integerValue] == 0) {
            if (![timeString isEqualToString:@"倒计时 00:00:00\n"]) {
                [self.countDownButton setAttributedTitle:[NSString setFirstPart:timeString firstFont:13 firstColor:MLOrangeColor secondPart:@"将自动关闭订单" secondFont:13 secongColor:MLOrangeColor space:4 align:0] forState:0];
                
                [self.actionButton1 setTitle:@"  取消订单  " forState:0];
                [self.actionButton1 addAction:^(UIButton *btn) {
                    if (weakself.item.didSelectedAction) {
                        weakself.item.didSelectedAction(@"取消订单");
                    }
                }];
                
                [self.actionButton2 setTitle:@"  立即支付  " forState:0];
                [self.actionButton2 addAction:^(UIButton *btn) {
                    if (weakself.item.didSelectedAction) {
                        weakself.item.didSelectedAction(@"立即支付");
                    }
                }];
                
            }else{
                [self.countDownButton setAttributedTitle:[NSString setFirstPart:self.item.countDownTimeString firstFont:13 firstColor:MLDrakGrayColor secondPart:@"订单已过期" secondFont:13 secongColor:MLDrakGrayColor space:4 align:0] forState:0];
                
                [self.actionButton1 setTitle:@"  删除订单  " forState:0];
                [self.actionButton1 addAction:^(UIButton *btn) {
                    if (weakself.item.didSelectedAction) {
                        weakself.item.didSelectedAction(@"删除订单");
                    }
                }];
                
                [self.actionButton2 setTitle:@"  重新下单  " forState:0];
                [self.actionButton2 addAction:^(UIButton *btn) {
                    if (weakself.item.didSelectedAction) {
                        weakself.item.didSelectedAction(@"重新下单");
                    }
                }];
            }
            
        }
        
        
    }];
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
