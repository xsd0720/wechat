//
//  FunXinNotDisturbViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "FunXinNotDisturbViewController.h"
#import "FunXinNotDisturbTableViewCell.h"

static NSString *FUNXINNOTDISTURBCELLIDENTIFIER = @"FUNXINNOTDISTURBCELLIDENTIFIER";

@interface FunXinNotDisturbViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *funXinNotDisturbTableView;

@end

@implementation FunXinNotDisturbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"功能消息免打扰";
    
    [self.funXinNotDisturbTableView reloadData];
    
    NSArray *arr = [self.funXinNotDisturbTableView visibleCells];
    UITableViewCell *cell = arr[0];
    cell.accessoryView.hidden = NO;
}


/**
 *  懒加载tableiview
 */
- (UITableView *)funXinNotDisturbTableView {
    if (!_funXinNotDisturbTableView) {
        _funXinNotDisturbTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
        [self.view addSubview:_funXinNotDisturbTableView];
        
        
        _funXinNotDisturbTableView.dataSource = self;
        _funXinNotDisturbTableView.delegate = self;
        _funXinNotDisturbTableView.backgroundColor = self.view.backgroundColor;
        
        // 设置cell的重用
        [_funXinNotDisturbTableView registerClass:[FunXinNotDisturbTableViewCell class] forCellReuseIdentifier:FUNXINNOTDISTURBCELLIDENTIFIER];
        
        _funXinNotDisturbTableView.tableFooterView = [UIView new];
    }
    return _funXinNotDisturbTableView;
}

#pragma mark --
#pragma mark -- tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return DS.funXinNotDisturbData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = DS.funXinNotDisturbData[section][newXinNotificationItemStr];
    return arr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSDictionary *dic = DS.funXinNotDisturbData[section];
    NSString *footerString = dic[newXinNotificationFooterStr];
    CGSize returnSize = [footerString CalculationStringSizeWithWidth:SCREEN_WIDTH-40 font:[UIFont systemFontOfSize:15]];
    return returnSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 20)];
    footerLabel.font = [UIFont systemFontOfSize:15];
    footerLabel.numberOfLines = 0;
    footerLabel.textColor = RGB(128, 127, 132);
    
    NSDictionary *dic = DS.funXinNotDisturbData[section];
    NSString *footerString = dic[newXinNotificationFooterStr];
    CGSize labelSize = [footerString CalculationStringSizeInView:footerLabel];
    footerLabel.height = labelSize.height;
    footerLabel.text = footerString;
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footerLabel.height)];
    [v addSubview:footerLabel];
    
    
    return v;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunXinNotDisturbTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FUNXINNOTDISTURBCELLIDENTIFIER forIndexPath:indexPath];
    
    NSDictionary *dic = DS.funXinNotDisturbData[indexPath.section];
    NSArray *itemArr = dic[newXinNotificationItemStr];
    cell.datasource = itemArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *arr = [tableView visibleCells];
    for (UITableViewCell *cell in arr) {
        cell.accessoryView.hidden = YES;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView.hidden = NO;
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
