//
//  ActivityItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/24.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface ActivityItem : RETableViewItem

@property (nonatomic,copy) NSString *imageName; //活动图
@property (nonatomic,copy) NSString *status; //活动状态
@property (nonatomic,copy) NSString *time;  //活动时间

@end
