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


@property (nonatomic, strong) UIButton *tableHeaderButton;

@property (nonatomic, strong) UILabel *tableHeaderLabel;

@property (nonatomic, strong) UIButton *serviceAgreementButton;

@property (nonatomic, strong) UILabel *banquanLabel;

@end

@implementation AboutWechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于微信";
    self.baseDataSource = DS.aboutWechatData;
  

    self.settingBaseTableView.tableHeaderView = self.tableHeaderView;
    
    
    _serviceAgreementButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.settingBaseTableView.height-60, SCREEN_WIDTH, 20)];
    [_serviceAgreementButton setTitle:@"微信软件许可服务协议" forState:UIControlStateNormal];
    [_serviceAgreementButton setTitleColor:RGB(101, 107, 120) forState:UIControlStateNormal];
    _serviceAgreementButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [_serviceAgreementButton addTarget:self action:@selector(serviceAgreementButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.settingBaseTableView addSubview:_serviceAgreementButton];
    
    
    _banquanLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_serviceAgreementButton.frame)+5, SCREEN_WIDTH, 30)];
    _banquanLabel.font = [UIFont systemFontOfSize:11];
    _banquanLabel.textAlignment = 1;
    _banquanLabel.numberOfLines = 0;
    _banquanLabel.text = @"腾讯公司 版权所有\nCopyright © 2011-2016 Tencent.All Rights Reserved.";
    _banquanLabel.textColor = RGB(159, 159, 159);
    [self.settingBaseTableView addSubview:_banquanLabel];
    
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

- (void)serviceAgreementButtonClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"好" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}


- (void)basetableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
