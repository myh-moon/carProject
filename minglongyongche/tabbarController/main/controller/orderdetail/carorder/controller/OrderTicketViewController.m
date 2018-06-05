//
//  OrderTicketViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/2.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "OrderTicketViewController.h"

//#import "OrderTicketView.h"  //不使用优惠券

#import "TicketItem.h"
#import "SeperateItem.h"
#import "BaseRemindItem.h"


#import "TicketResponse.h"
#import "TicketModel.h"

@interface OrderTicketViewController ()

@property (nonatomic,strong) NSMutableArray *validArray;

@property (nonatomic,assign) NSInteger orderTicketPage;

@end

@implementation OrderTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择优惠券";
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    [self.rightNavBtn setTitle:@"不使用" forState:0];
    MLWeakSelf;
    [self.rightNavBtn addAction:^(UIButton *btn) {
        if (weakself.didSelectedTicket) {
            
            NSDictionary *sdsds = @{@"money" : @"0",@"tid" : @"0"};
            TicketModel *model = [TicketModel mj_objectWithKeyValues:sdsds];
            weakself.didSelectedTicket(model);
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
    self.manager[@"TicketItem"] = @"TicketCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    self.manager[@"BaseRemindItem"] = @"BaseRemindCell";
    
    self.pageIndex = 1;
    
    self.pullToRefreshHandler = ^{
        weakself.pageIndex = 1;
        [weakself getOrderTicketWithPage:@"1"];
        [weakself.refreshTableView.mj_header endRefreshing];
    };
    
    self.pullToLoadMoreHandler = ^{
        weakself.pageIndex++;
        [weakself getOrderTicketWithPage:[NSString stringWithFormat:@"%ld",(long)weakself.pageIndex]];
        [weakself.refreshTableView.mj_footer endRefreshing];
    };
}

- (void) setupOrderTicketTableView {
    
    [self.manager removeAllSections];
    
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    if (self.validArray.count > 0) {
        for (NSInteger i=0; i<self.validArray.count; i++) {
            
            TicketModel *model = self.validArray[i];
            
            MLWeakSelf;
            TicketItem *item = [[TicketItem alloc] initWithTicketModel:model];
            item.selectionHandler = ^(id item) {
                if (weakself.didSelectedTicket) {
                    weakself.didSelectedTicket(model);
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
            };
            [section addItem:item];
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

- (void) getOrderTicketWithPage:(NSString *)page {
    NSString *ticketStr = [NSString stringWithFormat:@"%@%@%@/%@/0",MLBaseUrl,MLMyTicket,TOKEN,page];
    
    MLWeakSelf;
    [self requestDataGetWithString:ticketStr params:nil successBlock:^(id responseObject) {
        if ([page integerValue] == 1) {
            [weakself.validArray removeAllObjects];
        }
        TicketResponse *response = [TicketResponse mj_objectWithKeyValues:responseObject];

        for (TicketModel *model in response.tickets) {
            [weakself.validArray addObject:model];
        }
        
        [weakself setupOrderTicketTableView];
        
        [weakself.refreshTableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

- (NSMutableArray *)validArray {
    if (!_validArray) {
        _validArray = [NSMutableArray array];
    }
    return _validArray;
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
