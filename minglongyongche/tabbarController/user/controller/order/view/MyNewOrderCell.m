//
//  MyNewOrderCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/5/6.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "MyNewOrderCell.h"
#import "NSString+Attribute.h"

@implementation MyNewOrderCell

@dynamic item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
//    return 150;
    return 160;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.separatorInset = MLSeparatorInset;
    self.backgroundColor = MLBackGroundColor;
    
    [self.contentView addSubview:self.topBackView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.moneyImageView];
    [self.contentView addSubview:self.moneyButton];
    
    [self.contentView addSubview:self.bottomBackView];
    [self.contentView addSubview:self.carImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.feature1];
//    [self.contentView addSubview:self.feature2];
    
    [self.contentView addSubview:self.typeButton];
 
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.topBackView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, middleSpacing, 0, middleSpacing) excludingEdge:ALEdgeBottom];
        [self.topBackView autoSetDimension:ALDimensionHeight toSize:110];
        
        [self.timeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.topBackView withOffset:middleSpacing];
        [self.timeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.topBackView withOffset:middleSpacing];
        
        [self.moneyImageView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.topBackView];
        [self.moneyImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.topBackView];

        [self.moneyButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.topBackView withOffset:-middleSpacing];
        [self.moneyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.topBackView];
        [self.moneyButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.topBackView];

        
        [self.bottomBackView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, middleSpacing, 0, middleSpacing) excludingEdge:ALEdgeTop];
        [self.bottomBackView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topBackView withOffset:-smallSpacing];
        
        [self.carImage autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.bottomBackView withOffset:smallSpacing];
        [self.carImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.bottomBackView withOffset:-smallSpacing];
        [self.carImage autoSetDimensionsToSize:CGSizeMake(80, 60)];
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.carImage withOffset:smallSpacing];
        [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.bottomBackView withOffset:smallSpacing];
        
        [self.feature1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.feature1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.carImage];
        
        [self.typeButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.bottomBackView withOffset:-middleSpacing];
        [self.typeButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bottomBackView];


        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}


- (UIView *)topBackView {
    if (!_topBackView) {
        _topBackView = [UIView newAutoLayoutView];
        _topBackView.backgroundColor = MLOrangeColor;
        _topBackView.layer.cornerRadius = 10;
    }
    return _topBackView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel newAutoLayoutView];
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

- (UIImageView *)moneyImageView {
    if (!_moneyImageView) {
        _moneyImageView = [UIImageView newAutoLayoutView];
        [_moneyImageView setImage:[UIImage imageNamed:@"shading"]];
    }
    return _moneyImageView;
}

- (UIButton *)moneyButton {
    if (!_moneyButton) {
        _moneyButton = [UIButton newAutoLayoutView];
        _moneyButton.titleLabel.numberOfLines = 0;
        _moneyButton.userInteractionEnabled = NO;
    }
    return _moneyButton;
}

- (UIView *)bottomBackView {
    if (!_bottomBackView) {
        _bottomBackView = [UIView newAutoLayoutView];
        _bottomBackView.backgroundColor = MLWhiteColor;
    }
    return _bottomBackView;
}

- (UIImageView *)carImage {
    if (!_carImage) {
        _carImage = [UIImageView newAutoLayoutView];
        _carImage.layer.borderColor = MLWhiteColor.CGColor;
        _carImage.layer.borderWidth = 2;
    }
    return _carImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.textColor = MLDrakGrayColor;
        _nameLabel.font = MLFont3;
    }
    return _nameLabel;
}

- (UILabel *)feature1 {
    if (!_feature1) {
        _feature1 = [UILabel newAutoLayoutView];
        _feature1.textColor = MLLightGrayColor;
        _feature1.font = MLFont3;
    }
    return _feature1;
}

- (UIButton *)typeButton {
    if (!_typeButton) {
        _typeButton = [UIButton newAutoLayoutView];
        _typeButton.titleLabel.font = MLFont8;
        _typeButton.userInteractionEnabled = NO;
    }
    return _typeButton;
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    //用车时间
    NSString *timeme = [NSString stringWithFormat:@"%@ 至\n%@",self.item.qctime,self.item.hctime];
    self.timeLabel.attributedText = [NSString setFirstPart:@"预约用车时间：\n" firstFont:13 firstColor:MLWhiteColor secondPart:timeme secondFont:12 secongColor:MLWhiteColor space:6 align:0];
    
    //订单金额
    [self.moneyButton setAttributedTitle:[NSString setFirstPart:@"¥" firstFont:14 firstColor:MLWhiteColor secondPart:self.item.money secondFont:20 secongColor:MLWhiteColor thirdPart:@"\n订单金额" thirdFont:12 thirdColor:MLWhiteColor space:6 align:2] forState:0];
    
    
    //车信息
//    [self.carImage sd_setImageWithURL:[NSURL URLWithString:self.item.pic]];
    [self.carImage sd_setImageWithURL:[NSURL URLWithString:self.item.pic] placeholderImage:[UIImage imageNamed:@"defaultsb"]];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@  %@",self.item.namess,self.item.license];
    
    self.feature1.text = [NSString stringWithFormat:@"%@  %@",self.item.feature1,self.item.feature2];
    
    if ([self.item.status integerValue] == 0) {//未付款
        self.topBackView.backgroundColor = UIColorFromRGB(0x946657);
        [self.typeButton setTitle:@"未付款" forState:0];
        [self.typeButton setTitleColor:UIColorFromRGB(0x946657) forState:0];
    }else if([self.item.status integerValue] == 1 || [self.item.status integerValue] == 2){
        self.topBackView.backgroundColor = MLOrangeColor;
        [self.typeButton setTitle:@"进行中" forState:0];
        [self.typeButton setTitleColor:MLOrangeColor forState:0];
    }else if ([self.item.status integerValue] == 3 ){//已还车
        self.topBackView.backgroundColor = UIColorFromRGB(0xacabab);
        [self.typeButton setTitle:@"已完成" forState:0];
        [self.typeButton setTitleColor:UIColorFromRGB(0x946657) forState:0];
    }else if ([self.item.status integerValue] == 4){//已取消
        self.topBackView.backgroundColor = UIColorFromRGB(0xacabab);
        [self.typeButton setTitle:@"已取消" forState:0];
        [self.typeButton setTitleColor:UIColorFromRGB(0x946657) forState:0];
    }else if([self.item.status integerValue] == 5){//已删除
        self.topBackView.backgroundColor = UIColorFromRGB(0xacabab);
        [self.typeButton setTitle:@"已删除" forState:0];
        [self.typeButton setTitleColor:UIColorFromRGB(0x946657) forState:0];
    }else if ([self.item.status integerValue] == 6){//异常
        self.topBackView.backgroundColor = UIColorFromRGB(0xacabab);
        [self.typeButton setTitle:@"异常" forState:0];
        [self.typeButton setTitleColor:UIColorFromRGB(0x946657) forState:0];
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
