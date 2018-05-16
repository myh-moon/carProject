//
//  CarDetailConfigCell.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/4.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "CarDetailConfigCell.h"

@implementation CarDetailConfigCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager {
    return 80 * 4 + 70;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    [self.contentView addSubview:self.configLabel];
    
    [self.contentView addSubview:self.configCollectionView];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.configLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:middleSpacing];
        [self.configLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:middleSpacing];
        
        [self.configCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, middleSpacing, 0) excludingEdge:ALEdgeTop];
        [self.configCollectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.configLabel withOffset:middleSpacing];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)configLabel {
    if (!_configLabel) {
        _configLabel = [UILabel newAutoLayoutView];
        _configLabel.textColor = MLBlackColor;
        _configLabel.text = @"车辆配置";
        _configLabel.font = MLFont4;
    }
    return _configLabel;
}

- (UICollectionView *)configCollectionView {
    if (!_configCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(MLWindowWidth/4, 80);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _configCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _configCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _configCollectionView.delegate = self;
        _configCollectionView.dataSource = self;
        _configCollectionView.backgroundColor = MLWhiteColor;
        [_configCollectionView registerClass:[ConfigCollectionCell class] forCellWithReuseIdentifier:@"config"];
        
    }
    return _configCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.configArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ConfigCollectionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"config" forIndexPath:indexPath];
    
    if (!collectionCell) {
        collectionCell = [[ConfigCollectionCell alloc] init];
    }
    
    NSArray *iiiArr = @[@"gas-station",@"parking-4",@"parking_89",@"airbag",@"skylight",@"engine",@"exhaust",@"drive",@"window",@"seat",@"seatfabrics",@"GPS",@"sound",@"airbag_windows"];
    
    [collectionCell.coImageView setImage:[UIImage imageNamed:iiiArr[indexPath.item]]];
    collectionCell.coLabel.text = self.item.configArray[indexPath.item];
 
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    [self.configCollectionView reloadData];

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
