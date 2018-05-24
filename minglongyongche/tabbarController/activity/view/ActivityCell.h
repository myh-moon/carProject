//
//  ActivityCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/12.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "ActivityItem.h"

@interface ActivityCell : RETableViewCell

@property (nonatomic,assign) BOOL didSetupConstraints;

@property (nonatomic,strong) UIButton *activityBannerButton;
@property (nonatomic,strong) UIButton *statusButton;

@property (nonatomic,strong) UILabel *activityTimeLabel;

@property (nonatomic,strong,readwrite) ActivityItem *item;

@end
