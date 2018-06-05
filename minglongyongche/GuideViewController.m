//
//  GuideViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/29.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "GuideViewController.h"
#import "MainViewController.h"

@interface GuideViewController ()

@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UIScrollView *guideScrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.guideScrollView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        [self.guideScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIScrollView *)guideScrollView {
    if (!_guideScrollView) {
        _guideScrollView = [UIScrollView newAutoLayoutView];
        _guideScrollView.contentSize = CGSizeMake(MLWindowWidth*4,0);
        _guideScrollView.pagingEnabled = YES;
        _guideScrollView.showsHorizontalScrollIndicator = NO;
        
        for (NSInteger i=0; i<4; i++) {
            NSArray *guides = @[@"02_guide",@"03_guide",@"04_guide",@"05_guide"];
            
//            NSInteger www = (NSInteger)MLWindowWidth;
//            NSInteger hhh = (NSInteger)MLWindowHeight;

//            NSLog(@"qwqwqwqw%ld",(long)www);
//            NSLog(@"asasas%ld",(long)hhh);
            
            UIImageView *guideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MLWindowWidth*i,0 , MLWindowWidth, MLWindowHeight)];
            guideImageView.image = [UIImage imageNamed:guides[i]];
            
            if (i == 3) {//最后一页加上按钮
                UIButton *toButton = [UIButton newAutoLayoutView];
                [toButton setTitle:@"去逛逛" forState:0];
                [toButton setTitleColor:MLWhiteColor forState:0];
                toButton.titleLabel.font = MLFont7;
                toButton.backgroundColor = MLOrangeColor;
                toButton.layer.cornerRadius = 20;
                [guideImageView addSubview:toButton];
//                MLWeakSelf;
                [toButton addAction:^(UIButton *btn) {
                    MainViewController *mainVC = [[MainViewController alloc] init];
                    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
                    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                    keyWindow.rootViewController = mainNav;
                }];
                
                [toButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
                [toButton autoSetDimensionsToSize:CGSizeMake(200, 40)];
                [toButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:guideImageView withOffset:210];
            }
            
            [_guideScrollView addSubview:guideImageView];
        }
    }
    return _guideScrollView;
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
