//
//  PlaceItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface PlaceItem : RETableViewItem


@property (nonatomic,copy) NSString *ttString;
@property (nonatomic,copy) NSString *placeString;

@property (nonatomic,strong) void (^didEditting)(NSString *text);

- (instancetype) initWithInfo:(NSString *)info placeHolder:(NSString *)placeholders ;

@end
