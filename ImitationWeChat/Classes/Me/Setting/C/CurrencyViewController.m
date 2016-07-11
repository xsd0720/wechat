//
//  CurrencyViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "CurrencyViewController.h"

@interface CurrencyViewController ()

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *footerButton;

@end

@implementation CurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通用";
    self.baseDataSource = DS.currencyData;
    

    self.settingBaseTableView.tableFooterView = self.footerView;
}

- (UIButton *)footerButton
{
    if (!_footerButton) {
        _footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _footerButton.frame = CGRectMake(0, 10, SCREEN_WIDTH, 44);
        _footerButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _footerButton.backgroundColor = [UIColor whiteColor];
        [_footerButton setTitle:@"清空聊天记录" forState:UIControlStateNormal];
        [_footerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_footerButton addTarget:self action:@selector(footerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerButton;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:self.footerButton.bounds];
        _footerView.height += 50;
        [_footerView addSubview:self.footerButton];
    }
    return _footerView;
}

- (void)footerButtonClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"清空完毕" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
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
