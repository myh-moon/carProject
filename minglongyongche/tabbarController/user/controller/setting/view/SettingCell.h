//
//  SettingCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/11.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "SettingItem.h"

@interface SettingCell : BaseCell

@property (nonatomic,strong) UILabel *settingLabel;

@property (nonatomic,strong,readwrite) SettingItem *item;

@end
