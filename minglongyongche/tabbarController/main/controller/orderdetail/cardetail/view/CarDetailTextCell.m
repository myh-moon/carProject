//
//  CarDetailTextCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/3.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "CarDetailTextCell.h"

@implementation CarDetailTextCell

@dynamic item;
+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 155;
}

- (void)cellDidLoad {
    
    [super cellDidLoad];
    
    self.separatorInset = UIEdgeInsetsMake(0, middleSpacing, 0, middleSpacing);
    
    [self.contentView addSubview:self.carNameLabel];
    [self.contentView addSubview:self.carBrandLabel];
    [self.contentView addSubview:self.presentPriceLabel];
    [self.contentView addSubview:self.originalPriceLabel];
    [self.contentView addSubview:self.carSignLabel];
    [self.contentView addSubview:self.carUsedLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.distanceBtn];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.carNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:middleSpacing];
        [self.carNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        
        [self.carBrandLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.carNameLabel withOffset:smallSpacing];
        [self.carBrandLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.carNameLabel];
        [self.carBrandLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        
        [self.presentPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.carNameLabel];
        [self.presentPriceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.carNameLabel withOffset:middleSpacing];
        
        [self.originalPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.presentPriceLabel withOffset:middleSpacing];
        [self.originalPriceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.presentPriceLabel];
        
        [self.carSignLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.presentPriceLabel];
        [self.carSignLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.presentPriceLabel withOffset:middleSpacing];
        [self.carSignLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
        
        [self.carUsedLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.carSignLabel];
        [self.carUsedLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        
        [self.addressLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.carSignLabel];
        [self.addressLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.carSignLabel withOffset:middleSpacing];
        
        [self.distanceBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        [self.distanceBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.addressLabel];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - getter
- (UILabel *)carNameLabel {
    if (!_carNameLabel) {
        _carNameLabel  = [UILabel newAutoLayoutView];
        _carNameLabel.textColor = MLDrakGrayColor;
        _carNameLabel.font = MLFont9;
    }
    return _carNameLabel;
}

- (UILabel *)carBrandLabel {
    if (!_carBrandLabel) {
        _carBrandLabel = [UILabel newAutoLayoutView];
        _carBrandLabel.font = MLFont8;
        _carBrandLabel.textColor = MLLightGrayColor;
    }
    return _carBrandLabel;
}

- (UILabel *)presentPriceLabel {
    if (!_presentPriceLabel) {
        _presentPriceLabel = [UILabel newAutoLayoutView];
        _presentPriceLabel.textColor = MLOrangeColor;
        _presentPriceLabel.font = MLFont2;
    }
    return _presentPriceLabel;
}

- (UILabel *)originalPriceLabel {
    if (!_originalPriceLabel) {
        _originalPriceLabel = [UILabel newAutoLayoutView];
        _originalPriceLabel.textColor = MLGGColor;
        _originalPriceLabel.font = MLFont3;
    }
    return _originalPriceLabel;
}

- (UILabel *)carSignLabel {
    if (!_carSignLabel) {
        _carSignLabel = [UILabel newAutoLayoutView];
        _carSignLabel.textColor = MLWhiteColor;
        _carSignLabel.font = MLFont3;
        _carSignLabel.textAlignment = NSTextAlignmentCenter;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer new];
        gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0xe65100).CGColor, (__bridge id)UIColorFromRGB(0xff9800).CGColor];

        gradientLayer.locations = @[@0.2,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, 60, 20);
        [_carSignLabel.layer addSublayer:gradientLayer];
    }
    return _carSignLabel;
}

- (UILabel *)carUsedLabel {
    if (!_carUsedLabel) {
        _carUsedLabel = [UILabel newAutoLayoutView];
        _carUsedLabel.textColor = MLGrayColor;
        _carUsedLabel.font = MLFont3;
    }
    return _carUsedLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel newAutoLayoutView];
        _addressLabel.textColor = MLGrayColor;
        _addressLabel.font = MLFont3;
    }
    return _addressLabel;
}

- (UIButton *)distanceBtn {
    if (!_distanceBtn) {
        _distanceBtn = [UIButton newAutoLayoutView];
        [_distanceBtn setTitleColor:MLGrayColor forState:0];
        _distanceBtn.titleLabel.font = MLFont3;
    }
    return _distanceBtn;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.carNameLabel.text = self.item.names;
    self.carBrandLabel.text = self.item.belong;
    [self.presentPriceLabel setAttributedText: [NSString setFirstPart:@"日租¥" firstFont:11  firstColor:MLOrangeColor secondPart:self.item.money secondFont:18 secongColor:MLOrangeColor thirdPart:@"/天起" thirdFont:11 thirdColor:MLOrangeColor]];
    self.carSignLabel.text = @"精选特惠";
    self.carUsedLabel.text = [NSString stringWithFormat:@"已租%@次",self.item.count];
    self.addressLabel.text = self.item.address;
//    @"上海市静安区铜仁路";
//    [self.distanceBtn setTitle:@"距离20km >" forState:0];
    
    
    
    NSString *mmmm = self.item.originalMoney;
    self.originalPriceLabel.text = [NSString stringWithFormat:@"原价%@",self.item.originalMoney];
    
    //中划线
    NSMutableAttributedString *originPrice = [[NSMutableAttributedString alloc] initWithString:self.originalPriceLabel.text];
    [originPrice setAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSBaselineOffsetAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(2, mmmm.length)];
    
    self.originalPriceLabel.attributedText = originPrice;
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
