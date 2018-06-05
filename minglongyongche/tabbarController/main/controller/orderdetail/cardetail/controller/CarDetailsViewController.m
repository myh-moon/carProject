//
//  CarDetailsViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/3.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "CarDetailsViewController.h"
#import "OrderCommitViewController.h"
#import "LoginViewController.h" //登录
#import "AuthenViewController.h" //认证
#import "CheckImageViewController.h"  //查看大图片

#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import "UIImage+Color.h"
#import "UIViewController+ImageBrowser.h"


 //footer
#import "DetailOrderView.h"

//短租
#import "CarDetailBannerItem.h"
#import "CarDetailItem.h"
#import "CarListItem.h"
#import "CarDetailLimitItem.h"
#import "CarDetailConfigItem.h"
#import "CarDetailTipsItem.h"

//婚车
#import "CarFixedItem.h"
#import "CarOrderItem.h"

//二手车
#import "WordItem.h"

#import "ShortRentResult.h"

@interface CarDetailsViewController ()<RETableViewManagerDelegate>

@property (nonatomic,strong) UITableView *carDetailTableView;
@property (nonatomic,strong) DetailOrderView *orderBottomView;
@property (nonatomic,strong) RETableViewManager *manager;

@property (nonatomic,strong) NSMutableArray *detailArray;

@property (nonatomic,assign) CGFloat offY;

@end

@implementation CarDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //1.导航栏
    float offSets = MLWindowWidth*10/16-64;
    CGFloat alphaa = _offY/offSets;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB1(0xffffff,alphaa)] forBarMetrics:UIBarMetricsDefault];
    
    //2.title
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB1(0x000000, alphaa)}];
    
    //3.分享和返回按钮
    if (_offY < 61) {//125-64
        [self.leftNavBtn setImage:[UIImage imageNamed:@"return_white"] forState:0];
        self.leftNavBtn.alpha = 1 - _offY/6;
        [self.rightNavBtn setImage:[UIImage imageNamed:@"share"] forState:0];
        self.rightNavBtn.alpha = 1 - _offY/61;
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else if(_offY >= 61 &&  _offY < offSets){
        [self.leftNavBtn setImage:[UIImage imageNamed:@"back_1"] forState:0];
        self.leftNavBtn.alpha = _offY/61 - 1;
        [self.rightNavBtn setImage:[UIImage imageNamed:@"share_black"] forState:0];
        self.rightNavBtn.alpha = _offY/61 - 1;
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    }else{
        [self.leftNavBtn setImage:[UIImage imageNamed:@"back_1"] forState:0];
        [self.rightNavBtn setImage:[UIImage imageNamed:@"share_black"] forState:0];
        [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"line"]];
        
        //状态栏
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:MLBlackColor}];

    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@""]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MLWhiteColor] forBarMetrics:UIBarMetricsDefault];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavBtn];
    MLWeakSelf;
    //返回
    [self.leftNavBtn addAction:^(UIButton *btn) {
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    
    [self.rightNavBtn addAction:^(UIButton *btn) {
        
        if (weakself.detailArray.count > 0) {
            //显示分享面板
            [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                // 根据获取的platformType确定所选平台进行下一步操作
                [weakself shareWebPageToPlatformType:platformType];
            }];
        }
    }];
    
    [self.view addSubview:self.carDetailTableView];
    [self.view addSubview:self.orderBottomView];
    
    [self.view setNeedsUpdateConstraints];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.carDetailTableView delegate:self];
    
//    if ([self.type isEqualToString:@"短租"]) {
        self.manager[@"CarDetailBannerItem"] = @"BannnerCell";
        self.manager[@"CarDetailItem"] = @"CarDetailTextCell";
        self.manager[@"CarDetailLimitItem"] = @"CarDetailLimitCell";
        self.manager[@"CarDetailConfigItem"] = @"CarDetailConfigCell";
        self.manager[@"CarDetailTipsItem"] = @"CarDetailTipsCell";
//    }
    
    [self getDetailOfCarWithZId:self.zid];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
       
        NSString *systemVers = [[UIDevice currentDevice] systemVersion];
       
        NSArray *vers = [systemVers componentsSeparatedByString:@"."];
        
        if ([vers[0] integerValue] > 10) {
            [self.carDetailTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-64];
        }else{
            [self.carDetailTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        }
        
        [self.carDetailTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.carDetailTableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.carDetailTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.orderBottomView];
        
        
        [self.orderBottomView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.orderBottomView autoSetDimension:ALDimensionHeight toSize:60];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - getter
- (UITableView *)carDetailTableView {
    if (!_carDetailTableView) {
        _carDetailTableView  = [UITableView newAutoLayoutView];
        _carDetailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, bigSpacing)];
        _carDetailTableView.showsVerticalScrollIndicator = NO;
        _carDetailTableView.backgroundColor = MLBackGroundColor;
    }
    return _carDetailTableView;
}

- (DetailOrderView *)orderBottomView {
    if (!_orderBottomView) {
        _orderBottomView = [DetailOrderView newAutoLayoutView];
        
        //文字显示
        [_orderBottomView.collectionButton.btnImageView setImage:[UIImage imageNamed:@"collectlion"]];
        _orderBottomView.collectionButton.btnLabel.text = @"收藏";
        
        MLWeakSelf;
        RACSignal *signal = [RACSignal combineLatest:@[RACObserve(_orderBottomView.collectionButton.btnLabel, text)] reduce:^id(NSString *text){
            [weakself.orderBottomView.collectionButton addAction:^(UIButton *btn) {
                if (!TOKEN) {
                    [weakself toLoginifNotLoginFromController:weakself];
                }else{
                    if ([text isEqualToString:@"收藏"]) {
                            [weakself addCollectionWithZid:weakself.zid];
                    }else{
                        [weakself deleteCollectionWithZid:weakself.zid];
                    }
                }
            }];
            return @"collect";
        }];
        
        [signal subscribeNext:^(id x) {
            
        }];
        
        //target
        [_orderBottomView setDidSelectedBtn:^(NSInteger tag) {
            if (!TOKEN) {
                [weakself toLoginifNotLoginFromController:weakself];
            }else {
                    if(tag == 35){
                    OrderCommitViewController *orderCommitVC = [[OrderCommitViewController alloc] init];
                    if (weakself.detailArray.count > 0 ) {
                        orderCommitVC.carModel = weakself.detailArray[0];
                    }
                    [weakself.navigationController pushViewController:orderCommitVC animated:YES];
                }
            }
        }];
    }
    return _orderBottomView;
}

- (NSMutableArray *)detailArray {
    if (!_detailArray) {
        _detailArray = [NSMutableArray new];
    }
    return _detailArray;
}

#pragma mark - method
- (void) setupCarDetailTableView {
    RETableViewSection *detailSection = [RETableViewSection section];
    detailSection.headerHeight = 0;
    detailSection.footerHeight = 0;
    [self.manager addSection:detailSection];
    
    CarModel *carModel = self.detailArray[0];
    NSArray *arr = [carModel.pic componentsSeparatedByString:@","];
    
    //1.短租
    //banner
    CarDetailBannerItem *item0 = [[CarDetailBannerItem alloc] initWithCarModel:carModel];
    item0.selectionStyle = UITableViewCellSelectionStyleNone;
    MLWeakSelf;
    item0.didSelectedBtn = ^(NSInteger tag) {
        [weakself showImages:arr currentIndex:tag-10];
        
//        CheckImageViewController *checkImageVC = [[CheckImageViewController alloc] init];
//        [weakself presentViewController:checkImageVC animated:YES completion:nil];
        
    };
    [detailSection addItem:item0];
    
    //详情
    CarDetailItem *item1 = [[CarDetailItem alloc] initWithCarDetaiModel:carModel];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    [detailSection addItem:item1];
    
    //用车限制
    CarDetailLimitItem *item3 = [[CarDetailLimitItem alloc] init];
    item3.selectionStyle = UITableViewCellSelectionStyleNone;
    [detailSection addItem:item3];
    
    //车辆配置
    CarDetailConfigItem *item5 = [[CarDetailConfigItem alloc] initWithCarDetaiModel:carModel];
    item5.selectionStyle = UITableViewCellSelectionStyleNone;
    [detailSection addItem:item5];
    
//    取车需知
    CarDetailTipsItem *item6 = [[CarDetailTipsItem alloc] init];
    item6.selectionStyle = UITableViewCellSelectionStyleNone;
    [detailSection addItem:item6];
}

//详情
- (void)getDetailOfCarWithZId:(NSString *)zid {
    NSString *carDetail;
    
    if (!TOKEN) {
       carDetail = [NSString stringWithFormat:@"%@%@%@",MLBaseUrl,MLCarDetailOfShortRent,zid];
    }else{
        carDetail = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLCarDetailOfShortRent,zid,TOKEN];
    }
    
    NSDictionary *pp = @{@"type" : @"1"};
    
    MLWeakSelf;
    [self requestDataGetWithString:carDetail params:pp successBlock:^(id responseObject) {
        
        ShortRentResult *carResult = [ShortRentResult mj_objectWithKeyValues:responseObject];
        
        CarModel *carModel = carResult.data;
        if (carModel) {
            [weakself.detailArray addObject:carModel];
            [weakself setupCarDetailTableView];
            [weakself.carDetailTableView reloadData];
        }
        
        //显示收藏文字
        if ([carModel.sc isEqualToString:@"0"]) {
            [weakself.orderBottomView.collectionButton.btnImageView setImage:[UIImage imageNamed:@"collectlion"]];
            weakself.orderBottomView.collectionButton.btnLabel.text = @"收藏";
        }else{
            [weakself.orderBottomView.collectionButton.btnImageView setImage:[UIImage imageNamed:@"collected"]];
            weakself.orderBottomView.collectionButton.btnLabel.text = @"已收藏";
        }
    } andFailBlock:^(NSError *error) {
    }];
}

//添加收藏
- (void) addCollectionWithZid:(NSString *)zid {
    
    NSString *addCollectionStr = [NSString stringWithFormat:@"%@%@%@",MLBaseUrl,MLCollectionOfAdd,TOKEN];
    
    NSDictionary *param = @{@"aid" : zid,@"type" : @"1"};
    
    MLWeakSelf;
    [self requestDataPostWithString:addCollectionStr params:param successBlock:^(id responseObject) {
        
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:model.info];
        
        if ([model.status isEqualToString:@"200"]) {
            weakself.orderBottomView.collectionButton.btnLabel.text = @"已收藏";
            [weakself.orderBottomView.collectionButton.btnImageView setImage:[UIImage imageNamed:@"collected"]];
        }else if([model.status isEqualToString:@"403"]){
            [weakself showAuthentyAlertView];
        }
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

//取消收藏
- (void) deleteCollectionWithZid:(NSString *)zid {
    NSString *deleteStr = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLCollectionOfCancel,TOKEN,zid];
    
    MLWeakSelf;
    [self requestDataGetWithString:deleteStr params:nil successBlock:^(id responseObject) {
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:model.info];
        
        if ([model.status isEqualToString:@"200"]) {
            weakself.orderBottomView.collectionButton.btnLabel.text = @"收藏";
            [weakself.orderBottomView.collectionButton.btnImageView setImage:[UIImage imageNamed:@"collectlion"]];
        }
   } andFailBlock:^(NSError *error) {
       
   }];
}

#pragma mark - share
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    CarModel *model = self.detailArray[0];
    
    NSString *ppp = [NSString stringWithFormat:@"日租¥%@元/天起",model.money];
    
    //创建网页内容对象
    NSString* thumbURL =  [NSString stringWithFormat:@"%@%@",MLBaseUrl,model.img];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.name descr:ppp thumImage:thumbURL];
    //设置网页地址
//    shareObject.webpageUrl = @"http://www.mlong88.vip";
    shareObject.webpageUrl = @"https://itunes.apple.com/cn/app/%E9%B8%A3%E5%9E%84%E5%90%8D%E8%BD%A6/id1382145658?mt=8";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    MLWeakSelf;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            NSDictionary *info = error.userInfo;
            [weakself showHint:info[@"message"]];
        }else{
            [weakself showHint:@"分享成功"];
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                [weakself showHint:resp.message];
//            }else{
//                 [weakself showHint:data];
//            }
        }
    }];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yy = scrollView.contentOffset.y;
    
    CGFloat alphaa = yy/(MLWindowWidth*10/16 -64);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB1(0xffffff,alphaa)] forBarMetrics:UIBarMetricsDefault];
    
    if (self.detailArray.count > 0) {
        CarModel *model = self.detailArray[0];
        self.title = model.name;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB1(0x000000, alphaa)}];
//        125-64
        float offSet = MLWindowWidth * 10/16-64;
        if (yy < 61) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            
            [self.leftNavBtn setImage:[UIImage imageNamed:@"return_white"] forState:0];
            self.leftNavBtn.alpha = 1 - yy/61;
            [self.rightNavBtn setImage:[UIImage imageNamed:@"share"] forState:0];
            self.rightNavBtn.alpha = 1 - yy/61;
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }else if (yy >= 61 && yy < offSet){//260-64
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            
            [self.leftNavBtn setImage:[UIImage imageNamed:@"back_1"] forState:0];
            self.leftNavBtn.alpha = yy/61 - 1;
            [self.rightNavBtn setImage:[UIImage imageNamed:@"share_black"] forState:0];
            self.rightNavBtn.alpha = yy/61 - 1;
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }else{
            
            [self.leftNavBtn setImage:[UIImage imageNamed:@"back_1"] forState:0];
            [self.rightNavBtn setImage:[UIImage imageNamed:@"share_black"] forState:0];
            [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"line"]];
        }
    }
    
    _offY = yy;
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
