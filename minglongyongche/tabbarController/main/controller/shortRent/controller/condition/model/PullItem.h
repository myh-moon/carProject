//
//  PullItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/6/1.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "ConditionModel.h"

@interface PullItem : RETableViewItem

@property (nonatomic,strong) ConditionModel *conditionModel;

@property (nonatomic,strong) NSString *names;

@end
