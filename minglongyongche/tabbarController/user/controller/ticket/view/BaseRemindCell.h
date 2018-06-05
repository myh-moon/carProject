//
//  BaseRemindCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/28.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "BaseRemindItem.h"

@interface BaseRemindCell : BaseCell

@property (nonatomic,strong) UIImageView *remindImageView;
@property (nonatomic,strong) UILabel *remindLabel;
@property (nonatomic,strong) UIButton *remindButton;

@property (nonatomic,strong,readwrite) BaseRemindItem *item;

@end
