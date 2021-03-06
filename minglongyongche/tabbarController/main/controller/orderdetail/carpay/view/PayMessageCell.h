//
//  PayMessageCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/25.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "ConfirmMessageItem.h"

@interface PayMessageCell : BaseCell

@property (nonatomic,strong) UIImageView *orderImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *licenseLabel;
@property (nonatomic,strong) UILabel *featureLabel1;
@property (nonatomic,strong) UILabel *featureLabel2;

@property (nonatomic,strong,readwrite) ConfirmMessageItem *item;


@end
