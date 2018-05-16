//
//  AddAddressViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/25.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AddAddressViewController.h"
#import "PlaceItem.h"
#import "PlaceProvinceItem.h"
#import "PlaceDetailItem.h"
#import "PlaceChooseItem.h"
#import "SeperateItem.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增联系地址";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    [self.rightNavBtn setTitle:@"保存" forState:0];
    
    MLWeakSelf;
    [self.rightNavBtn addAction:^(UIButton *btn) {
        
    }];
    
    self.manager[@"PlaceItem"] = @"PlaceCell";
    self.manager[@"PlaceProvinceItem"] = @"PlaceProvinceCell";
    self.manager[@"PlaceDetailItem"] = @"PlaceDetailCell";
    self.manager[@"PlaceChooseItem"] = @"PlaceChooseCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    
    [self setupAddressOfAddTableView];
}

- (void) setupAddressOfAddTableView {

    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    PlaceItem *item1 = [[PlaceItem alloc] initWithInfo:@"租车人称：" placeHolder:@"请输入"];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item1];
    
    PlaceItem *item2 = [[PlaceItem alloc] initWithInfo:@"手机号码：" placeHolder:@"请输入11位手机号码"];
    item2.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item2];
    
    PlaceProvinceItem *item3 = [[PlaceProvinceItem alloc] initWithInfo:@"联系地址：" placeHolder:@"选择省、市、区（县）"];
    item3.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item3];
    
    PlaceDetailItem *item4 = [[PlaceDetailItem alloc] init];
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item4];
    
    SeperateItem *item44 = [[SeperateItem alloc] init];
    item44.selectionStyle = UITableViewCellSelectionStyleNone;
    item44.cellHeight = 30;
    [section addItem:item44];
    
    PlaceChooseItem *item5 = [[PlaceChooseItem alloc] init];
    item5.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item5];
}

- (void) addAddress {
    NSString *addAddress = [NSString stringWithFormat:@"%@%@%@",MLBaseUrl,MLMyAddressOfAdd,TOKEN];
    
    MLWeakSelf;
    [self requestDataPostWithString:addAddress params:nil successBlock:^(id responseObject) {
        NSLog(@"121212");
        NSLog(@"121212");
        NSLog(@"121212");
        NSLog(@"121212");
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
