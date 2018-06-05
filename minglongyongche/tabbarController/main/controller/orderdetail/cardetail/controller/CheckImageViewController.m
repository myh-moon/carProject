//
//  CheckImageViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/6/4.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "CheckImageViewController.h"

@interface CheckImageViewController ()

@property (nonatomic,strong) UIScrollView *checkScrollView;

@end

@implementation CheckImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.checkScrollView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.checkScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
    [super updateViewConstraints];
}

- (UIScrollView *)checkScrollView {
    if (!_checkScrollView) {
        
    }
    return _checkScrollView;
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
