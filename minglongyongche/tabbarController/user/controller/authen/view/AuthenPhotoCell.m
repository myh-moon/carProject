//
//  AuthenPhotoCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/26.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AuthenPhotoCell.h"

@implementation AuthenPhotoCell


+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 320;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.backgroundColor = MLWhiteColor;
    self.separatorInset = MLSeparatorInset;
    
    [self.contentView addSubview:self.photoLabel];
    [self.contentView addSubview:self.photoButton1];
    [self.contentView addSubview:self.photoButton2];
    [self.contentView addSubview:self.photoButton3];

    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
                
        [self.photoLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.photoLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:bigSpacing];
        
        NSArray *views = @[self.photoButton1,self.photoButton2];
//        [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:middleSpacing insetSpacing:YES];
        [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSize:165 insetSpacing:YES];
        [views autoMatchViewsDimension:ALDimensionHeight];
        
        [self.photoButton1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.photoLabel withOffset:bigSpacing];
        [self.photoButton1 autoSetDimension:ALDimensionHeight toSize:105];
        
        [self.photoButton3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.photoButton1];
        [self.photoButton3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.photoButton1 withOffset:middleSpacing];
        [self.photoButton3 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.photoButton1];
        [self.photoButton3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.photoButton1];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)photoLabel {
    if (!_photoLabel) {
        _photoLabel = [UILabel newAutoLayoutView];
        _photoLabel.textColor = MLBlackColor;
        _photoLabel.font = MLFont4;
        _photoLabel.text = @"身份证照片：";
    }
    return _photoLabel;
}

- (IntegrationButton *)photoButton1 {
    if (!_photoButton1) {
        _photoButton1.translatesAutoresizingMaskIntoConstraints = YES;
        _photoButton1 = [[IntegrationButton alloc] initWithFrame:CGRectMake(middleSpacing, middleSpacing, 165, 105)];
        _photoButton1.btnImageView.image = [UIImage imageNamed:@"plus"];
        _photoButton1.btnLabel.text = @"上传身份证正面照片";
        _photoButton1.btnLabel.font = MLFont8;
        _photoButton1.topConstraints.constant = 30;
        _photoButton1.spaceConstraints.constant = bigSpacing;
        
        CAShapeLayer *border = [CAShapeLayer layer];
        border.strokeColor = UIColorFromRGB(0xcccccc).CGColor;
        border.fillColor = [UIColor clearColor].CGColor;
        border.path = [UIBezierPath bezierPathWithRoundedRect:_photoButton1.bounds cornerRadius:6].CGPath;
        border.frame = _photoButton1.bounds;
        border.lineWidth = 1.f;
        border.lineDashPattern = @[@4, @4];
        [_photoButton1.layer addSublayer:border];
        
        MLWeakSelf;
        [_photoButton1 addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(456);
            }
        }];
    }
    return _photoButton1;
}

- (IntegrationButton *)photoButton2 {
    if (!_photoButton2) {
        _photoButton2.translatesAutoresizingMaskIntoConstraints = YES;
        _photoButton2 = [[IntegrationButton alloc] initWithFrame:CGRectMake(middleSpacing, middleSpacing, 165, 105)];
        _photoButton2.btnImageView.image = [UIImage imageNamed:@"plus"];
        _photoButton2.btnLabel.text = @"上传身份证反面照片";
        _photoButton2.btnLabel.font = MLFont8;
        _photoButton2.topConstraints.constant = 30;
        _photoButton2.spaceConstraints.constant = bigSpacing;
        
        CAShapeLayer *border = [CAShapeLayer layer];
        border.strokeColor = UIColorFromRGB(0xcccccc).CGColor;
        border.fillColor = [UIColor clearColor].CGColor;
        border.path = [UIBezierPath bezierPathWithRoundedRect:_photoButton2.bounds cornerRadius:6].CGPath;
        border.frame = _photoButton2.bounds;
        border.lineWidth = 1.f;
        border.lineDashPattern = @[@4, @4];
        [_photoButton2.layer addSublayer:border];
        
        MLWeakSelf;
        [_photoButton2 addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(457);
            }
        }];
    }
    return _photoButton2;
}

- (UIButton *)photoButton3 {
    if (!_photoButton3) {
        _photoButton3 = [UIButton newAutoLayoutView];
        [_photoButton3 setImage:[UIImage imageNamed:@"hold_id"] forState:0];
        _photoButton3.layer.cornerRadius = 6;
        _photoButton3.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        _photoButton3.layer.borderWidth = 1;
    }
    return _photoButton3;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    [[[RACObserve(self.item, frontImage) skip:1] takeUntil:[self rac_prepareForReuseSignal]] subscribeNext:^(id image) {
        [self.photoButton1.btnImageView setHidden:YES];
        [self.photoButton1.btnLabel setHidden:YES];
        [self.photoButton1 setImage:image forState:0];
    }];
    
    
    [[[RACObserve(self.item, sideImage) skip:1] takeUntil:[self rac_prepareForReuseSignal]] subscribeNext:^(id image) {
        [self.photoButton2.btnImageView setHidden:YES];
        [self.photoButton2.btnLabel setHidden:YES];
        [self.photoButton2 setImage:image forState:0];
    }];
    
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
