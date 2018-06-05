//
//  ShortRentViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/3.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "ShortRentViewController.h"
#import "CarDetailsViewController.h"

//view
#import "ShortConditionView.h" //

#import "CarListItem.h"
#import "BaseRemindItem.h"
#import "BaseBottomItem.h"

//model
#import "ShortRentResult.h"
#import "CarModel.h"
#import "ConditionResult.h" //查询条件
#import "ConditionModel.h"//查询条件

@interface ShortRentViewController () <RETableViewManagerDelegate>

@property (nonatomic,strong) ShortConditionView *shortConditionView;
@property (nonatomic,strong) UITableView *shortRentTableView;

@property (nonatomic,strong,readwrite)RETableViewManager *manager;

@property  (nonatomic,copy) NSMutableArray *listArray;  //短租列表

@property (nonatomic,assign) NSInteger rentPage;

@property (nonatomic,copy) NSMutableDictionary  *conditionDic;
@property (nonatomic,strong) NSMutableDictionary *parameter;

@end

@implementation ShortRentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"精选优车";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    [self.view addSubview:self.shortConditionView];
    [self.view addSubview:self.shortRentTableView];
    
    [self.view setNeedsUpdateConstraints];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.shortRentTableView];
    self.manager[@"CarListItem"] = @"CarListCell";
    self.manager[@"BaseRemindItem"] = @"BaseRemindCell";
    self.manager[@"BaseBottomItem"] = @"BaseBottomCell";
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        [self.shortConditionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.shortConditionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.shortConditionView autoPinToTopLayoutGuideOfViewController:self withInset:0];
        [self.shortConditionView autoSetDimension:ALDimensionHeight toSize:50];
        
        [self.shortRentTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.shortRentTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.shortConditionView];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (ShortConditionView *)shortConditionView {
    if (!_shortConditionView) {
        _shortConditionView  = [ShortConditionView newAutoLayoutView];
        _shortConditionView.backgroundColor = MLWhiteColor;
        
        MLWeakSelf;
        [_shortConditionView setDidSelectBtn:^(UIButton *sender) {
            if (sender.tag == 111) {//综合排序
                
                //1.隐藏弹出框
                [weakself hiddenBlurView];
                
                //2.修改相应参数
                [weakself.parameter setValue:@"0" forKey:@"type"];
                [weakself.parameter setValue:@"0" forKey:@"brand"];
                [weakself.parameter setValue:@"0" forKey:@"rent"];
                
                
                _rentPage = 1;
                [weakself getCarListOfShortRentTableViewWithPage:@"1"];
                
            }else{
                if (!sender.selected) {
                    
                    [weakself hiddenBlurView];
                    if (sender.tag == 112){//类型
                        if (!weakself.conditionDic[@"type"]) {
                            [weakself getListOfAllKindsConditionWithSolor:@"2"];
                        }else {
                            [weakself showConditionTableViewWithType:@"2"];
                        }
                    }else if (sender.tag == 113){//品牌
                        if (!weakself.conditionDic[@"brand"]) {
                            [weakself getListOfAllKindsConditionWithSolor:@"3"];
                        }else {
                            [weakself showConditionTableViewWithType:@"3"];
                        }
                    }else if (sender.tag == 114){//租金
                        if (!weakself.conditionDic[@"rent"]) {
                            [weakself getListOfAllKindsConditionWithSolor:@"4"];
                        }else {
                            [weakself showConditionTableViewWithType:@"4"];
                        }
                    }
                }else{
                    [weakself hiddenBlurView];
                }
            }
        }];
    }
    return _shortConditionView;
}

- (UITableView *)shortRentTableView {
    if (!_shortRentTableView) {
        _shortRentTableView = [UITableView newAutoLayoutView];
        _shortRentTableView.backgroundColor = MLBackGroundColor;
        _shortRentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, bigSpacing)];
        
        //刷新
        _shortRentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshOfShortRentTableView)];
        [_shortRentTableView.mj_header beginRefreshing];
        
        _shortRentTableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOfShortRentTableView)];
        [_shortRentTableView.mj_footer beginRefreshing];
    }
    return _shortRentTableView;
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}

//请求的条件字典
- (NSMutableDictionary *)conditionDic {
    if (!_conditionDic) {
        _conditionDic = [NSMutableDictionary dictionary];
    }
    return _conditionDic;
}

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
        [_parameter setValue:@"0" forKey:@"type"];
        [_parameter setValue:@"0" forKey:@"rent"];
        [_parameter setValue:@"0" forKey:@"brand"];
    }
    return _parameter;
}

#pragma mark - set up
- (void) setUpShortTableView {
    
    [self.manager removeAllSections];
    
    RETableViewSection *shortSection = [RETableViewSection section];
    shortSection.headerHeight = 0;
    shortSection.footerHeight = 0;
    [self.manager addSection:shortSection];
    
    if (self.listArray.count > 0) {
        for (NSInteger i=0; i<self.listArray.count; i++) {
            
            CarModel *carModel = self.listArray[i];
            
            CarListItem *item = [[CarListItem alloc] initWIthModel:carModel];
            
            item.carName = carModel.name;
            item.selectionStyle = UITableViewCellSelectionStyleNone;
            [shortSection addItem:item];
            
            MLWeakSelf;
            [item setSelectionHandler:^(id item) {
                CarDetailsViewController *carDetailsVC = [[CarDetailsViewController alloc] init];
                carDetailsVC.zid = carModel.zid;
                carDetailsVC.type = @"短租";
                [weakself.navigationController pushViewController:carDetailsVC animated:YES];
            }];
        }
        
        if (self.showBottom) {
            BaseBottomItem *item999 = [[BaseBottomItem alloc] init];
            item999.selectionStyle = UITableViewCellSelectionStyleNone;
            [shortSection addItem:item999];
            
            self.shortRentTableView.mj_footer = nil;
        }else{
            self.shortRentTableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOfShortRentTableView)];
        }
        
    }else{
        BaseRemindItem *item1234 = [[BaseRemindItem alloc] init];
        item1234.remindImage = @"nocar";
        item1234.remindText = @"未发现相关车辆信息";
        item1234.remindAction = @"";
        item1234.selectionStyle = UITableViewCellSelectionStyleNone;
        item1234.cellHeight = 300;
        [shortSection addItem:item1234];
    }
}

#pragma mark - refresh
//下拉刷新
- (void) headerRefreshOfShortRentTableView {
    _rentPage = 1;
    
    [self getCarListOfShortRentTableViewWithPage:@"1"];
    
    [self.shortRentTableView.mj_header endRefreshing];
}

//上拉加载
- (void) footerRefreshOfShortRentTableView {
    
    _rentPage++;
    NSString *page = [NSString stringWithFormat:@"%ld",(long)_rentPage];
    [self getCarListOfShortRentTableViewWithPage:page];
    
    [self.shortRentTableView.mj_footer endRefreshing];
}

//请求列表
- (void) getCarListOfShortRentTableViewWithPage:(NSString *)page {
    
    //参数依次是 /页数/综合排序/类型/租金/品牌。当未选择条件时，请传0（不传参数名，只传值，且顺序不能乱）
    NSString *shortRentString = [NSString stringWithFormat:@"%@%@/%@/0/%@/%@/%@",MLBaseUrl,MLShortRentList,page,self.parameter[@"type"],self.parameter[@"rent"],self.parameter[@"brand"]];
    
    MLWeakSelf;
    [self requestDataGetWithString:shortRentString params:nil successBlock:^(id responseObject) {
        
        if ([page integerValue] == 1) {
            [weakself.listArray removeAllObjects];
        }
        
        ShortRentResult *shortRent = [ShortRentResult mj_objectWithKeyValues:responseObject];
        
        for (CarModel *carModel in shortRent.lease) {
            [weakself.listArray addObject:carModel];
        }
        
        if (shortRent.lease.count < 8 && shortRent.lease.count > 0) {
            weakself.showBottom = YES;
        }else{
            weakself.showBottom = NO;
        }
        
        [weakself setUpShortTableView];
        
        [weakself.shortRentTableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

//条件查询
- (void)getListOfAllKindsConditionWithSolor:(NSString *)solor {
    NSString *comprehensiveString = [NSString stringWithFormat:@"%@%@%@",MLBaseUrl,MLShortRentCondition,solor];
    
    MLWeakSelf;
    [self requestDataGetWithString:comprehensiveString params:nil successBlock:^(id responseObject) {
        
            ConditionResult *result = [ConditionResult mj_objectWithKeyValues:responseObject];
            NSMutableArray *conArr = [NSMutableArray array];
            [conArr removeAllObjects];
        
            for (ConditionModel *conditionModel in result.types) {
                [conArr addObject:conditionModel];
            }
            NSArray *sdsd = @[@"type",@"brand",@"rent"];
            [weakself.conditionDic setValue:conArr forKey:sdsd[[solor integerValue] - 2]];
        
        [weakself showConditionTableViewWithType:solor];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

//弹出下拉框
- (void) showConditionTableViewWithType:(NSString *)tag {
    NSArray *soso = @[@"type",@"brand",@"rent"];
    NSString *pre = soso[[tag integerValue] -2];
    
    
    MLWeakSelf;
    if ([pre isEqualToString:@"type"] || [pre isEqualToString:@"rent"]) {//类型或租金
        
//        NSDictionary *ssss = @{@"name" : @"不限",@"pid" : @"0"};
//        ConditionModel *mmm = [ConditionModel mj_objectWithKeyValues:ssss];
//        [self.conditionDic[pre] addObject:mmm];
        
        
        [self showBlurViewInView:self.view array:self.conditionDic[pre] top:50 finishBlock:^(NSString *name, NSString *cid) {
            
            NSString *namaaa  = [NSString stringWithFormat:@"%@  ",name];
            if ([pre isEqualToString:@"type"]) {
                [weakself.shortConditionView.typeBtn swapOnlyImage];
                weakself.shortConditionView.typeBtn.selected = NO;
                
                [weakself.shortConditionView.typeBtn setTitle:namaaa forState:0];
            }else if ([pre isEqualToString:@"rent"]){
                [weakself.shortConditionView.rentBtn swapOnlyImage];
                weakself.shortConditionView.rentBtn.selected = NO;
                
                [weakself.shortConditionView.rentBtn setTitle:namaaa forState:0];
            }
            
            [weakself.parameter setValue:cid forKey:pre];
            [weakself headerRefreshOfShortRentTableView];
        }];
    }else {//品牌 （有两个tableview）
        
        [self showTwoBlurViewInView:self.view array:self.conditionDic[pre] top:50 finishBlock:^(NSString *name, NSString *childID) {
            NSString *namaaa  = [NSString stringWithFormat:@"%@  ",name];
            [weakself.shortConditionView.brandBtn setTitle:namaaa forState:0];
            [weakself.parameter setValue:childID forKey:pre];
            [weakself headerRefreshOfShortRentTableView];
        }];
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
