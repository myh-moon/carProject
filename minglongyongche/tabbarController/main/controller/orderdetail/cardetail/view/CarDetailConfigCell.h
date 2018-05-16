//
//  CarDetailConfigCell.h
//  minglongyongche
//
//  Created by jiamanu on 2018/4/4.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseCell.h"
#import "ConfigCollectionCell.h"


#import "CarDetailConfigItem.h"

@interface CarDetailConfigCell : BaseCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel *configLabel;

@property (nonatomic,strong) UICollectionView *configCollectionView;

@property (nonatomic,strong,readwrite) CarDetailConfigItem *item;

@end
