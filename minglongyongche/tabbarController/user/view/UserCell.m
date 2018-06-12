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
    return 220+15;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
//    self.sele = NO;
    
    [self.contentView addSubview:self.settingButton];
    [self.contentView addSubview:self.userImageButton];
    [self.contentView addSubview:self.userNameButton];
    [self.contentView addSubview:self.userAuthenBtn];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.settingButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
        [self.settingButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:middleSpacing];
        [self.settingButton autoSetDimensionsToSize:CGSizeMake(40, 40)];
        
//        [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:middleSpacing*2];
        [self.userImageButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.settingButton];
        [self.userImageButton autoSetDimensionsToSize:CGSizeMake(65,65)];
        [self.userImageButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.userNameButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.userImageButton];
        [self.userNameButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userImageButton withOffset:smallSpacing];
        
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
        _settingButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _settingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _settingButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        
        MLWeakSelf;
        [_settingButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(87);
            }
        }];
    }
    return _settingButton;
}

- (UIButton *)userImageButton {
    if (!_userImageButton) {
        _userImageButton = [UIButton newAutoLayoutView];
        _userImageButton.layer.cornerRadius = 32.5;
        _userImageButton.layer.masksToBounds = YES;
        
        MLWeakSelf;
        [_userImageButton addAction:^(UIButton *btn) {
            if (weakself.item.didSelectedBtn) {
                weakself.item.didSelectedBtn(88);
            }
        }];
    }
    return _userImageButton;
}

- (UIButton *)userNameButton {
    if (!_userNameButton) {
        _userNameButton = [UIButton newAutoLayoutView];
        _userNameButton.titleLabel.font = MLFont5;
        [_userNameButton setTitleColor:MLDrakGrayColor forState:0];
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
        _userAuthenBtn.titleLabel.font = MLFont;
        [_userAuthenBtn setTitleColor:MLLightGrayColor forState:0];
        [_userAuthenBtn swapImage];
        
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
    
//    [self.userImageView setImage:[UIImage imageNamed:@"moreng"]];
    [self.userImageButton setImage:[UIImage imageNamed:@"moreng"] forState:0];
    [self.userNameButton setTitle:self.item.userName forState:0];
    
    NSString *aaaa = [[NSUserDefaults standardUserDefaults] objectForKey:@"authen"];
    if ([aaaa isEqualToString:@"200"]) {
        [self.userAuthenBtn setAttributedTitle: [NSString setFirstPart:@"尊贵会员，" firstFont:13 firstColor:MLLightGrayColor secondPart:@"已实名认证  " secondFont:13 secongColor:UIColorFromRGB(0xff9900)] forState:0];
        
        [self.userAuthenBtn setImage:[UIImage imageNamed:@"authentication"] forState:0];
        self.userAuthenBtn.userInteractionEnabled = YES;
    }else if ([aaaa isEqualToString:@"403"]){
        self.userAuthenBtn.userInteractionEnabled = YES;
        [self.userAuthenBtn setAttributedTitle: [NSString setFirstPart:@"您还未通过实名验证，" firstFont:13 firstColor:MLLightGrayColor secondPart:@"去认证" secondFont:13 secongColor:UIColorFromRGB(0xff9900)] forState:0];
        [self.userAuthenBtn setImage:[UIImage imageNamed:@"we"] forState:0];
    }else{
        NSAttributedString *sdsd = [[NSAttributedString alloc] initWithString:@""];
        [self.userAuthenBtn setAttributedTitle:sdsd forState:0];
        [self.userAuthenBtn setImage:[UIImage imageNamed:@"we"] forState:0];
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
