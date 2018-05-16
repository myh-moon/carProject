//
//  NSTimer+Block.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/14.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TimerBlock)(NSTimer *timer);

@interface NSTimer (Block)

- (void) addAction:(TimerBlock)block;

@end
