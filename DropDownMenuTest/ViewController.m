//
//  ViewController.m
//  DropDownMenuTest
//
//  Created by lucky on 16/5/31.
//  Copyright © 2016年 Lukcy. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,strong) MenuView *expandView;
@property (nonatomic,strong) NSArray *cityArray;
@property (nonatomic,strong) NSArray *timeArray;
@property (nonatomic,strong) NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"下拉菜单";
    self.navigationController.navigationBar.translucent = NO;
    [self initTitlebar];
    [self initDefaultArray];
}

- (void)initDefaultArray{
    
    _cityArray = [NSArray array];
    _timeArray = [NSArray array];
    
    _cityArray = @[
                   @{
                       @"area" :@[
                               @{
                                   @"name":@"东城区"
                                   
                                   },
                               @{
                                   @"name":@"西城区"
                                   
                                   },
                               @{
                                   @"name":@"朝阳区"
                                   }
                               ],
                       
                       @"name" : @"北京"
                       },
                   @{
                       @"area" :@[
                               @{
                                   @"name":@"徐汇区"

                                   },
                               @{
                                   @"name":@"普陀区"

                                   },
                               @{
                                   @"name":@"松江区"
                                   },
                               @{
                                   @"name":@"浦东"
                                   
                                   },
                               @{
                                   @"name":@"虹口区"
                                   
                                   },
                               @{
                                   @"name":@"静安区"
                                   
                                   }
                               ],
                       
                       @"name" : @"上海"
                       },
                   @{
                       @"area" :@[
                               @{
                                   @"name":@"第一个"

                                   },
                               @{
                                   @"name":@"第二个"

                                   }
                               ],
                       
                       @"name" : @"深圳"
                       },
                   @{
                       @"area" :@[
                               @{
                                   @"name":@"长沙"
                                   },
                               @{
                                   @"name":@"娄底"
                                },
                               @{
                                  @"name":@"株洲"
                                   }
                               ],
                       
                       @"name" : @"湖南"
                       }
                    ];
    
    
    _timeArray = @[@"00:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00"];
}
- (void)initTitlebar{
    
    NSArray *titleArray = @[@"选择城市"];
    _buttonArray = [NSMutableArray array];
    for (int i = 0; i<titleArray.count; i++) {
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(SCREEN_WIDTH/titleArray.count*i,0 ,SCREEN_WIDTH/titleArray.count, 40);
        bt.layer.borderColor = [UIColor blackColor].CGColor;
        bt.layer.borderWidth = .5;
        [bt setTitle:titleArray[i] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"icon_down"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"icon_up"] forState:UIControlStateSelected];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        bt.selected = NO;
        bt.tag = 1000+i;
        [bt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArray addObject:bt];
        [self.view addSubview:bt];
    }
}
- (void)buttonAction:(UIButton *)button{
    
    [_expandView removeFromSuperview];
    
    for (UIButton *selectBt in _buttonArray) {
        
        if (selectBt == button) {
            
            selectBt.selected = !selectBt.selected;
            if (selectBt.selected == YES) {
                NSInteger type;
                if (button.tag == 1000) {
                    _dataArray = _cityArray;
                    type = 0;
                }else if (button.tag == 1001){
                    _dataArray = _timeArray;
                    type = 1;
                }
                _expandView= [[MenuView alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, SCREEN_HEIGHT-40-40) contentArray:_dataArray type:type];
                __weak typeof (MenuView *) weakSelf = _expandView;
                _expandView.block = ^(BOOL isSeletct ,NSString *title ,NSInteger leftIndex ,NSInteger rightIndex){
                    
                    selectBt.selected = isSeletct;
                    [weakSelf removeFromSuperview];
                    if (title.length != 0) {
                        [button setTitle:title forState:UIControlStateNormal];
                    }
                };
                
                [self.view addSubview:_expandView];
            }else{
                [_expandView removeFromSuperview];
            }
            
        }else{
            
            selectBt.selected = NO;
        }
        
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
