//
//  ConfirmMessageItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/24.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseItem.h"
#import "CarModel.h"
#import "PreOrderModel.h"
@interface ConfirmMessageItem : BaseItem

@property (nonatomic,copy) NSString *img;  //小图片
@property (nonatomic,copy) NSString *namess;
@property (nonatomic,copy) NSString *license;
@property (nonatomic,copy) NSString *feature1;

- (instancetype) initWithModel:(CarModel *)model;

- (instancetype) initWithPreOrderModel:(PreOrderModel *)model;

@end
