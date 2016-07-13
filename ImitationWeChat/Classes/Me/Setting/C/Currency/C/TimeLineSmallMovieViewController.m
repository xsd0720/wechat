//
//  TimeLineSmallMovieViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/12.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimeLineSmallMovieViewController.h"

@interface TimeLineSmallMovieViewController ()

@end

@implementation TimeLineSmallMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友圈小视频";
    self.baseDataSource = DS.timeLineSmallMovieData;
    
    NSArray *arr = [self.settingBaseTableView visibleCells];
    UITableViewCell *cell = arr[0];
    cell.accessoryView.hidden = NO;
}


- (void)basetableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [tableView visibleCells];
    for (UITableViewCell *cell in arr) {
        cell.accessoryView.hidden = YES;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView.hidden = NO;
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
