//
//  BaseRemindView.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/10.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseRemindView : UIView

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIImageView *remindImageView;
@property (nonatomic,strong) UILabel *remindLabel;
@property (nonatomic,strong) UIButton *remindButton;

@property (nonatomic,strong) NSLayoutConstraint *btnWidthConstraints;
@property (nonatomic,strong) NSLayoutConstraint *btnHeightConstraints;


@end
