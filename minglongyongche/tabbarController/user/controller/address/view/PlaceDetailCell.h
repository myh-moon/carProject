//
//  PlaceDetailCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "PlaceDetailItem.h"

@interface PlaceDetailCell : BaseCell

@property (nonatomic,strong) UITextView *ttTextView;

@property (nonatomic,strong,readwrite) PlaceDetailItem *item;

@end
