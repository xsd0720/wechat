//
//  AddFriendsViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/14.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "CustomSearchViewController.h"
#import "AddFriendsSearchViewController.h"

#define  MAINTCELLIDENTIFIER  @"MAINTCELLIDENTIFIER"

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *datasource;

@end

@interface AddFriendsViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchControllerDelegate>

@property (nonatomic, strong) CustomSearchViewController *searchController;

@property (nonatomic, strong) AddFriendsSearchViewController *searchShowVC;

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIScrollView *fts_eduScrollview;

@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    
    
    self.searchShowVC = [[AddFriendsSearchViewController alloc] init];
    
    self.searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:_searchShowVC];
    self.searchController.searchResultsUpdater = self;
    [self.searchController setUpSearBarFuGaiView];
    [self.searchController.searchBar sizeToFit];
    self.searchController.delegate = self;
    

    self.mainTableView.tableHeaderView = self.tableHeaderView;
    
}

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
        _tableHeaderView.backgroundColor = self.view.backgroundColor;
        [self.tableHeaderView addSubview:_searchController.searchBar];
        
        UILabel *mywechatNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchController.searchBar.frame)+5, 200, 20)];
        mywechatNumber.text = @"我的微信号：aywanghui";
        mywechatNumber.font = [UIFont systemFontOfSize:12];
        mywechatNumber.textAlignment = 2;
        [_tableHeaderView addSubview:mywechatNumber];
        
        UIButton *qrcode = [UIButton buttonWithType:UIButtonTypeCustom];
        [qrcode setImage:[UIImage imageNamed:@"add_friend_myQR"] forState:UIControlStateNormal];
        qrcode.frame = CGRectMake(CGRectGetMaxX(mywechatNumber.frame)+5, mywechatNumber.originY, 20, 20);
        [_tableHeaderView addSubview:qrcode];
    }
    return _tableHeaderView;
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
        [self.view addSubview:_mainTableView];

        [_mainTableView setSeparatorInset:UIEdgeInsetsZero];
        _mainTableView.backgroundColor = self.view.backgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
        
        [_mainTableView registerClass:[TableViewCell class] forCellReuseIdentifier:MAINTCELLIDENTIFIER];
    }
    return _mainTableView;
}


- (void)configNav
{
    self.title = @"添加朋友";
}


#pragma mark --
#pragma mark -- tableview delegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DS.addfriendsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MAINTCELLIDENTIFIER forIndexPath:indexPath];
    
    NSDictionary *dic = DS.addfriendsData[indexPath.row];
    cell.datasource = dic;
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void)willPresentSearchController:(UISearchController *)searchController
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
    _fts_eduScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT)];
    _fts_eduScrollview.backgroundColor = RGBCOLOR(246, 245, 241);
    _fts_eduScrollview.tag= 100;
    _fts_eduScrollview.contentSize = CGSizeMake(_fts_eduScrollview.bounds.size.width, _fts_eduScrollview.bounds.size.height+1);
    [self.navigationController.view addSubview:_fts_eduScrollview];
    
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.mainTableView.transform = CGAffineTransformTranslate(self.mainTableView.transform, 0, -44);
    self.mainTableView.height = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT;
}
- (void)willDismissSearchController:(UISearchController *)searchController
{
    [UIView animateWithDuration:0.3f animations:^{
        self.mainTableView.transform = CGAffineTransformIdentity;
        self.mainTableView.height = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT;
    }];

    [[self.navigationController.view viewWithTag:100] removeFromSuperview];
    
}


- (void)didDismissSearchController:(UISearchController *)searchController
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    BOOL isLengthZero = searchController.searchBar.text.length<=0;
    
    _fts_eduScrollview.hidden = !isLengthZero;
    
}



@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.textColor = [UIColor grayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    
    self.imageView.image = [UIImage imageNamed:datasource[@"image"]];
    self.textLabel.text = datasource[@"text"];
    self.detailTextLabel.text = datasource[@"dText"];

}

@end
