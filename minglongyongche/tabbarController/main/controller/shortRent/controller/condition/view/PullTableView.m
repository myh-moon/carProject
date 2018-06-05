//
//  PullTableView.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/12.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "PullTableView.h"
#import "ConditionModel.h"

#import "PullItem.h"

@implementation PullTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tableFooterView = [UIView new];
        
        self.manager = [[RETableViewManager alloc] initWithTableView:self];
        
        self.manager[@"PullItem"] = @"PullCell";
        
    }
    return self;
}

- (void)loadAllData:(NSArray *)array {
    
    [self.manager removeAllSections];
    
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    if ([self.signType isEqualToString:@"地址"]) {
        for (NSInteger i=0; i<array.count; i++) {
            
            MLWeakSelf;
            RETableViewItem *item = [[RETableViewItem alloc] initWithTitle:array[i] accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
                if (weakself.didSelectedItem) {
                    weakself.didSelectedItem(array[i],@"");
                }
            }];

            item.cellHeight = 40;
            [section addItem:item];
        }

    }else {
        
        for (NSInteger i=0; i<array.count; i++) {
            
            ConditionModel *model = array[i];
            
            MLWeakSelf;
            PullItem *item0 = [[PullItem alloc] init];
            item0.conditionModel = model;
            item0.selectionStyle = UITableViewCellSelectionStyleNone;
            item0.cellHeight = 40;
            item0.selectionHandler = ^(id item) {
                if (weakself.didSelectedItem) {
                    weakself.didSelectedItem(model.name,model.pid);
                }
            };
            [section addItem:item0];
//            RETableViewItem *item = [[RETableViewItem alloc] initWithTitle:model.name accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
//                if (weakself.didSelectedItem) {
//                    weakself.didSelectedItem(model.name, model.pid);
//                }
//            }];
//
//            item.cellHeight = 40;
//            [section addItem:item];
        }
    }
    
    [self reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
