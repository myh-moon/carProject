//
//  AuthCompleteViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AuthCompleteViewController.h"
#import "AuthenCompleteItem.h"

@interface AuthCompleteViewController ()

@end

@implementation AuthCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证结果";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.tableView.backgroundColor = MLWhiteColor;
    self.manager[@"AuthenCompleteItem"] = @"AuthenCompleteCell";
    
    [self setupMyAuthenResultTableView];
}

- (void) setupMyAuthenResultTableView {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    AuthenCompleteItem *item0 = [[AuthenCompleteItem alloc] init];
    item0.selectionStyle = UITableViewCellSelectionStyleNone;
    MLWeakSelf;
    item0.didSelectedBtn = ^(NSInteger tag) {
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    [section addItem:item0];
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
