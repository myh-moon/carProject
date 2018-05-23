//
//  UIViewController+ImageBrowser.m
//  JBHope
//
//  Created by Magi on 15/10/9.
//  Copyright (c) 2015年 MengBaby Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "UIViewController+ImageBrowser.h"
#import "ImageBrowserViewController.h"

@implementation UIViewController (ImageBrowser)

- (void)showImages:(NSArray *)images currentIndex:(NSUInteger)index {
    [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:index imagesBlock:^NSArray *{
        return images;
    }];
}

- (void)showImages:(NSArray *)images
{
    [self showImages:images currentIndex:0];
}

@end
