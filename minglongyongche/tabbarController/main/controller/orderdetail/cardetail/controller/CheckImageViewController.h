//
//  CheckImageViewController.h
//  minglongyongche
//
//  Created by jiamanu on 2018/6/4.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "NetworkViewController.h"

@interface CheckImageViewController : NetworkViewController

@property (nonatomic,assign) NSInteger currentIndex;  //当前页数
@property (nonatomic,strong) NSArray *imageArray;   //可查看的图片数组

@end
