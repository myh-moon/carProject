//
//  PullCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/6/1.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "PullItem.h"

@interface PullCell : BaseCell

@property (nonatomic,strong) UILabel *pullTextLabel;

@property (nonatomic,strong,readwrite) PullItem *item;

@end
