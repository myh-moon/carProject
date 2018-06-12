//
//  MyCollectionViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/18.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ShortRentViewController.h"
#import "CarDetailsViewController.h"  //详情

#import "CarListItem.h"
#import "SeperateItem.h"
#import "BaseRemindItem.h"
#import "BaseBottomItem.h"

#import "CollectionResponse.h"
#import "CarModel.h"

@interface MyCollectionViewController ()

@property (nonatomic,strong) NSMutableArray *collectionList;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.manager.delegate = self;
    
    self.manager[@"CarListItem"] = @"CollectionCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    self.manager[@"BaseRemindItem"] = @"BaseRemindCell";
    self.manager[@"BaseBottomItem"] = @"BaseBottomCell";
    
    MLWeakSelf;
    self.pullToRefreshHandler = ^{
        weakself.pageIndex = 1;
        [weakself getCollectionListWithPage:@"1"];
        [weakself.refreshTableView.mj_header endRefreshing];
    };
    
    self.pullToLoadMoreHandler = ^{
        weakself.pageIndex++;
        [weakself getCollectionListWithPage:[NSString stringWithFormat:@"%ld",(long)weakself.pageIndex]];
        [weakself.refreshTableView.mj_footer endRefreshing];
    };
    
}

- (NSMutableArray *)collectionList {
    if (!_collectionList) {
        _collectionList = [NSMutableArray new];
    }
    return _collectionList;
}

#pragma mark - set up
- (void) setupMyCollectionTableView {
    
    [self.manager removeAllSections];
    
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    
    MLWeakSelf;
    if (self.collectionList.count > 0) {
        for (NSInteger i=0; i<self.collectionList.count; i++) {
            
            SeperateItem *item1 = [[SeperateItem alloc] init];
            item1.cellHeight = smallSpacing;
            item1.selectionStyle = UITableViewCellSelectionStyleNone;
            [section addItem:item1];
            
            CarModel *model = self.collectionList[i];
            
            CarListItem *item0 = [[CarListItem alloc] initWIthModel:model];
            item0.selectionStyle = UITableViewCellSelectionStyleNone;
            item0.editingStyle = UITableViewCellEditingStyleDelete;
            
            //查看详情
            item0.selectionHandler = ^(id item) {
                CarDetailsViewController *carDetailVC = [[CarDetailsViewController alloc] init];
                carDetailVC.zid = model.zid;
                [weakself.navigationController pushViewController:carDetailVC animated:YES];
            };
            //取消收藏
            @weakify(item0);
            item0.deletionHandlerWithCompletion = ^(id item, void (^delete)(void)) {
                @strongify(item0);
                [weakself cancelCollectionWithCoid:model.zid withItem:item0 withIndexPath:i];
            };
            
            [section addItem:item0];
        }
        
        if (self.showBottom) {
            BaseBottomItem *item999 = [[BaseBottomItem alloc] init];
            item999.selectionStyle = UITableViewCellSelectionStyleNone;
            [section addItem:item999];
            
            self.refreshTableView.mj_footer = nil;
            
        }else{
            self.refreshTableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
                weakself.pageIndex++;
                [weakself getCollectionListWithPage:[NSString stringWithFormat:@"%ld",(long)weakself.pageIndex]];
                [weakself.refreshTableView.mj_footer endRefreshing];
            }];
            
        }
        
    }else{
        BaseRemindItem *item1234 = [[BaseRemindItem alloc] init];
        item1234.remindImage = @"no_collection";
        item1234.remindText = @"暂时没有你的收藏";
        item1234.remindAction = @"去发现精彩";
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

- (void)eoeoe {
}
    
    

#pragma mark - method
- (void) getCollectionListWithPage:(NSString *)page {
    
    NSString *tokenn = TOKEN?TOKEN:@"";
    
    NSString *collectionListStr = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLCollectionOfList,tokenn,page];
    
    MLWeakSelf;
    [self requestDataGetWithString:collectionListStr params:nil successBlock:^(id responseObject) {
        
        if ([page isEqualToString:@"1"]) {
            [weakself.collectionList removeAllObjects];
        }
        
        CollectionResponse *response = [CollectionResponse mj_objectWithKeyValues:responseObject];
        
//        [weakself showHint:response.info];
        
        for (CarModel *model in response.collect) {
            [weakself.collectionList addObject:model];
        }
        
        if (response.collect.count < 8 && response.collect.count > 0) {
            weakself.showBottom = YES;
        }else{
            weakself.showBottom = NO;
        }
        
        [weakself setupMyCollectionTableView];

        [weakself.refreshTableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

// 取消收藏
- (void) cancelCollectionWithCoid:(NSString *)coid withItem:(CarListItem *)item withIndexPath:(NSInteger)index{
    NSString *cancelStr = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLCollectionOfCancel,TOKEN,coid];

    MLWeakSelf;
    [self requestDataPostWithString:cancelStr params:nil successBlock:^(id responseObject) {
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:model.info];

        if ([model.status integerValue] == 200) {//取消成功
            
            //1.删除该行
            [item deleteRowWithAnimation:UITableViewRowAnimationLeft];
            
            //2.从数组删除
            [weakself.collectionList removeObjectAtIndex:index];
            
            //3.刷新数据
            [weakself setupMyCollectionTableView];
            
            [weakself.refreshTableView reloadData];
        }
    } andFailBlock:^(NSError *error) {

    }];
}


#pragma mark - delegate
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
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
