//
//  UserCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/8.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 170;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
//    self.sele = NO;
    
    [self.contentView addSubview:self.settingButton];
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.userNameButton];
    [self.contentView addSubview:self.userAuthenBtn];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.settingButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:middleSpacing];
        [self.settingButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        
        [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:middleSpacing];
        [self.userImageView autoSetDimensionsToSize:CGSizeMake(65,65)];
        [self.userImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.userNameButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.userImageView];
        [self.userNameButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userImageView withOffset:smallSpacing];
        
        [self.userAuthenBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:self.userNameButton];
        [self.userAuthenBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userNameButton withOffset:bigSpacing];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UIButton *)settingButton {
    if (!_settingButton) {
        _settingButton = [UIButton newAutoLayoutView];
        [_settingButton setImage:[UIImage imageNamed:@"mine_setting"] forState:0];
        MLWeakSelf;
        [_settingButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(87);
            }
        }];
    }
    return _settingButton;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [UIImageView newAutoLayoutView];
        _userImageView.layer.cornerRadius = 32.5;
        _userImageView.layer.masksToBounds = YES;
    }
    return _userImageView;
}

- (UIButton *)userNameButton {
    if (!_userNameButton) {
        _userNameButton = [UIButton newAutoLayoutView];
        _userNameButton.titleLabel.font = MLFont5;
        [_userNameButton setTitleColor:MLBlackColor forState:0];
        [_userNameButton swapImage];
        [_userNameButton setImage:[UIImage imageNamed:@"arrow_right"] forState:0];
        
        MLWeakSelf;
        [_userNameButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(88);
            }
        }];
    }
    return _userNameButton;
}

- (UIButton *)userAuthenBtn {
    if (!_userAuthenBtn) {
        _userAuthenBtn = [UIButton newAutoLayoutView];
        _userAuthenBtn.titleLabel.font = MLFont1;
        [_userAuthenBtn setTitleColor:MLLightGrayColor forState:0];
        
        MLWeakSelf;
        [_userAuthenBtn addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(89);
            }
        }];
    }
    return _userAuthenBtn;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    [self.userImageView setImage:[UIImage imageNamed:@"moreng"]];    
    
    [self.userNameButton setTitle:self.item.userName forState:0];
    
    NSString *aaaa = [[NSUserDefaults standardUserDefaults] objectForKey:@"authen"];
    if ([aaaa isEqualToString:@"200"]) {
        [self.userAuthenBtn setAttributedTitle: [NSString setFirstPart:@"认证成功" firstFont:10 firstColor:MLLightGrayColor secondPart:@"" secondFont:0 secongColor:MLGrayColor] forState:0];
        self.userAuthenBtn.userInteractionEnabled = YES;
    }else if ([aaaa isEqualToString:@"403"]){
        self.userAuthenBtn.userInteractionEnabled = YES;
        [self.userAuthenBtn setAttributedTitle: [NSString setFirstPart:@"您还未通过实名验证，" firstFont:10 firstColor:MLLightGrayColor secondPart:@"去认证" secondFont:10 secongColor:MLGrayColor] forState:0];
    }else{
        NSAttributedString *sdsd = [[NSAttributedString alloc] initWithString:@""];
        [self.userAuthenBtn setAttributedTitle:sdsd forState:0];
        self.userAuthenBtn.userInteractionEnabled = NO;
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
