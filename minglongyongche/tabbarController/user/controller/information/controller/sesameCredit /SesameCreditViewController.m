//
//  SesameCreditViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/14.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "SesameCreditViewController.h"




@interface SesameCreditViewController ()

//@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIWebView *sesameWebView;

@end

@implementation SesameCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"芝麻信用";
    
    [self.view addSubview:self.sesameWebView];

    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {

        [self.sesameWebView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIWebView *)sesameWebView {
    if (!_sesameWebView) {
        _sesameWebView = [UIWebView newAutoLayoutView];

        NSString *sesame = @"https://openauth.alipay.com/oauth2/appToAppAuth.htm?app_id=2018041102535930&redirect_uri=http://api.mlong88.vip/leaseapi/alipay";

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:sesame]];
        [_sesameWebView loadRequest:request];
        
    }
    return _sesameWebView;
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
