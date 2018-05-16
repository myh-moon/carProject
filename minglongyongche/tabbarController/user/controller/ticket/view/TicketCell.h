//
//  TicketCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "TicketItem.h"

@interface TicketCell : BaseCell

@property (nonatomic,strong) UIImageView *backView;

@property (nonatomic,strong) UILabel *sourceLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *expirationLabel;
@property (nonatomic,strong) UILabel *validLabel;

@property (nonatomic,strong,readwrite) TicketItem *item;

@end
