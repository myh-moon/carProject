//
//  RegisterAgreementViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/22.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "RegisterAgreementViewController.h"
#import "BaseModel.h"

@interface RegisterAgreementViewController ()

@property (nonatomic,strong) UIWebView *registerWebView;

@end

@implementation RegisterAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.category isEqualToString:@"用户协议"]) {
        self.title = self.category;
    }else{
        self.title = @"注册协议";
    }
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    [self.view addSubview:self.registerWebView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)back {
    if ([self.category isEqualToString:@"用户协议"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {

        [self.registerWebView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.registerWebView autoPinToTopLayoutGuideOfViewController:self withInset:0];

        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIWebView *)registerWebView {
    if (!_registerWebView) {
        _registerWebView = [UIWebView newAutoLayoutView];
        _registerWebView.backgroundColor = MLBackGroundColor;
        NSString *agreementStr = [NSString stringWithFormat:@"%@%@",MLBaseUrl,MLRegisterAgreenment];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:agreementStr]];
        [_registerWebView loadRequest:request];
    }
    return _registerWebView;
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
