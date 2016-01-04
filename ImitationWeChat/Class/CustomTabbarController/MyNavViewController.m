//
//  MyNavViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "MyNavViewController.h"

@interface MyNavViewController ()

@end

@implementation MyNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = RGBCOLOR(20, 20, 20);
    
    self.navigationBar.barStyle = UIBarStyleBlackOpaque;
  
    //系统返回默认蓝色 改成白色
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 A -> B
 此方法应该在 A 面的点击跳转方法中实现
 */
//设置返回按钮
- (void)setNavigationBackButton:(NSString *)title image:(UIImage *)image viewController:(UIViewController *)viewController
{
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] init];
    backBarBtn.title = [NSString stringWithFormat:@"%@",title];
    UIImage *img = image;
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:img forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    viewController.navigationItem.backBarButtonItem = backBarBtn;

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
