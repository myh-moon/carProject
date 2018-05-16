//
//  PlaceProvinceCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PlaceProvinceCell.h"

@implementation PlaceProvinceCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return MLCellHeight;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.ttLabel];
    [self.contentView addSubview:self.ttTextField];
    [self.contentView addSubview:self.ttButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        NSArray *views = @[self.ttLabel,self.ttTextField,self.ttButton];
        [views autoAlignViewsToAxis:ALAxisHorizontal];
        
        [self.ttLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.ttLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.ttLabel autoSetDimension:ALDimensionWidth toSize:80];
        
        [self.ttTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.ttLabel];
        [self.ttTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:MLCellHeight];
        
        [self.ttButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)ttLabel {
    if (!_ttLabel) {
        _ttLabel = [UILabel newAutoLayoutView];
        _ttLabel.textColor = MLDrakGrayColor;
        _ttLabel.font = MLFont;
    }
    return _ttLabel;
}

- (UITextField *)ttTextField {
    if (!_ttTextField) {
        _ttTextField = [UITextField newAutoLayoutView];
        _ttTextField.font = MLFont;
    }
    return _ttTextField;
}

- (UIButton *)ttButton {
    if (!_ttButton) {
        _ttButton = [UIButton newAutoLayoutView];
        [_ttButton setImage:[UIImage imageNamed:@"xiala"] forState:0];
        
        MLWeakSelf;
        [_ttButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(@"选择地址");
            }
        }];
    }
    return _ttButton;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.ttLabel.text = self.item.ttString;
    self.ttTextField.placeholder = self.item.placeString;
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
