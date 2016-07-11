//
//  AboutWechatViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "AboutWechatViewController.h"

@interface AboutWechatViewController ()

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIButton *tableHeaderButton;

@property (nonatomic, strong) UILabel *tableHeaderLabel;

@end

@implementation AboutWechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于微信";
    self.baseDataSource = DS.aboutWechatData;
  

    self.settingBaseTableView.tableHeaderView = self.tableHeaderView;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.settingBaseTableView.tableFooterView = self.footerView;
}

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
    
        _tableHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tableHeaderButton setImage:[UIImage imageNamed:@"LoginBackground"] forState:UIControlStateNormal];
        _tableHeaderButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 100);
        _tableHeaderButton.adjustsImageWhenHighlighted = NO;
        [_tableHeaderButton addTarget:self action:@selector(tableHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _tableHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _tableHeaderLabel.font = [UIFont systemFontOfSize:17];
        _tableHeaderLabel.textColor = RGB(127, 128, 132);
        _tableHeaderLabel.textAlignment = 1;
        _tableHeaderLabel.text = @"微信 WeChat6.3.21";
        
        
        
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
        [_tableHeaderView addSubview:_tableHeaderLabel];
        [_tableHeaderView addSubview:_tableHeaderButton];
        
        
        _tableHeaderButton.centerY = _tableHeaderView.height/2-20;
        _tableHeaderButton.centerX = _tableHeaderView.width/2;
        _tableHeaderLabel.originY = _tableHeaderView.height/2+10;
        
        
        
    
    }
    return _tableHeaderView;
}


- (void)tableHeaderButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        _tableHeaderLabel.text = @"微信 WeChat 6.3.21.16";
    }else
    {
        _tableHeaderLabel.text = @"微信 WeChat 6.3.21";
    }
}


- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
    }
    return _footerView;
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
