//
//  SettingBaseViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SettingBaseViewController.h"
#import "SettingBaseTableViewCell.h"

static NSString *SETTINGBASECELLIDENTIFER = @"SETTINGBASECELLIDENTIFER";

@interface SettingBaseViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SettingBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setBaseDataSource:(NSArray *)baseDataSource
{
    _baseDataSource = baseDataSource;
    [self.settingBaseTableView reloadData];
}

/**
 *  懒加载tableiview
 */
- (UITableView *)settingBaseTableView {
    if (!_settingBaseTableView) {
        _settingBaseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
        [self.view addSubview:_settingBaseTableView];
        
        
        _settingBaseTableView.dataSource = self;
        _settingBaseTableView.delegate = self;
        _settingBaseTableView.backgroundColor = self.view.backgroundColor;
        
        // 设置cell的重用
        [_settingBaseTableView registerClass:[SettingBaseTableViewCell class] forCellReuseIdentifier:SETTINGBASECELLIDENTIFER];
        
        _settingBaseTableView.tableFooterView = [UIView new];
    }
    return _settingBaseTableView;
}

#pragma mark --
#pragma mark -- tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _baseDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _baseDataSource[section][newXinNotificationItemStr];
    return arr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = _baseDataSource[section];
    NSString *footerString = dic[newXinNotificationHeaderStr];
    CGSize returnSize = [footerString CalculationStringSizeWithWidth:SCREEN_WIDTH-40 font:[UIFont systemFontOfSize:12] space:15];
    if (section == 0 && returnSize.height <= 0) {
        return 20;
    }
    if (returnSize.height <= 0) {
        return 1;
    }
    return returnSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-40, 15)];
    headerLabel.font = [UIFont systemFontOfSize:13];
    headerLabel.numberOfLines = 0;
    headerLabel.textColor = RGB(128, 127, 132);
    
    NSDictionary *dic = _baseDataSource[section];
    NSString *headerString = dic[newXinNotificationHeaderStr];
    CGSize labelSize = [headerString CalculationStringSizeInView:headerLabel space:15];
    headerLabel.height = (labelSize.height/4)*3;
    headerLabel.originY = labelSize.height/4;
    headerLabel.text = headerString;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAX(1, labelSize.height))];
    [v addSubview:headerLabel];
    
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSDictionary *dic = _baseDataSource[section];
    NSString *footerString = dic[newXinNotificationFooterStr];
    CGSize returnSize = [footerString CalculationStringSizeWithWidth:SCREEN_WIDTH-40 font:[UIFont systemFontOfSize:15] space:15];
    
    if (returnSize.height <= 0) {
        return 20;
    }
    
    return returnSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-40, 15)];
    footerLabel.font = [UIFont systemFontOfSize:14];
    footerLabel.numberOfLines = 0;
    footerLabel.textColor = RGB(128, 127, 132);
    
    NSDictionary *dic = _baseDataSource[section];
    NSString *footerString = dic[newXinNotificationFooterStr];
    CGSize labelSize = [footerString CalculationStringSizeInView:footerLabel space:15];
    footerLabel.height = labelSize.height;
    footerLabel.text = footerString;
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footerLabel.height)];
    [v addSubview:footerLabel];
    
    
    return v;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SETTINGBASECELLIDENTIFER forIndexPath:indexPath];
    
    NSDictionary *dic = _baseDataSource[indexPath.section];
    NSArray *itemArr = dic[newXinNotificationItemStr];
    cell.datasource = itemArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self basetableView:tableView didSelectRowAtIndexPath:indexPath];
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
