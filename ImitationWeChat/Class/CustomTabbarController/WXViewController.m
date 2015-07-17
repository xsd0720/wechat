//
//  WXViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "WXViewController.h"
#import "WxTableCell.h"

#import "CustomSearchViewController.h"
#define SEARCHBARHEIGHT        44
static NSString *WXTABLECELLIDENTIFIER = @"wxtablecellidentifier";

@interface WXViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *wxTableView;

@property (nonatomic, strong) CustomSearchViewController *searchController;

@end

@implementation WXViewController
-(UITableView *)wxTableView{
    if (!_wxTableView) {
        _wxTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT-44)];
        [self.view addSubview:_wxTableView];
        
        _wxTableView.delegate = self;
        _wxTableView.dataSource = self;
        _wxTableView.tableFooterView = [UIView new];
        
        [_wxTableView registerClass:[WxTableCell class] forCellReuseIdentifier:WXTABLECELLIDENTIFIER];
    }
    return _wxTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNav];
    
    
    _searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:nil];
    self.wxTableView.tableHeaderView = _searchController.searchBar;
}

-(void)loadNav{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"微信";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELLHEIGHT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WxTableCell *cell = [tableView dequeueReusableCellWithIdentifier:WXTABLECELLIDENTIFIER forIndexPath:indexPath];
    cell.dic = @{@"head":@"",@"name":@"大头娃娃",@"msg":@"今天天气不错"};
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
