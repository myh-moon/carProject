//
//  PlaceDetailCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PlaceDetailCell.h"

@implementation PlaceDetailCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return MLCellHeight;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    
    [self.contentView addSubview:self.ttTextView];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.ttTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
        [self.ttTextView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.ttTextView autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:middleSpacing];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UITextView *)ttTextView {
    if (!_ttTextView) {
        _ttTextView = [UITextView newAutoLayoutView];
        _ttTextView.text = @"输入详细街道地址";
        _ttTextView.textColor = MLDrakGrayColor;
        _ttTextView.textAlignment = NSTextAlignmentLeft;
    }
    return _ttTextView;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.ttTextView.text = @"qwqew1e";
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
