//
//  PlaceChooseCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "PlaceChooseItem.h"

@interface PlaceChooseCell : BaseCell

@property (nonatomic,strong) UILabel *ttLabel;
@property (nonatomic,strong) UIButton *ttButton;

@property (nonatomic,strong,readwrite) PlaceChooseItem *item;


@end
