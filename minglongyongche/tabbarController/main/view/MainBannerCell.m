//
//  MainBannerCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/16.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MainBannerCell.h"
#define HH 250

@implementation MainBannerCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return HH+0.5;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    
    [self.contentView addSubview:self.bannerScrollView];
    [self.contentView addSubview:self.bannerPage];
    [self.contentView addSubview:self.newsButton];
    [self.contentView  addSubview:self.borderView];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.bannerScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.borderView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        
        [self.newsButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:bigSpacing];
        [self.newsButton autoPinEdgeToSuperviewEdge:ALEdgeTop  withInset:smallSpacing];
        
        [self.bannerPage autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.bannerPage autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [UIScrollView newAutoLayoutView];
        _bannerScrollView.contentSize = CGSizeMake(MLWindowWidth * 1, HH);
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.backgroundColor = MLBackGroundColor;
        _bannerScrollView.delegate = self;
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        
        MLWeakSelf;
        for (NSInteger i=0; i<1; i++) {
            UIButton *imgButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MLWindowWidth, HH)];
//            imgButton.backgroundColor = sdsd[i];
            [imgButton setBackgroundImage:[UIImage imageNamed:@"banner_01"] forState:0];
            imgButton.frame = CGRectMake(MLWindowWidth*i, 0, MLWindowWidth, HH);
            [weakself.bannerScrollView addSubview:imgButton];
        }
    }
    return _bannerScrollView;
}

- (UIImageView *)borderView {
    if (!_borderView) {
        _borderView = [UIImageView newAutoLayoutView];
        [_borderView setImage:[UIImage imageNamed:@"huxian"]];
    }
    return _borderView;
}

- (UIButton *)newsButton {
    if (!_newsButton) {
        _newsButton = [UIButton newAutoLayoutView];
        [_newsButton setImage:[UIImage imageNamed:@"message"] forState:0];
        [_newsButton setHidden:YES];
        
        MLWeakSelf;
        [_newsButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(90);
            }
        }];
    }
    return _newsButton;
}

- (UIPageControl *)bannerPage {
    if (!_bannerPage) {
        _bannerPage = [UIPageControl newAutoLayoutView];
//        _bannerPage.numberOfPages = 1;
    }
    return _bannerPage;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat XX =  scrollView.mj_offsetX;
    self.bannerPage.currentPage = XX/MLWindowWidth;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
