//
//  SesameCreditViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/14.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "SesameCreditViewController.h"

@interface SesameCreditViewController ()

@property (nonatomic,strong) UIWebView *sesameWebView;

@end

@implementation SesameCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"芝麻信用";
    
    [self authenty];
    
}

- (void) authenty {
//    支付宝第三方授权
    //    https://openauth.alipaydev.com/oauth2/appToAppAuth.htm?app_id=2018041102535930&redirect_uri=http://api.mlong88.vip/leaseapi/alipay

//    https://openauth.alipay.com/oauth2/appToAppAuth.htm?app_id=2018041102535930&redirect_uri=http://api.mlong88.vip/leaseapi/alipay
//    https%3A%2F%2Fopenauth.alipay.com%2Foauth2%2FappToAppAuth.htm%3Fapp_id%3D2018041102535930%26redirect_uri%3Dhttp%3A%2F%2Fapi.mlong88.vip%2Fleaseapi%2Falipay
    NSString *shou = @"%20https%3A%2F%2Fopenauth.alipay.com%2Foauth2%2FappToAppAuth.htm%3Fapp_id%3D2018041102535930%26redirect_uri%3Dhttp%3A%2F%2Fapi.mlong88.vip%2Fleaseapi%2Falipay";
    
//    //支付宝获取用户信息
////    https://openauth.alipay.com/oauth2/publicAppAuthorize.htm?app_id=2018041102535930&scope=auth_zhima&redirect_uri=http://api.mlong88.vip/leaseapi/alipay
//
//    NSString *shou = @"https%3A%2F%2Fopenauth.alipay.com%2Foauth2%2FpublicAppAuthorize.htm%3Fapp_id%3D2018041102535930%26scope%3Dauth_zhima%26redirect_uri%3Dhttp%3A%2F%2Fapi.mlong88.vip%2Fleaseapi%2Falipay";
//
    NSString *asas = [NSString stringWithFormat:@"alipays://platformapi/startapp?appId=20000067&url=%@",shou];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:asas]];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
