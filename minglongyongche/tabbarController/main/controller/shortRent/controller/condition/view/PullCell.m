//
//  PullCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/6/1.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PullCell.h"

@implementation PullCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 40;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.pullTextLabel];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.pullTextLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.pullTextLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)pullTextLabel {
    if (!_pullTextLabel) {
        _pullTextLabel = [UILabel newAutoLayoutView];
        _pullTextLabel.textColor = MLGrayColor;
        _pullTextLabel.font = MLFont;
    }
    return _pullTextLabel;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.pullTextLabel.text = self.item.conditionModel.name;
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
