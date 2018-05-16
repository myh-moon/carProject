//
//  UIViewController+ImagePicker.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/13.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "UIViewController+ImagePicker.h"

@implementation UIViewController (ImagePicker)
- (void)setImageHandler:(SelectedImageHandler)imageHandler
{
    objc_setAssociatedObject(self, @selector(setImageHandler:), imageHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SelectedImageHandler)imageHandler
{
    return objc_getAssociatedObject(self, @selector(setImageHandler:));
}
- (void) showAlertOfImageChoiceWith:(SelectedImageHandler)handler {
    
    self.imageHandler = handler;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片来源" message:nil preferredStyle:0];
    
    MLWeakSelf;
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"照相机" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imageController = [[UIImagePickerController alloc]init];
            imageController.delegate = weakself;
            imageController.allowsEditing = YES;
            imageController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imageController animated:YES completion:nil];
        }else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"相机" message:@"相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
            return;
        }
    }];
    [alertController addAction:action0];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:0 handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = weakself;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [weakself presentViewController:picker animated:YES completion:nil];
    }];
    [alertController addAction:action1];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.imageHandler(image);
    
}

@end
