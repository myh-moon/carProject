//
//  LoginViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/18.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterAgreementViewController.h"  //注册协议
#import "AuthenViewController.h"  //认证
#import "UIViewController+DismissKeyboard.h"

#import "LoginModel.h"

#import "LoginImageItem.h"
#import "LoginItem.h"
#import "LoginCodeItem.h"
#import "LoginAgreeItem.h"

@interface LoginViewController ()

@property (nonatomic,strong) NSMutableDictionary *loginParams;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    self.navTableView.backgroundColor = MLLoginColor;
    
    self.navManager[@"LoginImageItem"] = @"LoginImageCell";
    self.navManager[@"LoginItem"] = @"LoginCell";
    self.navManager[@"LoginCodeItem"] = @"LoginCodeCell";
    self.navManager[@"LoginAgreeItem"] = @"LoginAgreeCell";
    
    [self setupLoginView];
    
    [self setupForDismissKeyboard];
    
}

- (void) setupLoginView {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.navManager addSection:section];
    
    //header
    LoginImageItem *item = [[LoginImageItem alloc] init];
    item.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item];
    
    //用户名
    MLWeakSelf;
    LoginItem *item0 = [[LoginItem alloc] init];
    item0.selectionStyle = UITableViewCellSelectionStyleNone;
    item0.didChangeText = ^(NSString *text) {
        [weakself.loginParams setValue:text forKey:@"phone"];
    };
    [section addItem:item0];
    
    //验证码
    LoginCodeItem *item1 = [[LoginCodeItem alloc] init];
    item1.selectionStyle = UITableViewCellSelectionStyleNone;
    [item1 setDidSelectedBtn:^(NSInteger tag) {
        [weakself getCodeWithPhone:@"13162521916"];
    }];
    [item1 setDidChangeText:^(NSString *text) {
        [weakself.loginParams setValue:text forKey:@"code"];
    }];
    [section addItem:item1];
    
    //协议
    LoginAgreeItem *item2 = [[LoginAgreeItem alloc] init];
    item2.selectionStyle = UITableViewCellSelectionStyleNone;
    
    @weakify(item2);
    [item2 setDidSelectedBtn:^(NSInteger tag) {
        if (tag == 23) {
        }else if (tag == 24){//具体协议
            RegisterAgreementViewController *registerAgreemnetVC = [[RegisterAgreementViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registerAgreemnetVC];
            [weakself presentViewController:nav animated:YES completion:nil];
        }else if (tag == 25){//立即登录
            @strongify(item2);
            if ([item2.isSelected integerValue] == 0) {
                [weakself showHint:@"请先同意协议"];
            }else{
                [weakself loginUser];
            }
        }else {//跳过登录
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [section addItem:item2];
}

//登录
- (void) loginUser {
    NSString *loginStr = [NSString stringWithFormat:@"%@%@",MLBaseUrl,MLLogin];
    
    MLWeakSelf;
    [self requestDataPostWithString:loginStr params:self.loginParams successBlock:^(id responseObject) {
        
        LoginModel *model = [LoginModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:model.info];
        
        if ([model.status isEqualToString:@"200"] || [model.status isEqualToString:@"403"]) {
            //存储信息
            [[NSUserDefaults standardUserDefaults] setValue:model.status forKey:@"authen"];
            [[NSUserDefaults standardUserDefaults] setValue:weakself.loginParams[@"phone"] forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults] setValue:model.token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }
    } andFailBlock:^(NSError *error) {
        
    }];
}

//发送验证码
- (void) getCodeWithPhone:(NSString *)phone {
    NSString *codeStr = [NSString stringWithFormat:@"%@%@",MLBaseUrl,MlLoginCode];

    if (!self.loginParams[@"phone"]) {
        [self.loginParams setValue:@"" forKey:@"phone"];
    }
    
    MLWeakSelf;
    [self requestDataPostWithString:codeStr params:self.loginParams successBlock:^(id responseObject) {
        
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:model.info];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

- (NSMutableDictionary *)loginParams {
    if (!_loginParams) {
        _loginParams = [NSMutableDictionary dictionary];
        [_loginParams setValue:@"1" forKeyPath:@"type"];
    }
    return _loginParams;
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
