//
//  CarListViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/3/29.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "CarListViewController.h"
#import "CarDetailsViewController.h"

//#import "CarConditionView.h"
//
//#import "CarListItem.h"

@interface CarListViewController ()<RETableViewManagerDelegate>

@end

@implementation CarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"二手车";
    
    self.tableView.backgroundColor = MLWhiteColor;
    
    [self.remindImageButton.remindImageView setImage:[UIImage imageNamed:@"comeing_soon"]];
    self.remindImageButton.remindLabel.attributedText =  [NSString setFirstPart:@"\n功能开发中，敬请期待!\n" firstFont:17 firstColor:MLGrayColor secondPart:@"请你耐心等待，我们很快就能见面" secondFont:12 secongColor:MLLightGrayColor space:10 align:1];
    
    [self showRemindImage];
    
//    [self configOldCarTableView];
}

/*
- (void) configOldCarTableView {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    
//    for ( NSInteger i=0; i<10; i++) {
//        CarListItem *item  = [[CarListItem alloc] init];
//
//        MLWeakSelf;
//        item.selectionHandler = ^(id item) {
//            CarDetailsViewController *carDetailsVC = [[CarDetailsViewController alloc] init];
//            carDetailsVC.hidesBottomBarWhenPushed = YES;
//            carDetailsVC.type = @"二手车";
//            [weakself.navigationController pushViewController:carDetailsVC animated:YES];
//        };
//        [section addItem:item];
//
//    }
    
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        [self.oldCarHeaderView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.oldCarHeaderView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.oldCarHeaderView autoPinToTopLayoutGuideOfViewController:self withInset:0];
        [self.oldCarHeaderView autoSetDimension:ALDimensionHeight toSize:50];
        
        [self.oldCarTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.oldCarTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.oldCarHeaderView];
    }
    [super updateViewConstraints];
}

#pragma mark - getter
- (CarConditionView *)oldCarHeaderView {
    if (!_oldCarHeaderView) {
        _oldCarHeaderView = [CarConditionView newAutoLayoutView];
    }
    return _oldCarHeaderView;
}

- (UITableView *)oldCarTableView {
    if (!_oldCarTableView) {
        _oldCarTableView = [UITableView newAutoLayoutView];
    }
    return _oldCarTableView;
}
*/

#pragma mark - end

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
