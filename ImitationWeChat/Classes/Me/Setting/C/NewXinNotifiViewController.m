//
//  NewXinNotifiViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "NewXinNotifiViewController.h"
#import "FunXinNotDisturbViewController.h"

@interface NewXinNotifiViewController ()

@end

@implementation NewXinNotifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新消息通知";
    self.baseDataSource = DS.newXinNotificationData;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FunXinNotDisturbViewController *funxinNotDisturbVC = [[FunXinNotDisturbViewController alloc] init];
    [self.navigationController pushViewController:funxinNotDisturbVC animated:YES];
    
}
//
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
