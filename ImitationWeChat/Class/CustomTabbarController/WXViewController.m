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
#import "SearchViewShowController.h"
#define SEARCHBARHEIGHT        44
static NSString *WXTABLECELLIDENTIFIER = @"wxtablecellidentifier";

@interface WXViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchControllerDelegate>

@property (nonatomic,strong) UITableView *wxTableView;

@property (nonatomic, strong) UIScrollView *searchScrollView;

@property (nonatomic, strong) CustomSearchViewController *searchController;

@property (nonatomic, strong) SearchViewShowController *searchShowVC;

@end

@implementation WXViewController
-(UITableView *)wxTableView{
    if (!_wxTableView) {
        _wxTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT-CustomTabarHeight)];
        
  
        [self.view addSubview:_wxTableView];
        
        _wxTableView.delegate = self;
        _wxTableView.dataSource = self;
        _wxTableView.tableFooterView = [UIView new];
        
        [_wxTableView registerClass:[WxTableCell class] forCellReuseIdentifier:WXTABLECELLIDENTIFIER];
        _wxTableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    }
    return _wxTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNav];
    
    self.searchShowVC = [[SearchViewShowController alloc] init];
    
    self.searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:_searchShowVC];
    self.searchController.searchResultsUpdater = _searchShowVC;
    [self.searchController.searchBar sizeToFit];
    self.searchController.delegate = self;
    self.wxTableView.tableHeaderView = _searchController.searchBar;
}

-(void)loadNav{
    

    self.navigationItem.title = @"微信";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_addClick)];
    
}

- (void)barbuttonicon_addClick
{
    
}


#pragma mark - tableview delegate

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


- (void)willPresentSearchController:(UISearchController *)searchController
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    
    UIScrollView *s = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT)];
    s.backgroundColor = RGBCOLOR(246, 245, 241);
    s.tag= 100;
    s.contentSize = CGSizeMake(s.bounds.size.width, s.bounds.size.height+1);
    [self.navigationController.view addSubview:s];
    
    
    UIButton *l = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    l.backgroundColor = [UIColor orangeColor];
    [l addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [s addSubview:l];
}
- (void)aaa
{
   
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.wxTableView.transform = CGAffineTransformTranslate(self.wxTableView.transform, 0, -44);
    self.wxTableView.height = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT;
}
- (void)willDismissSearchController:(UISearchController *)searchController
{
    [UIView animateWithDuration:0.3f animations:^{
        self.wxTableView.transform = CGAffineTransformIdentity;
        self.wxTableView.height = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT-CustomTabarHeight;
    }];
    
    [[self.navigationController.view viewWithTag:100] removeFromSuperview];
}
- (void)didDismissSearchController:(UISearchController *)searchController
{
 
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
