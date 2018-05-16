//
//  PlaceCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "PlaceItem.h"

@interface PlaceCell : BaseCell

@property (nonatomic,strong) UILabel *ttLabel;
@property (nonatomic,strong) UITextField *ttTextField;

@property (nonatomic,strong,readwrite) PlaceItem *item;

@end
