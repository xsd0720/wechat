//
//  SearchViewShowController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/5.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SearchViewShowController.h"

@interface SearchViewShowController ()

@end

@implementation SearchViewShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor redColor];
    
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

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSLog(@"Entering:%@",searchController.searchBar.text);
}

@end
