//
//  CollectionCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/19.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 120;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    self.backgroundColor = MLBackGroundColor;
    
    [self.contentView addSubview:self.coBackView];
    
    [self.contentView addSubview:self.carImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lisenceLabel];
    [self.contentView addSubview:self.qualityLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.contentView addSubview:self.countLabel];

//    [self.contentView addSubview:self.cancelButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.coBackView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 7.5, 0, 7.5)];
        
        [self.carImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.coBackView withOffset:7.5];
        [self.carImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.coBackView withOffset:7.5];
        [self.carImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.coBackView withOffset:-7.5];
        [self.carImageView autoSetDimension:ALDimensionWidth toSize:140];
        
        [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.carImageView withOffset:4];
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.carImageView withOffset:middleSpacing];
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:middleSpacing];
        
        [self.lisenceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.lisenceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:5];
        
        [self.qualityLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.lisenceLabel];
        [self.qualityLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.lisenceLabel withOffset:smallSpacing];
//        [self.qualityLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
        [self.qualityLabel autoSetDimension:ALDimensionHeight toSize:20];
        
        [self.priceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.qualityLabel];
        [self.priceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.coBackView withOffset:-7.5];
        
        [self.countLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.priceLabel];
        [self.countLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.coBackView withOffset:-middleSpacing];
        
//        [self.cancelButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
//        [self.cancelButton autoSetDimensionsToSize:CGSizeMake(80, 30)];
//        [self.cancelButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIView *)coBackView {
    if (!_coBackView) {
        _coBackView = [UIView newAutoLayoutView];
        _coBackView.backgroundColor = MLWhiteColor;
    }
    return _coBackView;
}

- (UIImageView *)carImageView {
    if (!_carImageView) {
        _carImageView = [UIImageView newAutoLayoutView];
        _carImageView.backgroundColor = MLBackGroundColor;
    }
    return _carImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.text = @"车车车车";
        _nameLabel.textColor = MLBlackColor;
        _nameLabel.font = MLFont;
    }
    return _nameLabel;
}

- (UILabel *)lisenceLabel {
    if (!_lisenceLabel) {
        _lisenceLabel = [UILabel newAutoLayoutView];
        _lisenceLabel.text = @"沪牌沪牌";
        _lisenceLabel.textColor = MLGrayColor;
        _lisenceLabel.font = MLFont;
    }
 return _lisenceLabel;
}

- (UILabel *)qualityLabel {
    if (!_qualityLabel) {
        _qualityLabel = [UILabel newAutoLayoutView];
        _qualityLabel.backgroundColor = MLBackGroundColor;
        _qualityLabel.font = MLFont3;
        _qualityLabel.textColor = MLLightGrayColor;
        _qualityLabel.layer.cornerRadius = 3;
        _qualityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _qualityLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel newAutoLayoutView];
    }
    return _priceLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel newAutoLayoutView];
        _countLabel.font = MLFont3;
        _countLabel.textColor = MLGrayColor;
    }
    return _countLabel;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    [self.carImageView sd_setImageWithURL:[NSURL URLWithString:self.item.imageName]];
    self.nameLabel.text = self.item.carName;
    self.lisenceLabel.text = self.item.carLicense;
    self.qualityLabel.text = [NSString stringWithFormat:@"%@  ",self.item.collocation];

    self.priceLabel.attributedText = [NSString setFirstPart:@"日租¥" firstFont:11 firstColor:MLOrangeColor secondPart:self.item.carPrice secondFont:18 secongColor:MLOrangeColor thirdPart:@"/天" thirdFont:11 thirdColor:MLOrangeColor];
    self.countLabel.text = self.item.carUsedDays;
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
