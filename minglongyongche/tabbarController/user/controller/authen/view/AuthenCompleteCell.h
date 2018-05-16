//
//  AuthenCompleteCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "AuthenCompleteItem.h"

@interface AuthenCompleteCell : BaseCell

@property (nonatomic,strong) UIImageView *completeImageView;
@property (nonatomic,strong) UILabel *completeLabel;
@property (nonatomic,strong) UIButton *completeButton;

@property (nonatomic,strong,readwrite) AuthenCompleteItem *item;


@end
