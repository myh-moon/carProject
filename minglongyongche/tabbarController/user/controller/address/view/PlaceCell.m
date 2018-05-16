//
//  PlaceCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PlaceCell.h"

@implementation PlaceCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return MLCellHeight;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.ttLabel];
    [self.contentView addSubview:self.ttTextField];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.ttLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.ttLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.ttLabel autoSetDimension:ALDimensionWidth toSize:80];
        
        [self.ttTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.ttLabel];
        [self.ttTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.ttLabel];
        [self.ttTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        
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
        
        MLWeakSelf;
        [_ttTextField.rac_textSignal subscribeNext:^(id x) {
            if (weakself.item.didEditting) {
                weakself.item.didEditting(x);
            }
        }];
        
    }
    return _ttTextField;
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
