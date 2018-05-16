//
//  AuthenConfirmView.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/10.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenConfirmView : UIView

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIButton *commitButton;
@property (nonatomic,strong) void (^didSelectedBtn)(NSString *commit);
@end
