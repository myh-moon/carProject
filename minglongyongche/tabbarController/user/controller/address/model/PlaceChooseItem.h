//
//  PlaceChooseItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface PlaceChooseItem : RETableViewItem

@property (nonatomic,strong) void (^didSelectedBtn)(NSString *);


@end
