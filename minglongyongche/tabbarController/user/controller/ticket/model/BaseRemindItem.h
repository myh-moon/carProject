//
//  BaseRemindItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/28.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface BaseRemindItem : RETableViewItem

@property (nonatomic,copy) NSString *remindImage;
@property (nonatomic,copy) NSString *remindText;
@property (nonatomic,copy) NSString *remindAction;

@property (nonatomic,strong) void (^didSelectedAction)(NSString *action);

@end
