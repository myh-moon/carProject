//
//  UIViewController+CountDownTime.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/14.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "UIViewController+CountDownTime.h"

@implementation UIViewController (CountDownTime)

- (void)setChangeTimeHandle:(DidChangeTimeHandle)changeTimeHandle
{
    objc_setAssociatedObject(self, @selector(startCountDown:withResponse:), changeTimeHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (DidChangeTimeHandle)changeTimeHandle {
  return  objc_getAssociatedObject(self, @selector(startCountDown:withResponse:));
}

- (void)startCountDown:(DidChangeTimeHandle)handle withResponse:(MyOrderDetailResponse *)response{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(beginTo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

//- (void)beginTo {
////    MyOrderDetailResponse *response = self.listlist[0];
//    
//    if ([response.order.statuss integerValue] == 0) {
//        NSDate *datenow = [NSDate date];//现在时间
//        NSString *nowTime = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//        
//        //2.计算差值
//        NSInteger value = [response.order.times integerValue] - [nowTime integerValue];
//        
//        if (value > 0) {//倒计时未结束
//            value--;
//            NSString *sssss = [NSString stringWithFormat:@"倒计时%02ld:%02ld:%02ld\n",value/3600,(value%3600)/60,value%60];
//            NSLog(@"*********%@******",sssss);
//        }
//    }
//}

@end
