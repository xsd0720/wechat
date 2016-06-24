//
//  BaseViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(240, 239, 245);
    /*
     默认值是YES，允许视图控制器来调整以响应状态栏，导航栏占用的屏幕区域的滚动视图插图和工具栏和标签栏。设置为NO，如果你要管理滚动视图插入调整自己，比如当在视图层次以上的滚动视图。
     */
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /*
     如果视图控制器返回YES，那么它提供了一个演示环境。覆盖视图控制器的视图窗口的部分决定了呈现视图控制器的视图的大小。此属性的默认值是NO。(我也不理解，有知道的可以解释下,设为yes,弹出的搜索栏高度会填充到状态栏)
     */
    self.definesPresentationContext = YES;
    
    
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
