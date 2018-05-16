//
//  PlaceProvinceCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "PlaceProvinceItem.h"

@interface PlaceProvinceCell : BaseCell

@property (nonatomic,strong) UILabel *ttLabel;
@property (nonatomic,strong) UITextField *ttTextField;
@property (nonatomic,strong) UIButton *ttButton;

@property (nonatomic,strong,readwrite) PlaceProvinceItem *item;


@end
