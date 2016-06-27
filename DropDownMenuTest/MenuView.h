//
//  MenuView.h
//  DropDownMenuTest
//
//  Created by lucky on 16/5/31.
//  Copyright © 2016年 Lukcy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectBlock)(BOOL isSelect ,NSString *selectStr ,NSInteger leftIndex ,NSInteger rightIndex);

@interface MenuView : UIView

@property (nonatomic,copy) SelectBlock block;
- (instancetype)initWithFrame:(CGRect)frame contentArray:(NSArray *)contentArr type: (NSInteger)type;

@end
