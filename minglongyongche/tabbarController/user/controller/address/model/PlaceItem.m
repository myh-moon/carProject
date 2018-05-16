//
//  PlaceItem.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PlaceItem.h"

@implementation PlaceItem

-(instancetype)initWithInfo:(NSString *)info placeHolder:(NSString *)placeholders {
    self = [super init];
    if (self) {
        self.ttString = info;
        self.placeString = placeholders;
    }
    return self;
}


@end
