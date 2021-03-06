//
//  PayResultViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/25.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PayResultViewController.h"
#import "MyOrderViewController.h"

#import "ResultItem.h"

#import "PayResultModel.h"

@interface PayResultViewController ()

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *tielArr = @[@"支付成功",@"在线支付",@"在线支付"];
    self.title = tielArr[ [self.payFlag integerValue] -1];
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    [self.rightNavBtn setTitle:@"完成" forState:0];
    MLWeakSelf;
    [self.rightNavBtn addAction:^(UIButton *btn) {
        UINavigationController *navvv = weakself.navigationController;
        [navvv popViewControllerAnimated:NO];
        [navvv popViewControllerAnimated:NO];
        [navvv popViewControllerAnimated:NO];
        [navvv popViewControllerAnimated:NO];
        [navvv popViewControllerAnimated:NO];
        
        MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
        myOrderVC.hidesBottomBarWhenPushed = YES;
        [navvv pushViewController:myOrderVC animated:NO];
    }];
    
    self.manager[@"ResultItem"] = @"ResultCell";
        
    [self getResultOfPay];
}

//右滑返回上一页
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

//重写
- (void)back {
    UINavigationController *navc = self.navigationController;
    [navc popViewControllerAnimated:NO];
    [navc popViewControllerAnimated:NO];
    [navc popViewControllerAnimated:NO];
}

- (void)setupResultTableViewWithModel:(PayResultModel *)model {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight  = 0;
    [self.manager addSection:section];
    
    ResultItem *item = [[ResultItem alloc] initWithPayResultModel:model result:self.payFlag];
    item.selectionStyle  = UITableViewCellSelectionStyleNone;
    item.resultFlag = self.payFlag;
    MLWeakSelf;
    [item setDidSelectedBtn:^(NSInteger tag) {
        if ([weakself.payFlag integerValue] == 2) {//立即支付
            UINavigationController *navvv = weakself.navigationController;
            [navvv popViewControllerAnimated:NO];
        }else{
            UINavigationController *navvv = weakself.navigationController;
            [navvv popViewControllerAnimated:NO];
            [navvv popViewControllerAnimated:NO];
            [navvv popViewControllerAnimated:NO];
            [navvv popViewControllerAnimated:NO];
            [navvv popViewControllerAnimated:NO];
            
            MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
            myOrderVC.hidesBottomBarWhenPushed = YES;
            [navvv pushViewController:myOrderVC animated:NO];
        }
    }];
    [section addItem:item];
}

- (void) getResultOfPay {
    NSString *payResult = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLPayResult,TOKEN,self.oid];
    
    MLWeakSelf;
    [self requestDataGetWithString:payResult params:nil successBlock:^(id responseObject) {
      
        PayResultModel *model = [PayResultModel mj_objectWithKeyValues:responseObject];
        
        [weakself setupResultTableViewWithModel:model];
        
        [weakself.tableView reloadData];

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
