//
//  MyAddressViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/25.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyAddressViewController.h"
#import "AddAddressViewController.h"

@interface MyAddressViewController ()

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系地址";
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    [self.rightNavBtn setTitle:@"添加新地址" forState:0];
    
    MLWeakSelf;
    [self.rightNavBtn addAction:^(UIButton *btn) {
        AddAddressViewController *addAddressVC = [[AddAddressViewController alloc] init];
        [weakself.navigationController pushViewController:addAddressVC animated:YES];
    }];
    
    self.pullToRefreshHandler = ^{
        weakself.pageIndex = 1;
        [weakself getAddressListWithPage:@"1"];
        [weakself.refreshTableView.mj_header endRefreshing];
    };
    
    self.pullToLoadMoreHandler = ^{
        weakself.pageIndex++;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)weakself.pageIndex];
        [weakself getAddressListWithPage:page];
        [weakself.refreshTableView.mj_footer endRefreshing];
    };
}

- (void) getAddressListWithPage:(NSString *)page {
    NSString *addressStr = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLMyAddressOfList,TOKEN,page];
    
    NSDictionary *params = @{@"type" : @"1"};
    
    MLWeakSelf;
    [self requestDataGetWithString:addressStr params:params successBlock:^(id responseObject) {
        NSLog(@"1321313");
        NSLog(@"1321313");
        NSLog(@"1321313");
        NSLog(@"1321313");
    } andFailBlock:^(NSError *error) {
        
    }];
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
