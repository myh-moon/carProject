//
//  UIViewController+Blur.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/12.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "UIViewController+Blur.h"
#import "AuthenViewController.h"

@implementation UIViewController (Blur)

- (void)showBlurViewInView:(UIView *)view array:(NSArray *)titleArray top:(CGFloat)top finishBlock:(void (^)(NSString *name, NSString *cid))finishBlock {
    UIView *tagView = [self.view viewWithTag:999];
    
    PullTableView *pullTableView = [self.view viewWithTag:998];
    
    if (!tagView) {
        tagView  = [UIView newAutoLayoutView];
        tagView.backgroundColor = [UIColor colorWithRed:0.2510 green:0.2510 blue:0.2510 alpha:0.5];
        tagView.tag = 999;
        
        if (!view) {
            view = self.view;
        }
        
        [view addSubview:tagView];
        [tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [tagView autoPinToTopLayoutGuideOfViewController:self withInset:top];
        
        pullTableView = [PullTableView newAutoLayoutView];
        [tagView addSubview:pullTableView];
        
        [pullTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:tagView];
        [pullTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:tagView];
        [pullTableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:tagView];
        [pullTableView autoSetDimension:ALDimensionHeight toSize:titleArray.count * 40];
        
        [pullTableView loadAllData:titleArray];
    }
    
        if (tagView) {//在空白处添加UIControl，点击空白处，使页面消失
            UIControl *tapControl = [UIControl newAutoLayoutView];
            [tagView addSubview:tapControl];
        
            [tapControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
            [tapControl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pullTableView];
            
            [tapControl addTarget:self action:@selector(hiddenBlurView) forControlEvents:UIControlEventTouchUpInside];
        }

    if (finishBlock) {
        [pullTableView setDidSelectedItem:^(NSString *text, NSString *cid) {
            [tagView removeFromSuperview];
            finishBlock(text,cid);
        }];
    }
}

- (void)showBlurViewInView:(UIView *)view array:(NSArray *)titleArray finishBlock:(void (^)(NSString *))finishBlock {
    UIView *tagView = [self.view viewWithTag:999];
    PullTableView *pullTableView = [self.view viewWithTag:998];
    
    if (!tagView) {
        tagView  = [UIView newAutoLayoutView];
        tagView.backgroundColor = [UIColor colorWithRed:0.2510 green:0.2510 blue:0.2510 alpha:0.5];
        tagView.tag = 999;
        
        if (!view) {
            view = self.view;
        }
        
        [view addSubview:tagView];
        [tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        pullTableView = [PullTableView newAutoLayoutView];
        pullTableView.signType = @"地址";
        [tagView addSubview:pullTableView];
        
        [pullTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:tagView];
        [pullTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:tagView];
        [pullTableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:tagView];
        [pullTableView autoSetDimension:ALDimensionHeight toSize:titleArray.count * 40];
        
        [pullTableView loadAllData:titleArray];
    }
    
    if (tagView) {//在空白处添加UIControl，点击空白处，使页面消失
        UIControl *tapControl = [UIControl newAutoLayoutView];
        [tagView addSubview:tapControl];
        
        [tapControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [tapControl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pullTableView];
        
        [tapControl addTarget:self action:@selector(hiddenBlurView) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (finishBlock) {
        [pullTableView setDidSelectedItem:^(NSString *text, NSString *cid) {
            [tagView removeFromSuperview];
            finishBlock(text);
        }];
    }
}

- (void)showBlurViewWithArray:(NSArray *)titleArray top:(CGFloat)height {
    
}

- (void)hiddenBlurView {
    UIView *tagView = [self.view viewWithTag:999];
    if (tagView) {
        [tagView removeFromSuperview];
    }
}


- (void)showPickerViewInView:(UIView *)view finishBlock:(void (^)(NSString *, NSDate *))finishBlock
{
    UIView *tagView = [self.view viewWithTag:999];
    PullDatePickerView *pickerView = [self.view viewWithTag:998];
    
    if (!tagView) {
        tagView  = [UIView newAutoLayoutView];
        tagView.backgroundColor = [UIColor colorWithRed:0.2510 green:0.2510 blue:0.2510 alpha:0.5];
        tagView.tag = 999;
        
        if (!view) {
            view = self.view;
        }
        
        [view addSubview:tagView];
        [tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        pickerView = [PullDatePickerView newAutoLayoutView];
        [tagView addSubview:pickerView];
        
        [pickerView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:tagView];
        [pickerView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:tagView];
        [pickerView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:tagView];
        [pickerView autoSetDimension:ALDimensionHeight toSize:250];
    }
    
    if (tagView) {//在空白处添加UIControl，点击空白处，使页面消失
        UIControl *tapControl = [UIControl newAutoLayoutView];
        [tagView addSubview:tapControl];
        
        [tapControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [tapControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:pickerView];
        
        [tapControl addTarget:self action:@selector(hiddenBlurView) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (finishBlock) {
        
        [pickerView setDidSelectedDate:^(NSString *dateStr, NSDate *date) {
            [tagView removeFromSuperview];
            finishBlock(dateStr,date);
//            finishBlock
        }];
    }
    
}

- (void)showDatePickerViewInView:(UIView *)view finishBlock:(void (^)(NSString *, NSDate *))finishBlock {
        UIView *tagView = [self.view viewWithTag:999];
        SimpleDatePickerView *pickerView = [self.view viewWithTag:998];
    
        if (!tagView) {
            tagView  = [UIView newAutoLayoutView];
            tagView.backgroundColor = [UIColor colorWithRed:0.2510 green:0.2510 blue:0.2510 alpha:0.5];
            tagView.tag = 999;
            
            if (!view) {
                view = self.view;
            }
            
            [view addSubview:tagView];
            [tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
            
            pickerView = [SimpleDatePickerView newAutoLayoutView];
            [tagView addSubview:pickerView];
            
            [pickerView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:tagView];
            [pickerView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:tagView];
            [pickerView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:tagView];
            [pickerView autoSetDimension:ALDimensionHeight toSize:250];
        }
        
        if (tagView) {//在空白处添加UIControl，点击空白处，使页面消失
            UIControl *tapControl = [UIControl newAutoLayoutView];
            [tagView addSubview:tapControl];
            
            [tapControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
            [tapControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:pickerView];
            
            [tapControl addTarget:self action:@selector(hiddenBlurView) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (finishBlock) {
            
            [pickerView setDidSelectedDate:^(NSString *dateStr, NSDate *date) {
                [tagView removeFromSuperview];
                finishBlock(dateStr,date);
                //            finishBlock
            }];
        }
}

- (void)showTwoBlurViewInView:(UIView *)view array:(NSArray *)brandArray top:(CGFloat)top finishBlock:(void (^)(NSString *, NSString *))finishBlock {
    UIView *tagView = [self.view viewWithTag:999];
    
    ShortBrandChooseView *brandTableView = [self.view viewWithTag:998];
    
    if (!tagView) {
        tagView  = [UIView newAutoLayoutView];
        tagView.backgroundColor = [UIColor colorWithRed:0.2510 green:0.2510 blue:0.2510 alpha:0.5];
        tagView.tag = 999;
        
        if (!view) {
            view = self.view;
        }
        
        [view addSubview:tagView];
        [tagView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [tagView autoPinToTopLayoutGuideOfViewController:self withInset:top];
        
        brandTableView = [ShortBrandChooseView newAutoLayoutView];
        [tagView addSubview:brandTableView];
        
        [brandTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:tagView];
        [brandTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:tagView];
        [brandTableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:tagView];
        [brandTableView autoSetDimension:ALDimensionHeight toSize:brandArray.count * 40];
        
        [brandTableView loadBrandData:brandArray];
    }
    
    if (tagView) {//在空白处添加UIControl，点击空白处，使页面消失
        UIControl *tapControl = [UIControl newAutoLayoutView];
        [tagView addSubview:tapControl];
        
        [tapControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [tapControl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:brandTableView];
        
        [tapControl addTarget:self action:@selector(hiddenBlurView) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (finishBlock) {
        [brandTableView setDidSelectedBrand:^(NSString *text, NSString *childID) {
            [tagView removeFromSuperview];
            finishBlock(text,childID);
        }];
    }
}

- (void)showAuthentyAlertView {
    UIView *backView = [UIView newAutoLayoutView];
    backView.backgroundColor = [UIColor colorWithRed:0.2510 green:0.2510 blue:0.2510 alpha:0.7];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:backView];
    
    [backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    
    //背景
    UIButton *backButton = [UIButton newAutoLayoutView];
    backButton.layer.cornerRadius = 11;
    backButton.backgroundColor = MLWhiteColor;
    backButton.titleLabel.numberOfLines = 0;
    [backButton setAttributedTitle: [NSString setFirstPart:@"去实名认证\n" firstFont:17 firstColor:MLDrakGrayColor secondPart:@"轻松租到你想要的车" secondFont:17 secongColor:MLDrakGrayColor space:10 align:1] forState:0];
    
    [backView addSubview:backButton];
    
    //取消按钮
    UIButton *cancelAuthenButton = [UIButton newAutoLayoutView];
    [cancelAuthenButton setImage:[UIImage imageNamed:@"close"] forState:0];
    [backView addSubview:cancelAuthenButton];

    [cancelAuthenButton addAction:^(UIButton *btn) {
        [backView removeFromSuperview];
    }];
    
    //头像
    UIButton *imageButton = [UIButton newAutoLayoutView];
    [imageButton setImage:[UIImage imageNamed:@"ic_tishi"] forState:0];
    [backView addSubview:imageButton];
    
    //认证按钮
    UIButton *toAuthenButton = [UIButton newAutoLayoutView];
    [toAuthenButton setTitle:@"前往认证" forState:0];
    [toAuthenButton setTitleColor:MLWhiteColor forState:0];
    toAuthenButton.titleLabel.font = MLFont7;
    toAuthenButton.backgroundColor = MLOrangeColor;
    toAuthenButton.layer.cornerRadius = 5;
    [backView addSubview:toAuthenButton];
    MLWeakSelf;
    [toAuthenButton addAction:^(UIButton *btn) {
        [backView removeFromSuperview];
        AuthenViewController *authenVC = [[AuthenViewController alloc] init];
        [weakself.navigationController pushViewController:authenVC animated:YES];
    }];
    
    [backButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [backButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:MLWindowWidth/2];
    [backButton autoSetDimensionsToSize:CGSizeMake(260, 240)];
    
    [cancelAuthenButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:backButton withOffset:-20];
    [cancelAuthenButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:backButton];
    
    [imageButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [imageButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:backButton withOffset:-120];

    [toAuthenButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:backButton withOffset:-middleSpacing];
    [toAuthenButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:backButton withOffset:middleSpacing];
    [toAuthenButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:backButton withOffset:-middleSpacing];
    [toAuthenButton autoSetDimension:ALDimensionHeight toSize:40];

}


@end
