//
//  AuthenRemindCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/10.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "BaseItem.h"

@interface AuthenRemindCell : BaseCell

@property (nonatomic,strong) UILabel *rrLabel;

@property (nonatomic,strong,readwrite) BaseItem *item;

@end
