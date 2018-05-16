//
//  MyOrderDetailActionItem.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/3.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyOrderDetailActionItem.h"

@implementation MyOrderDetailActionItem

- (instancetype)initWithMyOrderStatus:(NSString *)status countDownTime:(NSString *)time{
    self = [super init];
    if (self) {
        self.status = status;
    }
    return self;
}

@end
