//
//  BannnerCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/12.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BannnerCell.h"

#define HHH MLWindowWidth * 10/16

@implementation BannnerCell

@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return HHH + 0.5;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    
    [self.contentView addSubview:self.bannerScrollView];
    [self.contentView addSubview:self.bannerPage];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.bannerScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.bannerPage autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.bannerPage autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [UIScrollView newAutoLayoutView];
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.backgroundColor = MLBackGroundColor;
        _bannerScrollView.delegate = self;
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _bannerScrollView;
}

- (UIPageControl *)bannerPage {
    if (!_bannerPage) {
        _bannerPage = [UIPageControl newAutoLayoutView];
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
    
    self.bannerScrollView.contentSize = CGSizeMake(MLWindowWidth * self.item.imgArray.count, HHH);
    self.bannerPage.numberOfPages = self.item.imgArray.count;

    MLWeakSelf;
    for (NSInteger i=0; i<self.item.imgArray.count; i++) {
        UIButton *imgButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MLWindowWidth, HHH)];
        imgButton.tag = i+10;
        NSString *aoaoa = [NSString stringWithFormat:@"%@/%@",MLBaseUrl,self.item.imgArray[i]];
//        [imgButton sd_setBackgroundImageWithURL:[NSURL URLWithString:aoaoa] forState:0];
        [imgButton sd_setImageWithURL:[NSURL URLWithString:aoaoa] forState:0 placeholderImage:[UIImage imageNamed:@"defaultsa"]];
        
        imgButton.frame = CGRectMake(MLWindowWidth*i, 0, MLWindowWidth, HHH);
        [weakself.bannerScrollView addSubview:imgButton];
        
        [imgButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(btn.tag);
            }
        }];
    }
    
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
