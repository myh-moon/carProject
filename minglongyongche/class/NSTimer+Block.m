//
//  NSTimer+Block.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/14.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "NSTimer+Block.h"
#import <objc/runtime.h>

@implementation NSTimer (Block)

static char actionTag;

- (void)addAction:(TimerBlock)block{
    objc_setAssociatedObject(self, &actionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [NSTimer timerWithTimeInterval:1 target:self selector:@selector(addAction) userInfo:nil repeats:YES];
}

- (void)addAction {
   TimerBlock block =  objc_getAssociatedObject(self, &actionTag);
    if (block) {
        block(self);
    }
}

//- (void)addAction:(ButtonBlock)block {
//    objc_setAssociatedObject(self, &actionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)action {
//    ButtonBlock block = objc_getAssociatedObject(self, &actionTag);
//    if (block) {
//        block(self);
//    }
//}


@end
