//
//  MyOrderDetailProcessItem.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/3.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyOrderDetailProcessItem.h"

@implementation MyOrderDetailProcessItem

- (instancetype)initWithProcessStatus:(NSString *)status {
    self = [super init];
    if (self) {
        self.status = status;
    }
    return self;
}



@end
