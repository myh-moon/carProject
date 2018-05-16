//
//  MyInformationViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/7.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyInformationViewController.h"
#import "MyAddressViewController.h"
#import "SesameCreditViewController.h"

#import "BaseItem.h"
#import "SeperateItem.h"

@interface MyInformationViewController ()

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.manager[@"BaseItem"] = @"BaseDoubleCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    
    [self setupMyInformationTableView];
}

- (void) setupMyInformationTableView {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    MLWeakSelf;
    
    BaseItem *item0 = [[BaseItem alloc] initWithTitle:@"头像" firstImage:@""];
    item0.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item0];
    
    BaseItem *item1 = [[BaseItem alloc] initWithTitle:@"昵称" firstImage:@"" secondText:@"用户名"];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item1];
    
    BaseItem *item2 = [[BaseItem alloc] initWithTitle:@"注册手机" firstImage:@"" secondText:@"1316252"];
    item2.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item2];
    
    BaseItem *item3 = [[BaseItem alloc] initWithTitle:@"地址管理" firstImage:@"" secondText:@"请实名认证"];
    item3.selectionStyle = UITableViewCellSelectionStyleNone;
    item3.selectionHandler = ^(id item) {
        MyAddressViewController *myAddressVC = [[MyAddressViewController alloc] init];
        [weakself.navigationController pushViewController:myAddressVC animated:YES];
    };
    [section addItem:item3];
    
    SeperateItem *item33 = [[SeperateItem alloc] init];
    item33.selectionStyle = UITableViewCellSelectionStyleNone;
    item33.cellHeight = middleSpacing;
    [section addItem:item33];
    
    BaseItem *item4 = [[BaseItem alloc] initWithTitle:@"实名认证" firstImage:@"" secondText:@"请实名认证"];
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item4];
    
    BaseItem *item5 = [[BaseItem alloc] initWithTitle:@"芝麻信用" firstImage:@"" secondText:@""];
    item5.selectionStyle = UITableViewCellSelectionStyleNone;
    item5.selectionHandler = ^(id item) {
        SesameCreditViewController *sesameCreditVC = [[SesameCreditViewController alloc] init];
        [weakself.navigationController pushViewController:sesameCreditVC animated:YES];
    };
    [section addItem:item5];
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
