//
//  UIViewController+CountDownTime.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/14.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderDetailResponse.h"

typedef void (^DidChangeTimeHandle)(NSTimer *timer);

@interface UIViewController (CountDownTime)

@property (nonatomic,strong) DidChangeTimeHandle changeTimeHandle;

- (void) startCountDown:(DidChangeTimeHandle)handle withResponse:(MyOrderDetailResponse *)response;

@end
