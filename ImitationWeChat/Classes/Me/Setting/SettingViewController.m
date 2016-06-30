//
//  SettingViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/23.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SettingViewController.h"
#import "UserCenterRequest.h"
#import "LXActionSheet.h"
#define SETTINGTABLEVIEWCELLIDENTIFIER  @"SETTINGTABLEVIEWCELLIDENTIFIER"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource, LXActionSheetDelegate>

@property (nonatomic, strong) UITableView *settingTableView;
@property (nonatomic, strong) NSArray *datasource;

@property (nonatomic, strong) UIButton *logoutButton;

@property (nonatomic, strong) LXActionSheet *actionSheet;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configNav];
    
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
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
        [self.view addSubview:_settingTableView];

        
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        _settingTableView.backgroundColor = self.view.backgroundColor;
        
        // 设置cell的重用
        [_settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SETTINGTABLEVIEWCELLIDENTIFIER];
        
        _settingTableView.tableFooterView = self.logoutButton;
    }
    return _settingTableView;
}

- (void)configNav
{
    self.title = @"设置";
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    v.backgroundColor = self.view.backgroundColor;
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    v.backgroundColor = self.view.backgroundColor;
    return v;
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
    self.actionSheet = [[LXActionSheet alloc]initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号。" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"退出登录", nil];

    [self.actionSheet showInView:self.view];
}

- (void)didClickOnButtonIndex:(int)buttonIndex
{
    if (buttonIndex == 0) {
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate logout];
    }
}

@end
