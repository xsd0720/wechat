//
//  SettingViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/23.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SettingViewController.h"
#import "UserCenterRequest.h"

#define SETTINGTABLEVIEWCELLIDENTIFIER  @"SETTINGTABLEVIEWCELLIDENTIFIER"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTableView;
@property (nonatomic, strong) NSArray *datasource;

@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configLocalData];
    
    [self.settingTableView reloadData];
}

- (UIButton *)logoutButton
{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        _logoutButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _logoutButton.backgroundColor = [UIColor whiteColor];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

/**
 *  懒加载tableiview
 */
- (UITableView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_settingTableView];

        
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        
        _settingTableView.tableFooterView = [UIView new];
        _settingTableView.backgroundColor = [UIColor getColor:@"F0F1F3"];
        
        // 设置cell的重用
        [_settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SETTINGTABLEVIEWCELLIDENTIFIER];
        
        _settingTableView.tableFooterView = self.logoutButton;
    }
    return _settingTableView;
}

- (void)configLocalData
{
    _datasource = @[
                    @[@"账号与安全"],
                    @[@"新消息通知", @"隐私", @"通用"],
                    @[@"帮助与反馈", @"关于微信"],
                    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _datasource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datasource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _datasource.count-1) {
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SETTINGTABLEVIEWCELLIDENTIFIER forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _datasource[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)logoutClick
{
    
}

@end
