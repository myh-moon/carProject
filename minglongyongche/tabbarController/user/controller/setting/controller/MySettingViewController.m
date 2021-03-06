//
//  MySettingViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MySettingViewController.h"
#import "RegisterAgreementViewController.h"

#import "BaseItem.h"
#import "SeperateItem.h"
#import "SettingItem.h"

@interface MySettingViewController ()

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.manager[@"BaseItem"] = @"BaseDoubleCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    self.manager[@"SettingItem"] = @"SettingCell";
    
    [self setupMySettingTableView];
}

- (void)setupMySettingTableView {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    
//    BaseItem *item0 = [[BaseItem alloc] initWithTitle:@"个人信息" firstImage:@"" secondText:@"基本资料修改 "];
//    item0.selectionStyle = UITableViewCellSelectionStyleNone;
//    [section addItem:item0];
    
//    BaseItem *item1 = [[BaseItem alloc] initWithTitle:@"更改手机密码" firstImage:@"" secondText:@"重置登录密码 "];
//    item1.selectionStyle = UITableViewCellSelectionStyleNone;
//    [section addItem:item1];
    
    
    NSUInteger ssss = [SDImageCache sharedImageCache].getSize;
    float displaySize = ssss/1000/1000 + ssss/1000%1000*0.001;
    NSString *huancun = [NSString stringWithFormat:@"缓存%.2fM",displaySize];

    BaseItem *item2 = [[BaseItem alloc] initWithTitle:huancun firstImage:@"" secondText:@""];
    item2.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item2];
    
    MLWeakSelf;
    
    item2.selectionHandler = ^(id item) {
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
            [weakself showHint:@"清除完成"];
//            item2.firstTitleString = @"缓存0.00M";
            
            [weakself.manager removeAllSections];
            
            [weakself setupMySettingTableView];
            [weakself.tableView reloadData];
        }];
        
//        [weakself.tableView reloadData];
//        [weakself setupMySettingTableView];
        
//
//        NSUInteger ssss = [SDImageCache sharedImageCache].getSize;
//        double displaySize = ssss/1000/1000;
//
//        NSString *huancun = [NSString stringWithFormat:@"缓存%.1fM",displaySize];
//        NSLog(@"清理缓存 %f",displaySize);
    };
    
    
    SeperateItem *item11 = [[SeperateItem alloc] init];
    item11.selectionStyle = UITableViewCellSelectionStyleNone;
    item11.cellHeight = smallSpacing;
    [section addItem:item11];
    
//    BaseItem *item2 = [[BaseItem alloc] initWithTitle:@"常见问题" firstImage:@"" secondText:@""];
//    item2.selectionStyle = UITableViewCellSelectionStyleNone;
//    [section addItem:item2];
    
    BaseItem *item3 = [[BaseItem alloc] initWithTitle:@"鸣垄名车用户协议" firstImage:@"" secondText:@""];
    item3.selectionStyle = UITableViewCellSelectionStyleNone;
    item3.selectionHandler = ^(id item) {
        RegisterAgreementViewController *registerAgreementVC = [[RegisterAgreementViewController alloc] init];
        registerAgreementVC.category = @"用户协议";
        [weakself.navigationController pushViewController:registerAgreementVC animated:YES];
    };
    [section addItem:item3];
    
    
    SeperateItem *item33 = [[SeperateItem alloc] init];
    item33.selectionStyle = UITableViewCellSelectionStyleNone;
    item33.cellHeight = bigSpacing;
    [section addItem:item33];
    
    
    SettingItem *item4 = [[SettingItem alloc] init];
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    item4 .selectionHandler = ^(id item) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authen"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [weakself.navigationController popViewControllerAnimated:YES];
    };
    [section addItem:item4];
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
