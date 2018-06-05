//
//  MLNavTableViewController.h
//  minglongyongche
//
//  Created by jiamanu on 2018/5/22.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "NetworkViewController.h"
//无导航栏
@interface MLNavTableViewController : NetworkViewController<RETableViewManagerDelegate>

@property (nonatomic,strong) RETableViewManager *navManager;
@property (nonatomic,strong) UITableView *navTableView;

@end
