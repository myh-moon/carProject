//
//  PlaceChooseCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PlaceChooseCell.h"

@implementation PlaceChooseCell

@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return MLCellHeight;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.ttLabel];
    [self.contentView addSubview:self.ttButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.ttLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.ttLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.ttButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        [self.ttButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.ttLabel];
    }
    [super updateConstraints];
}

- (UILabel *)ttLabel {
    if (!_ttLabel) {
        _ttLabel = [UILabel newAutoLayoutView];
        _ttLabel.textColor = MLDrakGrayColor;
        _ttLabel.font = MLFont;
        _ttLabel.text = @"设为默认联系地址";
    }
    return _ttLabel;
}

- (UIButton *)ttButton {
    if (!_ttButton) {
        _ttButton = [UIButton newAutoLayoutView];
        [_ttButton setImage:[UIImage imageNamed:@"checked_circle_bg"] forState:UIControlStateSelected];
        
        MLWeakSelf;
        [_ttButton addAction:^(UIButton *btn) {
            btn.selected = !btn.selected;
            
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(@"默认地址");
            }
        }];
    }
    return _ttButton;
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
