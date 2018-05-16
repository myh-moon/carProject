//
//  AuthenPhotoItem.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/26.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseItem.h"

@interface AuthenPhotoItem : BaseItem

@property  (nonatomic,copy) NSString *photoType;

@property (nonatomic,strong) UIImage *frontImage;
@property (nonatomic,strong) UIImage *sideImage;

@property (nonatomic,copy) NSString *frontString;
@property (nonatomic,copy) NSString *sideString;

- (instancetype) initWithType:(NSString *)photo;

@end
