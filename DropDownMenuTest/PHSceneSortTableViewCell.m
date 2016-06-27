//
//  PHSceneSortTableViewCell.m
//  LrdSuperMenu
//
//  Created by Y杨定甲 on 16/6/2.
//  Copyright © 2016年 键盘上的舞者. All rights reserved.
//

#import "PHSceneSortTableViewCell.h"

@interface PHSceneSortTableViewCell ()

@end

@implementation PHSceneSortTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)pushWithItemName:(NSString *)str{
    self.itemName.text = str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
