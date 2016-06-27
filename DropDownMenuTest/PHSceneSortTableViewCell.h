//
//  PHSceneSortTableViewCell.h
//  LrdSuperMenu
//
//  Created by Y杨定甲 on 16/6/2.
//  Copyright © 2016年 键盘上的舞者. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHSceneSortTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemName;


- (void)pushWithItemName:(NSString *)str;

@end
