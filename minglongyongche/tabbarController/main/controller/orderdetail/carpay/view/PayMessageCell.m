//
//  PayMessageCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/25.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PayMessageCell.h"

@implementation PayMessageCell
@dynamic item;
+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 105;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    
    [self.contentView addSubview:self.orderImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.licenseLabel];
    [self.contentView addSubview:self.featureLabel1];

    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.orderImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.orderImage autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:middleSpacing];
        [self.orderImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:middleSpacing];
        [self.orderImage autoSetDimension:ALDimensionWidth toSize:100];
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.orderImage withOffset:middleSpacing];
        [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.orderImage];
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        
        [self.licenseLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.licenseLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:smallSpacing];
        
        [self.featureLabel1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.licenseLabel];
        [self.featureLabel1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.orderImage];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIImageView *)orderImage {
    if (!_orderImage) {
        _orderImage = [UIImageView newAutoLayoutView];
        _orderImage.layer.borderColor = UIColorFromRGB(0xefefef).CGColor;
        _orderImage.layer.borderWidth = 0.5;
    }
    return _orderImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.textColor = MLBlackColor;
        _nameLabel.font = MLFont5;
    }
    return _nameLabel;
}

- (UILabel *)licenseLabel {
    if (!_licenseLabel) {
        _licenseLabel = [UILabel newAutoLayoutView];
        _licenseLabel.textColor = MLLightGrayColor;
        _licenseLabel.font = MLFont3;
    }
    return _licenseLabel;
}

- (UILabel *)featureLabel1 {
    if (!_featureLabel1) {
        _featureLabel1 = [UILabel newAutoLayoutView];
        _featureLabel1.textColor = MLLightGrayColor;
        _featureLabel1.font = MLFont3;
    }
    return _featureLabel1;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    [self.orderImage sd_setImageWithURL:[NSURL URLWithString:self.item.img] placeholderImage:[UIImage imageNamed:@"defaultsb"]];
    self.nameLabel.text = self.item.namess;
    self.licenseLabel.text  = self.item.license;
    self.featureLabel1.text = self.item.feature1;
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
