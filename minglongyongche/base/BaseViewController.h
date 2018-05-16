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
@property (nonatomic,strong) BaseRemindView *remindImageButton;  //当数据为空时，显示的提示图片

@property (nonatomic,strong) void (^didSelectedRemindBtn)(NSString *remind);
@property (nonatomic,assign) BOOL didSetupConstraints;

//设置空白页的布局
- (void) setRemindImageView:(NSString *)imgName remindLabel:(NSString *)remindStr remindAction:(NSString *)action actionBackGroubdColor:(UIColor *)backColor actionTextColor:(UIColor *)textColor actionCorner:(CGFloat)corners;

- (void) showRemindImage;

- (void)hiddenRemindImage;

@end
