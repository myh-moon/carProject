//
//  MyOrderDetailDurationItem.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/3.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyOrderDetailDurationItem.h"
#import "NSDate+FormatterTime.h"

@implementation MyOrderDetailDurationItem

- (instancetype)initWithStartTime:(NSString *)start endTime:(NSString *)end {
    self = [super init];
    if (self) {
        
        self.starttime = [NSDate getMDWhmFormatterTime:start];
        self.endtime = [NSDate getMDWhmFormatterTime:end];
        
        NSInteger value = [end integerValue] - [start integerValue];
        
        if (value%86400 == 0) {
            self.duration = [NSString stringWithFormat:@"%ld天",value/86400];
        }else{
            self.duration = [NSString stringWithFormat:@"%ld天",value/86400 + 1];
        }
    }
    return self;
}

@end
