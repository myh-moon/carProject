//
//  ActivityDetailViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/12.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()

@property (nonatomic,strong) UIWebView *activityWebView;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"平台活动";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
//    [self.rightNavBtn setTitle:@"分享" forState:0];

    [self.view addSubview:self.activityWebView];
    
    [self setNeedsFocusUpdate];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        [self.activityWebView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.activityWebView autoPinToTopLayoutGuideOfViewController:self withInset:0];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIWebView *)activityWebView {
    if (!_activityWebView) {
        _activityWebView = [UIWebView newAutoLayoutView];        
        NSString *wwewe = @"https://d.xiumi.us/board/v5/2i2MU/90440653";
        NSURL *erere = [NSURL URLWithString:wwewe];
        [_activityWebView loadRequest:[NSURLRequest requestWithURL:erere]];
        
    }
    return _activityWebView;
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
