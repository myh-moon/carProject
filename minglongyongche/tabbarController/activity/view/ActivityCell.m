//
//  ActivityCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/12.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

@dynamic item;


+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
//    return 215;
    float hhhh = (MLWindowWidth-middleSpacing*2) * 465/1036 + 45 + 15;
    return hhhh;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.backgroundColor = MLBackGroundColor;
    self.separatorInset = MLSeparatorInset;
    
    [self.contentView addSubview:self.activityBannerButton];
    [self.contentView addSubview:self.statusButton];
    [self.contentView addSubview:self.activityTimeLabel];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.activityBannerButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(middleSpacing, middleSpacing, 0, middleSpacing) excludingEdge:ALEdgeBottom];
        [self.activityBannerButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.activityTimeLabel];
        
        [self.statusButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.activityBannerButton];
        [self.statusButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.activityBannerButton];
        
        [self.activityTimeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, middleSpacing, 0,middleSpacing) excludingEdge:ALEdgeTop];
        [self.activityTimeLabel autoSetDimension:ALDimensionHeight toSize:45];
    }
    [super updateConstraints];
}

#pragma mark - getter

- (UIButton *)activityBannerButton {
    if (!_activityBannerButton) {
        _activityBannerButton.translatesAutoresizingMaskIntoConstraints = YES;
        _activityBannerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MLWindowWidth-middleSpacing*2, 155)];
        _activityBannerButton.userInteractionEnabled = NO;
        _activityBannerButton.layer.masksToBounds = YES;

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_activityBannerButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.frame = _activityBannerButton.bounds;
        _activityBannerButton.layer.mask = layer;

    }
    return _activityBannerButton;
}

- (UIButton *)statusButton {
    if (!_statusButton) {
        _statusButton = [UIButton newAutoLayoutView];
    }
    return _statusButton;
}

- (UILabel *)activityTimeLabel {
    if (!_activityTimeLabel) {
        _activityTimeLabel.translatesAutoresizingMaskIntoConstraints = YES;
        _activityTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MLWindowWidth-middleSpacing*2, 45)];
        _activityTimeLabel.backgroundColor = MLWhiteColor;
        _activityTimeLabel.textColor = MLDrakGrayColor;
        _activityTimeLabel.font = MLFont8;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_activityTimeLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.frame = _activityTimeLabel.bounds;
        _activityTimeLabel.layer.mask = layer;
    }
    return _activityTimeLabel;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
//    [self.activityBannerButton setImage:[UIImage imageNamed:self.item.imageName] forState:0];
    [self.activityBannerButton setBackgroundImage:[UIImage imageNamed:self.item.imageName] forState:0];
    self.activityTimeLabel.text = self.item.time;
    if ([self.item.status isEqualToString:@"进行中"]) {
        [self.statusButton setImage:[UIImage imageNamed:@"in_progress"] forState:0];
        self.activityTimeLabel.textColor = MLDrakGrayColor;
    }else{
        [self.statusButton setImage:[UIImage imageNamed:@"finished"] forState:0];
        self.activityTimeLabel.textColor = MLLightGrayColor;
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
