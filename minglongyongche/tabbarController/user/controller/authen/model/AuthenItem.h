//
//  AuthenItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/26.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseItem.h"

@interface AuthenItem : BaseItem

@property (nonatomic,copy) NSString *namess;
@property (nonatomic,copy) NSString *placeholder;

@property (nonatomic,assign) BOOL showSeperates;  //显示分割线

@property (nonatomic,strong) void (^didEndEditingText)(NSString *text);

- (instancetype) initWithLeftName:(NSString *)name placeholder:(NSString *)placeHoleder;


@end
