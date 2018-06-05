//
//  NetworkViewController.h
//  minglongyongche
//
//  Created by jiamanu on 2018/3/29.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BaseViewController.h"

@interface NetworkViewController : BaseViewController

@property (nonatomic,assign) BOOL showBottom;  //显示“我也是有底线的”

//post
-(void)requestDataPostWithString:(NSString *)string params:(NSDictionary *)params successBlock:(void(^)(id responseObject))successBlock andFailBlock:(void(^)(NSError *error))failBlock;

//get
-(void)requestDataGetWithString:(NSString *)string params:(NSDictionary *)params successBlock:(void(^)(id responseObject))successBlock andFailBlock:(void(^)(NSError *error))failBlock;

- (void)toLoginifNotLoginFromController:(UIViewController *)controller;;


@end
