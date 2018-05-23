//
//  MLNavTableViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/22.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MLNavTableViewController.h"

@interface MLNavTableViewController ()

@end

@implementation MLNavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.remindImageButton];
    [self.view addSubview:self.navTableView];
    
    self.navManager = [[RETableViewManager alloc] initWithTableView:self.navTableView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        [self.remindImageButton autoPinToTopLayoutGuideOfViewController:self withInset:100];
        [self.remindImageButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.navTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UITableView *)navTableView {
    if (!_navTableView) {
        _navTableView = [UITableView newAutoLayoutView];
        _navTableView.tableFooterView = [UIView new];
        _navTableView.backgroundColor = MLBackGroundColor;
    }
    return _navTableView;
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
