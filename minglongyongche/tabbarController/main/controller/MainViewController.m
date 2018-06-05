//
//  MainViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/3/30.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MainViewController.h"
#import "NewsViewController.h"  //消息
#import "ShortRentViewController.h"  //短租
#import "CarDetailsViewController.h" //详情

#import "CarDetailBannerItem.h" //banner
#import "MainSingleItem.h"
#import "MainListItem.h"

#import "ShortRentResult.h"
#import "CarModel.h"


@interface MainViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *hotArray;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (self.hotArray.count == 0) {
        [self getMainBannerList];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    self.navManager[@"CarDetailBannerItem"] = @"MainBannerCell";
    self.navManager[@"MainSingleItem"] = @"MainSingleCell";
    self.navManager[@"MainListItem"] = @"MainListCell";
    
    [self setupMainTableView];
    
//    [self getMainBannerList];
    
    MLWeakSelf;
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        [self loadImageSource:imgUrl];
        [weakself checkAppUpdate];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOperation];
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)setupMainTableView {
    
    [self.navManager removeAllSections];
    
    RETableViewSection *mainSection = [RETableViewSection section];
    mainSection.headerHeight = 0;
    mainSection.footerHeight = 0;
    [self.navManager addSection:mainSection];
    
    //banner
    MLWeakSelf;
    CarDetailBannerItem *item0 = [[CarDetailBannerItem alloc] init];
    item0.selectionStyle = UITableViewCellSelectionStyleNone;
    [item0 setDidSelectedBtn:^(NSInteger tag) {
        if (tag == 90) {
            NewsViewController *newsVC = [[NewsViewController alloc] init];
            newsVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:newsVC animated:YES];
        }
    }];
    [mainSection addItem:item0];
    
//    notification
//    MainSingleItem *item1 = [[MainSingleItem alloc] init];
//    [mainSection addItem:item1];
    
    //list
    MainListItem *item4 = [[MainListItem alloc] initWithHotList:self.hotArray];
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    [mainSection addItem:item4];
    [item4 setDidClickBtn:^(NSString *zid) {
        if ([zid isEqualToString:@"更多"]) {
            ShortRentViewController *shortRentVC = [[ShortRentViewController alloc] init];
            shortRentVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:shortRentVC animated:YES];
        }else{
            CarDetailsViewController *carDetailVC = [[CarDetailsViewController alloc] init];
            carDetailVC.hidesBottomBarWhenPushed = YES;
            carDetailVC.zid = zid;
            [weakself.navigationController pushViewController:carDetailVC animated:YES];
        }
    }];
}

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

#pragma mark - method
- (void) getMainBannerList {
    NSString *hotListStr = [NSString stringWithFormat:@"%@%@",MLBaseUrl,MLMainHotList];
    
    MLWeakSelf;
    [self requestDataGetWithString:hotListStr params:nil successBlock:^(id responseObject) {
        
        [weakself.hotArray removeAllObjects];
        
        ShortRentResult *response = [ShortRentResult mj_objectWithKeyValues:responseObject];
        
        for (CarModel *model in response.lease) {
            [weakself.hotArray addObject:model];
        }
        
        [weakself setupMainTableView];
        
        [weakself.navTableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

- (void) checkAppUpdate {

    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",@"1382145658"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *appInfoDic;
    if (response) {
        appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    }
    NSArray *resultArr = appInfoDic[@"results"];
    if (![resultArr count]) {
        return ;
    }
    
    NSDictionary *infoDic1 = resultArr[0];
    //需要version,trackViewUrl,trackName
    NSString *latestVersion = infoDic1[@"version"];
    NSString *trackUrl = infoDic1[@"trackViewUrl"];
    NSString *trackName = infoDic1[@"trackName"];
    
    //当前版本
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    //比较版本号
    NSString *s1 = [currentVersion substringToIndex:1];//当前
    NSString *s2 = [latestVersion substringToIndex:1];//最新
    
    if ([s1 integerValue] == [s2 integerValue]) {//第一位
        NSString *s11 = [currentVersion substringWithRange:NSMakeRange(2,1)];
        NSString *s22 = [latestVersion substringWithRange:NSMakeRange(2,1)];
        if ([s11 intValue] == [s22 intValue]) {
            NSString *s111 = [currentVersion substringFromIndex:4];
            NSString *s222 = [latestVersion substringFromIndex:4];
            if ([s111 integerValue] < [s222 integerValue]) {
                [self showNewVersionAlertWithTrackUrl:trackUrl andTrackName:trackName andLatestVersion:latestVersion];
            }
        }else if ([s11 integerValue] < [s22 integerValue]){
            [self showNewVersionAlertWithTrackUrl:trackUrl andTrackName:trackName andLatestVersion:latestVersion];
        }
    }else if ([s1 integerValue] < [s2 integerValue]){
        [self showNewVersionAlertWithTrackUrl:trackUrl andTrackName:trackName andLatestVersion:latestVersion];
    }
    
}

- (void)showNewVersionAlertWithTrackUrl:(NSString *)trackUrl andTrackName:(NSString *)trackName andLatestVersion:(NSString *)latestVersion
{
    NSString *titleStr = [NSString stringWithFormat:@"检查更新:%@",trackName];
    NSString *messageStr = [NSString stringWithFormat:@"发现新版本(%@),是否升级?",latestVersion];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleStr message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"guide"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackUrl]];
        //@"itms-apps://itunes.apple.com/us/app/qing-dao-fu-zhai-guan-jia/id1116869191?l=zh&ls=1&mt=8"
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
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
