//
//  AuthenCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/26.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AuthenCell.h"

@implementation AuthenCell

@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return MLCellHeight;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.messageTextField];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.nameLabel autoSetDimension:ALDimensionWidth toSize:60];
        
        [self.messageTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nameLabel withOffset:middleSpacing];
        [self.messageTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        [self.messageTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.textColor = MLDrakGrayColor;
        _nameLabel.font = MLFont;
    }
    return _nameLabel;
}

- (UITextField *)messageTextField {
    if (!_messageTextField) {
        _messageTextField = [UITextField newAutoLayoutView];
        _messageTextField.textColor = MLBlackColor;
        _messageTextField.font = MLFont;
        _messageTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        MLWeakSelf;
        [_messageTextField.rac_textSignal subscribeNext:^(id x) {
            if (weakself.item.didEndEditingText) {
                weakself.item.didEndEditingText(x);
            }
        }];
    }
    return _messageTextField;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.nameLabel.text = self.item.namess;
    self.messageTextField.placeholder = self.item.placeholder;

    self.separatorInset = self.item.showSeperates?UIEdgeInsetsMake(0, middleSpacing, 0, 0):MLSeparatorInset;
}

@end
