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

@interface MineViewController ()<UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL isLoginr;  //判定是否登录

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setupMineTableView];
    [self.navTableView reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    
    self.navigationController.delegate = self;
    
    self.navManager[@"UserItem"] = @"UserCell";
    self.navManager[@"BaseItem"] = @"BaseDoubleCell";  //我的订单
    self.navManager[@"SeperateItem"] = @"SeperateCell"; //
    
    [self setupMineTableView];
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark - method
- (void)setupMineTableView {
    
    [self.navManager removeAllSections];
    
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.navManager addSection:section];
    
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
            [weakself judgeLoginStatesOfType:1];
        }else if (tag == 88) {//修改用户名|| 登录
            [weakself judgeLoginStatesOfType:2];
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
    
    SeperateItem *item00 = [[SeperateItem alloc] init];
    item00.selectionStyle = UITableViewCellSelectionStyleNone;
    item00.cellHeight = smallSpacing;
    [section addItem:item00];
    
    BaseItem *item1 = [[BaseItem alloc] initWithTitle:@"    我的收藏" firstImage:@"collection_02" secondText:@""];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    item1.displaySeparate = NO;
    item1.selectionHandler = ^(id item) {
//        [weakself judgeLoginStatesOfType:3];
        MyCollectionViewController *myCollectionVC = [[MyCollectionViewController alloc] init];
        myCollectionVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:myCollectionVC animated:YES];
    };
    [section addItem:item1];
    
    SeperateItem *item11 = [[SeperateItem alloc] init];
    item11.selectionStyle = UITableViewCellSelectionStyleNone;
    item11.cellHeight = smallSpacing;
    [section addItem:item11];
    
    //我的订单
    BaseItem *item2 = [[BaseItem alloc] initWithTitle:@"    我的订单" firstImage:@"mine_order" secondText:@""];
    item2.selectionStyle = UITableViewCellSelectionStyleNone;
    item2.displaySeparate = NO;
    item2.selectionHandler = ^(id item) {
//        [weakself judgeLoginStatesOfType:4];
        MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
        myOrderVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:myOrderVC animated:YES];
    };
    [section addItem:item2];
    
    SeperateItem *item22 = [[SeperateItem alloc] init];
    item22.selectionStyle = UITableViewCellSelectionStyleNone;
    item22.cellHeight = smallSpacing;
    [section addItem:item22];
    
//    NSArray *asArr = @[@"    邀请有礼",@"    关于鸣垄",@"    联系客服"];
//    NSArray *imArr = @[@"mine_gift",@"mine_about",@"mine_service"];
    
    
    
    BaseItem *item3 = [[BaseItem alloc] initWithTitle:@"    关于鸣垄" firstImage:@"mine_about" secondText:@""];
    item3.selectionStyle = UITableViewCellSelectionStyleNone;
    item3.displaySeparate = YES;
    [section addItem:item3];
    item3.selectionHandler = ^(id item) {
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        aboutVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:aboutVC animated:YES];
    };
//
    BaseItem *item4 = [[BaseItem alloc] initWithTitle:@"    联系客服" firstImage:@"mine_service" secondText:@""];
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    item4.displaySeparate = NO;
    [section addItem:item4];
    item4.selectionHandler = ^(id item) {
        UIAlertController *phoneAlertController = [UIAlertController alertControllerWithTitle:@"拨打客服电话?" message:@"021-62127903" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
        [phoneAlertController addAction:action0];

        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"继续" style:0 handler:^(UIAlertAction * _Nonnull action) {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"021-62127903"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        [phoneAlertController addAction:action1];

        [weakself presentViewController:phoneAlertController animated:YES completion:nil];
    };
    
    SeperateItem *item44 = [[SeperateItem alloc] init];
    item44.selectionStyle = UITableViewCellSelectionStyleNone;
    item44.cellHeight = smallSpacing;
    [section addItem:item44];
    
    BaseItem *item5 = [[BaseItem alloc] initWithTitle:@"    我的优惠券" firstImage:@"mine_discounts" secondText:@""];
    item5.selectionStyle = UITableViewCellSelectionStyleNone;
    item5.displaySeparate = NO;
    item5.selectionHandler = ^(id item) {
//        [weakself judgeLoginStatesOfType:5];
        MyTicketViewController *myTicketVC = [[MyTicketViewController alloc] init];
        myTicketVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:myTicketVC animated:YES];
    };
    [section addItem:item5];
}

- (void)judgeLoginStatesOfType:(NSInteger )type {
    if (!TOKEN) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        if (type == 1) {
            MySettingViewController *mySettingVC = [[MySettingViewController alloc] init];
            mySettingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mySettingVC animated:YES];
        }else if (type == 2){
//            MyInformationViewController *myInformationVC = [[MyInformationViewController alloc] init];
//            myInformationVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:myInformationVC animated:YES];
        }else if (type == 3){
            MyCollectionViewController *myCollectionVC = [[MyCollectionViewController alloc] init];
            myCollectionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myCollectionVC animated:YES];
        }else if (type == 4){
            MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
            myOrderVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myOrderVC animated:YES];
        }else if (type == 5){
            MyTicketViewController *myTicketVC = [[MyTicketViewController alloc] init];
            myTicketVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myTicketVC animated:YES];
        }
    }
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
