//
//  ActivityViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/3/29.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityDetailViewController.h"

#import "ActivityItem.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动中心";
    
//    [self.remindImageButton.remindImageView setImage:[UIImage imageNamed:@"comeing_soon"]];
//    self.remindImageButton.remindLabel.attributedText =  [NSString setFirstPart:@"\n功能开发中，敬请期待!\n" firstFont:17 firstColor:MLGrayColor secondPart:@"请你耐心等待，我们很快就能见面" secondFont:12 secongColor:MLLightGrayColor space:10 align:1];
//
//    [self showRemindImage];
    
//    self.tableView.backgroundColor = MLWhiteColor;
    
    
    self.manager[@"ActivityItem"] = @"ActivityCell";
    
    [self configActivityTableView];
}

- (void) configActivityTableView {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    ActivityItem *item0 = [[ActivityItem alloc] init];
    item0.selectionStyle = UITableViewCellSelectionStyleNone;
    item0.imageName = @"活动_01";
    item0.status = @"进行中";
    item0.time = @"【活动时间】2018.05.22 00:00至2018.05.31 24:00";
    [section addItem:item0];
//    MLWeakSelf;
//    item0.selectionHandler = ^(id item) {
//        ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc] init];
//        activityDetailVC.hidesBottomBarWhenPushed = YES;
//        [weakself.navigationController pushViewController:activityDetailVC animated:YES];
//    };
    
    ActivityItem *item1 = [[ActivityItem alloc] init];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    item1.imageName = @"活动_02";
    item1.status = @"已结束";
    item1.time = @"【活动时间】2018.05.10 00:00至2018.5.20 00:00";
    [section addItem:item1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
