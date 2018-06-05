//
//  BaseViewController.h
//  minglongyongche
//
//  Created by jiamanu on 2018/3/29.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRemindView.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong) UIBarButtonItem *leftBarItem; //返回键
@property (nonatomic,strong) UIButton *leftNavBtn;
@property (nonatomic,strong) UIButton *rightNavBtn;

@property (nonatomic,assign) BOOL didSetupConstraints;

- (void)back;

@end
