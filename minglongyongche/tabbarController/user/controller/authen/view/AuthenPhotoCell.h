//
//  AuthenPhotoCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/26.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "IntegrationButton.h"
#import "AuthenPhotoItem.h"


@interface AuthenPhotoCell : BaseCell

@property (nonatomic,strong) UILabel *photoLabel;
@property (nonatomic,strong) IntegrationButton *photoButton1;
@property (nonatomic,strong) IntegrationButton *photoButton2;
@property (nonatomic,strong) UIButton *photoButton3;

@property (nonatomic,strong,readwrite) AuthenPhotoItem *item;

@end
