//
//  TicketCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/9.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "TicketCell.h"

@implementation TicketCell


+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 140;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    self.backgroundColor = MLBackGroundColor;
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.sourceLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.expirationLabel];
    [self.contentView addSubview:self.validLabel];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, middleSpacing, 0, middleSpacing)];
        
        [self.sourceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.backView withOffset:middleSpacing];
        [self.sourceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.backView];
        [self.sourceLabel autoSetDimension:ALDimensionHeight toSize:105];
        
        [self.moneyLabel autoPinEdge:ALEdgeRight  toEdge:ALEdgeRight ofView:self.backView];
        [self.moneyLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.sourceLabel];
        [self.moneyLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.sourceLabel];
        [self.moneyLabel autoSetDimension:ALDimensionWidth toSize:120];
        
        [self.expirationLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.backView withOffset:middleSpacing];
        [self.expirationLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.backView];
        [self.expirationLabel autoSetDimension:ALDimensionHeight toSize:35];
        
        [self.validLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.expirationLabel];
        [self.validLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.backView withOffset:-middleSpacing];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [UIImageView newAutoLayoutView];
        _backView.backgroundColor = MLBackGroundColor;
    }
    return _backView;
}

- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [UILabel newAutoLayoutView];
        _sourceLabel.numberOfLines = 0;
    }
    return _sourceLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel newAutoLayoutView];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}

- (UILabel *)expirationLabel {
    if (!_expirationLabel) {
        _expirationLabel = [UILabel newAutoLayoutView];
        _expirationLabel.font = MLFont3;
    }
    return _expirationLabel;
}

- (UILabel *)validLabel {
    if (!_validLabel) {
        _validLabel = [UILabel newAutoLayoutView];
        _validLabel.font = MLFont3;
    }
    return _validLabel;
}


- (void)cellWillAppear {
    [super cellWillAppear];
    
    //info  RELabel
    if (self.item.status == 0) {
        
        [self.backView setImage:[UIImage imageNamed:@"card_01"]];
        
        self.sourceLabel.attributedText = [NSString setFirstPart:self.item.source firstFont:15 firstColor:MLBlackColor secondPart:self.item.sourceDetail1 secondFont:13 secongColor:MLLightGrayColor thirdPart:self.item.sourceDetail2 thirdFont:13 thirdColor:MLLightGrayColor space:8 align:0];
        
        [self.moneyLabel setAttributedText:[NSString setFirstPart:@"¥" firstFont:25 firstColor:MLOrangeColor secondPart:@"10" secondFont:50 secongColor:MLOrangeColor]];
        
        self.expirationLabel.textColor = UIColorFromRGB(0xd4adad);
        
        self.validLabel.textColor = UIColorFromRGB(0xd4aeae);
    }else{
        
        [self.backView setImage:[UIImage imageNamed:@"card_02"]];

        self.sourceLabel.attributedText = [NSString setFirstPart:self.item.source firstFont:15 firstColor:MLLightGrayColor secondPart:self.item.sourceDetail1 secondFont:13 secongColor:MLLightGrayColor thirdPart:self.item.sourceDetail2 thirdFont:13 thirdColor:MLLightGrayColor space:8 align:0];
        
        [self.moneyLabel setAttributedText:[NSString setFirstPart:@"¥" firstFont:25 firstColor:MLLightGrayColor secondPart:@"10" secondFont:50 secongColor:MLLightGrayColor]];
        
        self.expirationLabel.textColor = MLLightGrayColor;
        
        self.validLabel.textColor = MLLightGrayColor;
    }
    
    self.expirationLabel.text = self.item.overdueTime;
    self.validLabel.text = self.item.validDays;
    
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
