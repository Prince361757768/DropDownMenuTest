//
//  MenuView.m
//  DropDownMenuTest
//
//  Created by lucky on 16/5/31.
//  Copyright © 2016年 Lukcy. All rights reserved.
//

#import "MenuView.h"
#import "PHSceneSortTableViewCell.h"
#import "PHSceneSortRightCell.h"
#define CellHeight 41.0;
@interface MenuView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView *firstTabView;
@property (nonatomic,strong) UITableView *secondTabview;
@property (nonatomic,strong) UIView *darkBgView;
@property (nonatomic,strong) NSArray *selectArray;//二级数组个数

@property (nonatomic,strong) NSArray *firstArray;
@property (nonatomic,strong) NSMutableArray *secondArray;
@property (nonatomic,assign) NSInteger type;//菜单  左右
@property (nonatomic,assign) CGFloat tableViewHeight;//两个tableview都要用，选大值

@end
@implementation MenuView
static NSInteger _firstIndex = 0;
static NSInteger _secondIndex = 0;
- (instancetype)initWithFrame:(CGRect)frame contentArray:(NSArray *)contentArr type: (NSInteger)type{
    
    if (self = [super initWithFrame:frame]) {
        _type = type;
        _firstArray = contentArr;
        
        [self initSetting];
    }
    return self;
}
- (void)initSetting{
    
    _secondArray = [NSMutableArray array];
    _selectArray = [NSArray array];
    if (_type == 0) {
        for (NSDictionary *dic in _firstArray) {
            [_secondArray addObject:dic[@"area"]];
        }
    }
    //先需要把数据获取出来再添加给第二个tableview
    _selectArray = _secondArray[_firstIndex];
    self.userInteractionEnabled = YES;
    [self setBaseUI];
    
    [self.firstTabView registerNib:[UINib nibWithNibName:@"PHSceneSortTableViewCell" bundle:nil] forCellReuseIdentifier:@"PHSceneSortTableViewCell"];
    [self.secondTabview registerNib:[UINib nibWithNibName:@"PHSceneSortRightCell" bundle:nil] forCellReuseIdentifier:@"PHSceneSortRightCell"];
    
}
//懒加载
- (UITableView *)firstTabView{

    if (!_firstTabView) {
        _firstTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,_type == 0 ?SCREEN_WIDTH/3 : SCREEN_WIDTH, self.tableViewHeight) style:UITableViewStylePlain];
        _firstTabView.delegate = self;
        _firstTabView.dataSource = self;
        _firstTabView.showsVerticalScrollIndicator = NO;

        _firstTabView.tag = 1000;
        
    }
    
    return _firstTabView;
}
- (UITableView *)secondTabview{
    CGFloat leftHeight = 41 *(_firstArray.count);
    CGFloat rightHeight = 41 *(_selectArray.count);
    self.tableViewHeight = MAX(leftHeight, rightHeight);
    if (!_secondTabview) {
        _secondTabview = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3*2, self.tableViewHeight) style:UITableViewStylePlain];
        _secondTabview.delegate = self;
        _secondTabview.dataSource = self;
        _secondTabview.tag = 2000;
        _secondTabview.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    //由于有第一个视图就肯定有第二个视图，所有视图刷新放在第二个视图即可。
    _firstTabView.frame = CGRectMake(0, 0,_type == 0 ?SCREEN_WIDTH/3 : SCREEN_WIDTH, self.tableViewHeight);
    _secondTabview.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3*2, self.tableViewHeight);
    return _secondTabview;
}

- (void)setBaseUI{
    
    _darkBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstTabView.frame), SCREEN_WIDTH, self.frame.size.height-CGRectGetMaxY(self.firstTabView.frame))];
    _darkBgView.userInteractionEnabled = YES;
    _darkBgView.backgroundColor = [UIColor colorWithWhite:.7 alpha:.3];
    [self addSubview:_darkBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_darkBgView addGestureRecognizer:tap];
    [self addSubview:self.firstTabView];
    [self addSubview:self.secondTabview];
}
- (void)tapAction{
    //-1代表用户未操作
    _block(NO,nil,-1,-1);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1000) {
        return _firstArray.count;
    }else{
        
        return _selectArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 1000) {
        static NSString *cellMark = @"PHSceneSortTableViewCell";
        PHSceneSortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMark];
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellMark forIndexPath:indexPath];
        }
        cell.backgroundColor = [UIColor whiteColor];
        if (_type == 0) {
            NSString *str = [NSString stringWithFormat:@"%@",_firstArray[indexPath.row][@"name"]];
            [cell pushWithItemName:str];
        }else{
            
            NSString *str = [NSString stringWithFormat:@"%@",_firstArray[indexPath.row]];
            [cell pushWithItemName:str];
        }
        
        if (_firstIndex == indexPath.row) {
            [cell.itemName setTextColor:[UIColor redColor]];
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else{
            [cell.itemName setTextColor:[UIColor blackColor]];
            cell.backgroundColor = [UIColor whiteColor];
        }
        return cell;
        
    }else{
        static NSString *cellMark = @"PHSceneSortRightCell";
        PHSceneSortRightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMark];
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellMark forIndexPath:indexPath];
        }
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];

        if (_selectArray.count == 0) {
            cell.itemNameLabel.text = @"全部";
        }else{
            cell.itemNameLabel.text = [NSString stringWithFormat:@"%@",_selectArray[indexPath.row][@"name"]];
        }
        if (_secondIndex == indexPath.row) {
            [cell.itemNameLabel setTextColor:[UIColor redColor]];
            
        }else{
            [cell.itemNameLabel setTextColor:[UIColor blackColor]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == 0) {
        if (tableView.tag == 1000) {
            _selectArray = _secondArray[indexPath.row];
            [UIView animateWithDuration:0.3 animations:^{

                [self addSubview:self.secondTabview];
                
                _firstIndex = indexPath.row;//第一个选中的数组下标
                
                [_firstTabView reloadData];
                [_secondTabview reloadData];
            }];
            
        }else{
            
            NSString *name = [NSString stringWithFormat:@"%@",_selectArray[indexPath.row][@"name"]];
            if ([name isEqualToString:@"全部"]) {
                NSString *nameStr = [NSString stringWithFormat:@"%@",_firstArray[_firstIndex][@"name"]];
                _block(NO,nameStr,_firstIndex,indexPath.row);
            }else{
                _block(NO,name,_firstIndex,indexPath.row);
                
            }
            _secondIndex = indexPath.row;
            [_secondTabview reloadData];
            
        }
    }else{
        if (tableView.tag == 1000) {
            _firstIndex = indexPath.row;
            _block(NO,_firstArray[indexPath.row],indexPath.row,0);
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}
@end
