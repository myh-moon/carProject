//
//  BrandCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/6/1.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "BrandCell.h"

@implementation BrandCell

@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 40;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.brandTextLabel];
    
    [self  setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.brandTextLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.brandTextLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)brandTextLabel {
    if (!_brandTextLabel) {
        _brandTextLabel = [UILabel newAutoLayoutView];
        _brandTextLabel.textColor = MLGrayColor;
        _brandTextLabel.font = MLFont;
    }
    return _brandTextLabel;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.brandTextLabel.text = self.item.names;
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
