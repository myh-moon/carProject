//
//  UIViewController+ImagePicker.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/13.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedImageHandler)(UIImage *img);

@interface UIViewController (ImagePicker)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) SelectedImageHandler imageHandler;

//拍照
- (void)showAlertOfImageChoiceWith:(SelectedImageHandler)handler;

//查看大图片
- (void) showImages:(NSArray *)images currentIndex:(NSInteger)currentIndex;

@end
