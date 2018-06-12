//
//  MyOrderViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/10.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderDetailViewController.h"
#import "ShortRentViewController.h"

#import "MyOrderConditionView.h"

#import "OrderItem.h"
#import "SeperateItem.h"
#import "BaseRemindItem.h"
#import "BaseBottomItem.h"

#import "MyOrderResponse.h"
#import "CarModel.h"

@interface MyOrderViewController ()<RETableViewManagerDelegate>

@property (nonatomic,strong) MyOrderConditionView *conditionView;
@property (nonatomic,strong) UITableView *myOrderTableView;
@property (nonatomic,strong) RETableViewManager *manager;
@property (nonatomic,strong) NSMutableArray *myOrderList;
@property (nonatomic,strong) NSString *orderType;
@property (nonatomic,assign) NSInteger pageOrder;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    [self.view addSubview:self.conditionView];
    [self.view addSubview:self.myOrderTableView];
    
    [self.view setNeedsUpdateConstraints];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.myOrderTableView];
    self.manager[@"OrderItem"] = @"MyNewOrderCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    self.manager[@"BaseRemindItem"] = @"BaseRemindCell";
    self.manager[@"BaseBottomItem"] = @"BaseBottomCell";

    self.orderType = @"-1";
}

//配置
#pragma mark - config
- (void) configMyOrderList {
    [self.manager removeAllSections];
    
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [_manager addSection:section];
    
    
    MLWeakSelf;
    if (self.myOrderList.count > 0) {
        for (NSInteger i=0; i<self.myOrderList.count; i++) {
            
            SeperateItem *item00 = [[SeperateItem alloc] init];
            item00.cellHeight = middleSpacing;
            item00.selectionStyle = UITableViewCellSelectionStyleNone;
            [section addItem:item00];
            
            CarModel *orderModel = self.myOrderList[i];
            OrderItem *item = [[OrderItem alloc] initWithOrderModel:orderModel];
            item.selectionStyle = UITableViewCellSelectionStyleNone;
            item.selectionHandler = ^(id item) {
                MyOrderDetailViewController *myOrderDetailVC = [[MyOrderDetailViewController alloc] init];
                myOrderDetailVC.oid = orderModel.oid;
                [myOrderDetailVC setDidRefreshMessages:^(NSString *message) {
                    if ([message isEqualToString:@"refresh"]) {
                        [weakself headerRefreshOfMyOrderList];
                    }
                }];
                [weakself.navigationController pushViewController:myOrderDetailVC animated:YES];
            };
            [section addItem:item];
        }
        
        if (self.showBottom) {
            BaseBottomItem *item999 = [[BaseBottomItem alloc] init];
            item999.selectionStyle = UITableViewCellSelectionStyleNone;
            [section addItem:item999];
            
            self.myOrderTableView.mj_footer = nil;
        }else {
            self.myOrderTableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOfMyOrderList)];
        }
    }else{
        BaseRemindItem *item1234 = [[BaseRemindItem alloc] init];
        item1234.remindImage = @"noorder";
        item1234.remindText = @"暂无相关订单";
        item1234.remindAction = @"去逛逛";
        item1234.selectionStyle = UITableViewCellSelectionStyleNone;
        item1234.cellHeight = 400;
        [section addItem:item1234];
        item1234.didSelectedAction = ^(NSString *action) {
            UINavigationController *nav = weakself.navigationController;
            [nav popViewControllerAnimated:NO];
    
            ShortRentViewController *shortRentVC = [[ShortRentViewController alloc] init];
            shortRentVC.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:shortRentVC animated:NO];
        };
    }
}

- (void)updateViewConstraints{
    if (!self.didSetupConstraints) {
        
        [self.conditionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.conditionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.conditionView autoPinToTopLayoutGuideOfViewController:self withInset:0];
        [self.conditionView autoSetDimension:ALDimensionHeight toSize:50];
        
        [self.myOrderTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.myOrderTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.conditionView];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (MyOrderConditionView *)conditionView {
    if (!_conditionView) {
        _conditionView = [MyOrderConditionView newAutoLayoutView];
        [_conditionView.firstButton setTitle:@"全部" forState:0];
        [_conditionView.secondButton setTitle:@"未付款" forState:0];
        [_conditionView.thirdButton setTitle:@"进行中" forState:0];
        [_conditionView.fourthButton setTitle:@"已完成" forState:0];
        
        MLWeakSelf;
        [_conditionView setDidChooseBtn:^(NSInteger tag) {
            weakself.orderType = [NSString stringWithFormat:@"%ld",tag-446];
            [weakself headerRefreshOfMyOrderList];
        }];
    }
    return _conditionView;
}

- (UITableView *)myOrderTableView {
    if (!_myOrderTableView) {
        _myOrderTableView = [UITableView newAutoLayoutView];
        _myOrderTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MLWindowWidth, bigSpacing)];
        _myOrderTableView.backgroundColor = MLBackGroundColor;
        
        _myOrderTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshOfMyOrderList)];
        [_myOrderTableView.mj_header beginRefreshing];
        
        _myOrderTableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOfMyOrderList)];
        [_myOrderTableView.mj_footer beginRefreshing];
        
    }
    return _myOrderTableView;
}

#pragma mark - method
- (void)headerRefreshOfMyOrderList {
    
    self.pageOrder = 1;
    
    [self getListOfMyOrderWithPage:@"1"];
    
    [self.myOrderTableView.mj_header endRefreshing];
}

- (void)footerRefreshOfMyOrderList {
    self.pageOrder++;
    
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.pageOrder];
    
    [self getListOfMyOrderWithPage:page];
    
    [self.myOrderTableView.mj_footer endRefreshing];
}

- (void) getListOfMyOrderWithPage:(NSString *)page {
    NSString *orderListStr;
    NSString *tokenn = TOKEN?TOKEN:@"";
    if ([self.orderType isEqualToString:@"-1"]) {
        orderListStr = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLOrderOfList,tokenn,page];
    }else{
        orderListStr = [NSString stringWithFormat:@"%@%@%@/%@/%@",MLBaseUrl,MLOrderOfList,tokenn,page,self.orderType];
    }
    
    MLWeakSelf;
    [self requestDataGetWithString:orderListStr params:nil successBlock:^(id responseObject) {
        
        if ([page integerValue] == 1) {
            [weakself.myOrderList removeAllObjects];
        }
        
        MyOrderResponse *response = [MyOrderResponse mj_objectWithKeyValues:responseObject];
        
//        [weakself showHint:response.info];
        
        for (CarModel *orderModel in response.order) {
            [weakself.myOrderList addObject:orderModel];
        }
        
        if (response.order.count < 8 && response.order.count > 0) {
            weakself.showBottom = YES;
        }else{
            weakself.showBottom = NO;
        }
        
        [weakself configMyOrderList];
        
        [weakself.myOrderTableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

- (NSMutableArray *)myOrderList {
    if(!_myOrderList){
        _myOrderList = [NSMutableArray array];
    }
    return _myOrderList;
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
