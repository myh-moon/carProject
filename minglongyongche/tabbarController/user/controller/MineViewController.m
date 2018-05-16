//
//  MineViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MineViewController.h"
#import "MySettingViewController.h"
#import "MyTicketViewController.h"  //优惠券
#import "MyAccountViewController.h"  //充值余额
#import "MyWordViewController.h"  //口令
#import "MyOrderViewController.h"  //我的订单
#import "MyIllegalViewController.h"  //违章记录
#import "LoginViewController.h"  //登录
#import "AuthenViewController.h" //认证
#import "AuthCompleteViewController.h"
#import "MyCollectionViewController.h"  //收藏
#import "AboutViewController.h"  //关于鸣垄
#import "MyInformationViewController.h" // 用户资料



#import "UserItem.h"
//#import "UserAccountItem.h"
#import "BaseItem.h"
#import "SeperateItem.h"

#import "UserInformationModel.h"

@interface MineViewController ()

@property (nonatomic,assign) BOOL isLoginr;  //判定是否登录

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self setupMineTableView];
    [self.tableView reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    
    self.manager[@"UserItem"] = @"UserCell";
    self.manager[@"BaseItem"] = @"BaseDoubleCell";  //我的订单
    self.manager[@"SeperateItem"] = @"SeperateCell"; //
    
    [self setupMineTableView];
}

- (void)setupMineTableView {
    
    [self.manager removeAllSections];
    
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    MLWeakSelf;
    //用户信息
    UserItem *item0 = [[UserItem alloc] init];
    
    if (TOKEN) {
        item0.userName = [NSString stringWithFormat:@"%@ ",[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]];
    }else{
        item0.userName = @"未登录，请登录  ";
    }
    
    item0.selectionStyle = UITableViewCellSelectionStyleNone;
    [item0 setDidSelectedBtn:^(NSInteger tag) {
        if (tag == 87) {//设置
            if (!TOKEN) {
                [weakself judgeUserLoginState];
            }else{
                MySettingViewController *mySettingVC = [[MySettingViewController alloc] init];
                mySettingVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:mySettingVC animated:YES];
            }
        }else if (tag == 88) {//修改用户名|| 登录
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]) {//进入个人中心
                MyInformationViewController *myInformationVC = [[MyInformationViewController alloc] init];
                myInformationVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:myInformationVC animated:YES];
            }else{
                [weakself judgeUserLoginState];
            }
        }else {//认证
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"authen"] isEqualToString:@"200"]) {
                AuthCompleteViewController *authCompleteVC = [[AuthCompleteViewController alloc] init];
                authCompleteVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:authCompleteVC animated:YES];
            }else{
                AuthenViewController *authenVC = [[AuthenViewController alloc] init];
                authenVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:authenVC animated:YES];
            }
        }
    }];
    [section addItem:item0];
    
//    //用户资金
//    UserAccountItem *item1 = [[UserAccountItem alloc] init];
//    [item1 setDidClickBtn:^(NSInteger tag) {
//        if (tag == 45) {//收藏
//            [weakself showHint:@"收藏"];
//
//            MyCollectionViewController *myCollectionVC = [[MyCollectionViewController alloc] init];
//            myCollectionVC.hidesBottomBarWhenPushed = YES;
//            [weakself.navigationController pushViewController:myCollectionVC animated:YES];
//        }else if (tag == 46){//未处理违章
//            [weakself showHint:@"未处理违章"];
////            MyAccountViewController *myAccountVC = [[MyAccountViewController alloc] init];
////            myAccountVC.hidesBottomBarWhenPushed = YES;
////            [weakself.navigationController pushViewController:myAccountVC animated:YES];
//
//            MyIllegalViewController *myIllegalVC = [[MyIllegalViewController alloc] init];
//            myIllegalVC.hidesBottomBarWhenPushed = YES;
//            [weakself.navigationController pushViewController:myIllegalVC animated:YES];
//
//        }else{//我的钱包
//            [weakself showHint:@"我的钱包"];
////            MyWordViewController *myWordVC = [[MyWordViewController alloc] init];
////            myWordVC.hidesBottomBarWhenPushed = YES;
////            [weakself.navigationController pushViewController:myWordVC animated:YES];
//
//            MyAccountViewController *myAccountVC = [[MyAccountViewController alloc] init];
//            myAccountVC.hidesBottomBarWhenPushed = YES;
//            [weakself.navigationController pushViewController:myAccountVC animated:YES];
//
//        }
//    }];
//    [section addItem:item1];
    
//    SeperateItem *item00 = [[SeperateItem alloc] init];
//    item0.cellHeight = smallSpacing;
//    [section addItem:item00];
    
    BaseItem *item1 = [[BaseItem alloc] initWithTitle:@"    我的收藏" firstImage:@"mine_collection" secondText:@""];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    item1.selectionHandler = ^(id item) {
        if (!TOKEN) {
            [weakself judgeUserLoginState];
        }else{
            MyCollectionViewController *myCollectionVC = [[MyCollectionViewController alloc] init];
            myCollectionVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:myCollectionVC animated:YES];
        }
    };
    [section addItem:item1];
    
    SeperateItem *item11 = [[SeperateItem alloc] init];
    item11.selectionStyle = UITableViewCellSelectionStyleNone;
    item11.cellHeight = smallSpacing;
    [section addItem:item11];
    
    //我的订单
    BaseItem *item2 = [[BaseItem alloc] initWithTitle:@"    我的订单" firstImage:@"mine_order" secondText:@""];
    item2.selectionStyle = UITableViewCellSelectionStyleNone;
    item2.selectionHandler = ^(id item) {
        if (!TOKEN) {
            [weakself judgeUserLoginState];
        }else{
            MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
            myOrderVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:myOrderVC animated:YES];
        }
    };
    [section addItem:item2];
    
    SeperateItem *item22 = [[SeperateItem alloc] init];
    item22.selectionStyle = UITableViewCellSelectionStyleNone;
    item22.cellHeight = smallSpacing;
    [section addItem:item22];
    
//    NSArray *asArr = @[@"    邀请有礼",@"    关于鸣垄",@"    联系客服"];
//    NSArray *imArr = @[@"mine_gift",@"mine_about",@"mine_service"];
    NSArray *asArr = @[@"    关于鸣垄",@"    联系客服"];
    NSArray *imArr = @[@"mine_about",@"mine_service"];
    for (NSInteger i=0; i<2; i++) {
        BaseItem *item3 = [[BaseItem alloc] initWithTitle:asArr[i] firstImage:imArr[i] secondText:@""];
        item3.selectionStyle = UITableViewCellSelectionStyleNone;
        [section addItem:item3];
        
            item3.selectionHandler = ^(id item) {
                if (i == 0) {//关于鸣垄
                    AboutViewController *aboutVC = [[AboutViewController alloc] init];
                    aboutVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:aboutVC animated:YES];
                }else  if (i == 1) {//联系客服
                    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"021-62127903"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
            };
    }
    
    SeperateItem *item33 = [[SeperateItem alloc] init];
    item33.cellHeight = smallSpacing;
    [section addItem:item33];
    
    BaseItem *item4 = [[BaseItem alloc] initWithTitle:@"    我的优惠券" firstImage:@"mine_discounts" secondText:@""];
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    item4.selectionHandler = ^(id item) {
        if (!TOKEN) {
            [weakself judgeUserLoginState];
        }else{
            MyTicketViewController *myTicketVC = [[MyTicketViewController alloc] init];
            myTicketVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:myTicketVC animated:YES];
        }
    };
    [section addItem:item4];
}

- (void) judgeUserLoginState {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:loginVC animated:YES completion:nil];
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
