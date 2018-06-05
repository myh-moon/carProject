//
//  MyTicketViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyTicketViewController.h"

#import "ConditionView.h"

#import "TicketItem.h"
#import "SeperateItem.h"
#import "BaseRemindItem.h"
#import "BaseBottomItem.h"

#import "TicketResponse.h"
#import "TicketModel.h"

@interface MyTicketViewController ()<RETableViewManagerDelegate>

@property (nonatomic,strong) ConditionView *conditionView;
@property (nonatomic,strong) UITableView *myTicketTableView;

@property (nonatomic,strong,readwrite) RETableViewManager *manager;

@property (nonatomic,strong) NSMutableArray *ticketList;

@property (nonatomic,assign) NSInteger pageTicket;

@property (nonatomic,copy) NSString *ticketType;
@end

@implementation MyTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠券";
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.ticketType = @"0";
    
    [self.view addSubview:self.conditionView];
    [self.view addSubview:self.myTicketTableView];
    
    [self.view setNeedsUpdateConstraints];
    
    _manager = [[RETableViewManager alloc] initWithTableView:self.myTicketTableView];
    _manager[@"TicketItem"] = @"TicketCell";
    _manager[@"SeperateItem"] = @"SeperateCell";
    _manager[@"BaseRemindItem"] = @"BaseRemindCell";
    _manager[@"BaseBottomItem"] = @"BaseBottomCell";
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        [self.conditionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.conditionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.conditionView autoPinToTopLayoutGuideOfViewController:self withInset:0];
        [self.conditionView autoSetDimension:ALDimensionHeight toSize:50];
        
        [self.myTicketTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.myTicketTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.conditionView];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark- config
- (void) configTicketTableView {
    
    [self.manager removeAllSections];
    
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [_manager addSection:section];
    
    if (self.ticketList.count > 0) {
        for (NSInteger i=0; i<self.ticketList.count; i++) {
            SeperateItem *item00 = [[SeperateItem alloc] init];
            item00.cellHeight = smallSpacing;
            item00.selectionStyle = UITableViewCellSelectionStyleNone;
            [section addItem:item00];
            
            TicketModel *model = self.ticketList[i];
            TicketItem *item = [[TicketItem alloc] initWithTicketModel:model];
            item.selectionStyle = UITableViewCellSelectionStyleNone;
            [section addItem:item];
            
            if ([self.direction integerValue] == 1) {
                if ([item.status isEqualToString:@"0"]) {
                    MLWeakSelf;
                    item.selectionHandler = ^(id item) {
                        if (weakself.didSelectedTicket) {
                            weakself.didSelectedTicket(model);
                        }
                    };
                }
            }
        }
        
        if (self.showBottom) {//我也是有底线的，，此时tableview无上拉加载功能
            BaseBottomItem *item999 = [[BaseBottomItem alloc] init];
            item999.selectionStyle = UITableViewCellSelectionStyleNone;
            [section addItem:item999];
            
            self.myTicketTableView.mj_footer = nil;
        }else {
            self.myTicketTableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOfMyTicket)];
        }
        
    }else{
        BaseRemindItem *item1234 = [[BaseRemindItem alloc] init];
        item1234.remindImage = @"nocoupons";
        item1234.remindText = @"暂无内容哦～";
        item1234.remindAction = @"";
        item1234.selectionStyle = UITableViewCellSelectionStyleNone;
        item1234.cellHeight = 300;
        [section addItem:item1234];
    }
}

#pragma mark - getter
- (ConditionView *)conditionView {
    if (!_conditionView) {
        _conditionView = [ConditionView newAutoLayoutView];
        
        MLWeakSelf;
        [_conditionView setDidChooseBtn:^(NSInteger tag) {
            weakself.ticketType = [NSString stringWithFormat:@"%ld",tag-123];
            [weakself headerRefreshOfMyTicket];
        }];
        
    }
    return _conditionView;
}

- (UITableView *)myTicketTableView {
    if (!_myTicketTableView) {
        _myTicketTableView = [UITableView newAutoLayoutView];
        _myTicketTableView.tableFooterView = [UIView new];
        _myTicketTableView.backgroundColor = MLBackGroundColor;
        _myTicketTableView.showsVerticalScrollIndicator = NO;
        
        MLWeakSelf;
        _myTicketTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshOfMyTicket)];
        [weakself.myTicketTableView.mj_header beginRefreshing];
        
        _myTicketTableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOfMyTicket)];
        [weakself.myTicketTableView.mj_footer beginRefreshing];
        
    }
    return _myTicketTableView;
}

- (NSMutableArray *)ticketList {
    if (!_ticketList) {
        _ticketList = [NSMutableArray array];
    }
    return _ticketList;
}

#pragma mark - method
- (void) headerRefreshOfMyTicket {
    _pageTicket = 1;
    [self getTicketListWithPage:@"1"];
    [self.myTicketTableView.mj_header endRefreshing];
}

- (void) footerRefreshOfMyTicket {
    _pageTicket++;
    NSString *page = [NSString stringWithFormat:@"%ld",(long)_pageTicket];
    [self getTicketListWithPage:page];
    
    [self.myTicketTableView.mj_footer endRefreshing];
}

- (void) getTicketListWithPage:(NSString *)page {
    NSString *tokenn = TOKEN?TOKEN:@"";
    NSString *ticketStr = [NSString stringWithFormat:@"%@%@%@/%@/%@",MLBaseUrl,MLMyTicket,tokenn,page,self.ticketType];
    
    MLWeakSelf;
    [self requestDataGetWithString:ticketStr params:nil successBlock:^(id responseObject) {
        
        if ([page integerValue] == 1) {
            [weakself.ticketList removeAllObjects];
        }
        
        TicketResponse *response = [TicketResponse mj_objectWithKeyValues:responseObject];
        
        [weakself showHint:response.info];
        
        for (TicketModel *model in response.tickets) {
            [weakself.ticketList addObject:model];
        }
        
        //最后一页
        if (response.tickets.count < 8 && response.tickets.count > 0) {
            weakself.showBottom = YES;
        }else{
            weakself.showBottom = NO;
        }
        
        [weakself configTicketTableView];
        
        [weakself.myTicketTableView reloadData];
        
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
