//
//  MyOrderDetailViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/2.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "CarDetailsViewController.h"  //详情
#import "OrderPayViewController.h" //立即支付
#import "UIViewController+CountDownTime.h"
#import "NSTimer+Block.h"

#import "MyOrderDetailResponse.h"
#import "PreOrderModel.h"

#import "SeperateItem.h"
#import "MyOrderDetailTextItem.h"
#import "MyOrderDetailProcessItem.h"
#import "MyOrderDetailAddressItem.h"
#import "MyOrderDetailDurationItem.h"
#import "MyOrderDetailNumberItem.h"
#import "BaseItem.h"
#import "MyOrderDetailActionItem.h"

@interface MyOrderDetailViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *listlist;

@end

@implementation MyOrderDetailViewController

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.manager[@"MyOrderDetailTextItem"] = @"MyOrderDetailTextCell";
    self.manager[@"MyOrderDetailProcessItem"] = @"MyOrderDetailProcessCell";
    self.manager[@"MyOrderDetailAddressItem"] = @"MyOrderDetailAddressCell";
    self.manager[@"MyOrderDetailDurationItem"] = @"MyOrderDetailDurationCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    self.manager[@"MyOrderDetailNumberItem"] = @"MyOrderDetailNumberCell";
    self.manager[@"BaseItem"] = @"MyOrderDetailBaseCell";
    self.manager[@"MyOrderDetailActionItem"] = @"MyOrderDetailActionCell";
    
    [self getMyOrderDetail];
}

- (void) setupMyOrderdetailTableViewWithResponse:(MyOrderDetailResponse *)response {
    RETableViewSection *section = [RETableViewSection section];
    section.footerHeight = 0;
    section.headerHeight = 0;
    [self.manager addSection:section];
    
    //text
    MyOrderDetailTextItem *item1 = [[MyOrderDetailTextItem alloc] initWithModel:response];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item1];
    
    CarModel *orderModel = response.order;
    
    SeperateItem *item11 = [[SeperateItem alloc] init];
    item11.cellHeight = smallSpacing;
    item11.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item11];
    
    //process
    MyOrderDetailProcessItem  *item2 = [[MyOrderDetailProcessItem alloc] initWithProcessStatus:orderModel.statuss];
    item2.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item2];
    
    SeperateItem *item22 = [[SeperateItem alloc] init];
    item22.cellHeight = smallSpacing;
    item22.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item22];
    
    //address
    MyOrderDetailAddressItem *item3 = [[MyOrderDetailAddressItem alloc] initWithOrderAddress:orderModel.qcaddress];
    item3.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item3];
    
    //time
    MyOrderDetailDurationItem *item4 = [[MyOrderDetailDurationItem alloc] initWithStartTime:orderModel.qctime endTime:orderModel.hctime];
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item4];
    
    SeperateItem *item44 = [[SeperateItem alloc] init];
    item44.cellHeight = smallSpacing;
    item44.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item44];
    
    /*************** 订单信息  ***************/
    BaseItem *item5 = [[BaseItem alloc] init];
    item5.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item5];
    
    //1.订单号
    MyOrderDetailNumberItem *item6 = [[MyOrderDetailNumberItem alloc] initWithInfo:@"订单号" detailString:orderModel.oid];
    item6.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item6];
    
    
    //2.下单时间
    MyOrderDetailNumberItem *item7 = [[MyOrderDetailNumberItem alloc] initWithInfo:@"下单时间" detailString:orderModel.addtime];
    item7.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item7];
    
    //支付方式
    MyOrderDetailNumberItem *item8 = [[MyOrderDetailNumberItem alloc] initWithInfo:@"支付方式" detailString:@"微信支付"];
    item8.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item8];
    
    //租车人
    MyOrderDetailNumberItem *item9 = [[MyOrderDetailNumberItem alloc] initWithInfo:@"租车人" detailString:orderModel.uid];
    item9.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item9];
    
    //订单金额
    MyOrderDetailNumberItem *item10 = [[MyOrderDetailNumberItem alloc] initWithInfo:@"订单金额" detailString:orderModel.money];
    item10.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item10];
    
    //用车押金
    MyOrderDetailNumberItem *item12 = [[MyOrderDetailNumberItem alloc] initWithInfo:@"用车押金（到店支付）" detailString:orderModel.ymoney];
    item12.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item12];
    
    //action
    MyOrderDetailActionItem *item13 = [[MyOrderDetailActionItem alloc] initWithMyOrderStatus:orderModel.statuss countDownTime:orderModel.times];
    item13.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //倒计时
    MLWeakSelf;
    [_timer addAction:^(NSTimer *timer) {
        if ([response.order.statuss integerValue] == 0) {
            NSDate *datenow = [NSDate date];//现在时间
            NSString *nowTime = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            
            //2.计算差值
            NSInteger value = [response.order.times integerValue] - [nowTime integerValue];
            
            if (value > 0) {//倒计时未结束
                value--;
                NSString *sssss = [NSString stringWithFormat:@"倒计时%02ld:%02ld:%02ld\n",value/3600,(value%3600)/60,value%60];
                NSLog(@"*********%@******",sssss);
                item13.countDownTimeString = sssss;
            }
        }
    }];
//    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(startTheCountDown) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    

    item13.didSelectedAction = ^(NSString *acttionType) {
        if ([acttionType isEqualToString:@"删除订单"]) {
            [weakself deleteOrCancelTheOrderWithID:orderModel.ID action:@"删除"];
        }else if ([acttionType isEqualToString:@"取消订单"]){
            [weakself deleteOrCancelTheOrderWithID:orderModel.ID action:@"取消"];
        }else if ([acttionType isEqualToString:@"重新下单"]){
            [weakself reOrderOrImmediatePaymentWithResponse:response withType:@"1"];
        }else if ([acttionType isEqualToString:@"立即支付"]){
            [weakself reOrderOrImmediatePaymentWithResponse:response withType:@"2"];
        }
    };
    [section addItem:item13];
    
}

- (NSMutableArray *)listlist {
    if (!_listlist) {
        _listlist = [NSMutableArray array];
    }
    return _listlist;
}

#pragma mark - method
- (void) getMyOrderDetail {
    NSString *myOrderDetailString = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLMyOrderOfDetail,TOKEN,self.oid];
    
    MLWeakSelf;
    [self requestDataGetWithString:myOrderDetailString params:nil successBlock:^(id responseObject) {
        
        MyOrderDetailResponse *response = [MyOrderDetailResponse mj_objectWithKeyValues:responseObject];
        
        if ([response.status isEqualToString:@"200"]) {
            
            [weakself.listlist addObject:response];
            
            [weakself setupMyOrderdetailTableViewWithResponse:response];
            
            [weakself.tableView reloadData];
        }
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

//删除订单 取消订单
- (void) deleteOrCancelTheOrderWithID:(NSString *)oid action:(NSString *)action{
    
    NSString *actStr;
    if ([action isEqualToString:@"删除"]) {
        actStr = [NSString stringWithFormat:@"%@%@%@",MLBaseUrl,MLMyOrderOfDelete,TOKEN];
    }else if ([action isEqualToString:@"取消"]){
        actStr = [NSString stringWithFormat:@"%@%@%@",MLBaseUrl,MLMyOrderOfCancel,TOKEN];
    }
    
    NSDictionary *params = @{@"oid" : oid};
    
    MLWeakSelf;
    [self requestDataPostWithString:actStr params:params successBlock:^(id responseObject) {
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:model.info];
        
        if ([model.status integerValue] == 200) {
            if (weakself.didRefreshMessages) {
                [weakself.navigationController popViewControllerAnimated:YES];
                weakself.didRefreshMessages(@"refresh");
            }
            
        }
    } andFailBlock:^(NSError *error) {
        
    }];
}

//重新下单 或 立即支付
- (void)reOrderOrImmediatePaymentWithResponse:(MyOrderDetailResponse *)response withType:(NSString *)type{
    UINavigationController *nav = self.navigationController;
    [nav popViewControllerAnimated:NO];
    [nav popViewControllerAnimated:NO];
    
    if ([type integerValue] == 1) {//重新下单
        CarDetailsViewController *carDetailsVC = [[CarDetailsViewController alloc] init];
        carDetailsVC.hidesBottomBarWhenPushed = YES;
        carDetailsVC.zid = response.order.aid;
        [nav pushViewController:carDetailsVC animated:NO];
    }else{//立即支付
        OrderPayViewController *orderPayVC = [[OrderPayViewController alloc] init];
        
        PreOrderModel *preOrderModel = [[PreOrderModel alloc] init];
        preOrderModel.pic = response.pic;
        preOrderModel.name = response.name;
        preOrderModel.belong = response.belong;
        preOrderModel.is_auto = response.is_auto;
        preOrderModel.site = response.site;
        preOrderModel.money = response.order.money;
        preOrderModel.ymoney = response.order.ymoney;
        
        preOrderModel.oid = response.order.ID;
        
        orderPayVC.preOrderModel = preOrderModel;
        orderPayVC.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:orderPayVC animated:YES];
    }
}


//倒计时

- (void)startTheCountDown {
    
    MyOrderDetailResponse *response = self.listlist[0];
    
    if ([response.order.statuss integerValue] == 0) {
        NSDate *datenow = [NSDate date];//现在时间
        NSString *nowTime = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        
        //2.计算差值
        NSInteger value = [response.order.times integerValue] - [nowTime integerValue];
        
        if (value > 0) {//倒计时未结束
            value--;
            NSString *sssss = [NSString stringWithFormat:@"倒计时%02ld:%02ld:%02ld\n",value/3600,(value%3600)/60,value%60];
            NSLog(@"*********%@******",sssss);
        }
    }
    
}


//- (void) timerStartWithTime:(NSTimer *)timer{
//    NSInteger sttttt = [self.item.countDownTimeString integerValue];
//    sttttt--;
//
//    NSString *sssss = [NSString stringWithFormat:@"倒计时%02ld:%02ld:%02ld\n",sttttt/3600,(sttttt%3600)/60,sttttt%60];
//
//    [self.countDownButton setAttributedTitle:[NSString setFirstPart:sssss firstFont:13 firstColor:MLOrangeColor secondPart:@"将自动关闭订单" secondFont:13 secongColor:MLOrangeColor space:4 align:0] forState:0];
//
//    if (sttttt == 0) {
//        [self.countDownButton setAttributedTitle:[NSString setFirstPart:@"倒计时00:00:00" firstFont:13 firstColor:MLDrakGrayColor secondPart:@"订单已过期" secondFont:13 secongColor:MLDrakGrayColor space:4 align:0] forState:0];
//    }
//}

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
