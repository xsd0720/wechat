//
//  AddFriendsViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/14.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "CustomSearchViewController.h"
#import "SearchViewShowController.h"

#define  MAINTCELLIDENTIFIER  @"MAINTCELLIDENTIFIER"

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *datasource;

@end

@interface AddFriendsViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchControllerDelegate>

@property (nonatomic, strong) CustomSearchViewController *searchController;

@property (nonatomic, strong) SearchViewShowController *searchShowVC;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIScrollView *fts_eduScrollview;

@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    
    
    self.searchShowVC = [[SearchViewShowController alloc] init];
    
    self.searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:_searchShowVC];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.delegate = self;
    self.mainTableView.tableHeaderView = _searchController.searchBar;
    
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
        [self.view addSubview:_mainTableView];
//        [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_mainTableView setSeparatorInset:UIEdgeInsetsZero];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
//
//    
//    _buttonLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 100)];
//    [_fts_eduScrollview addSubview:_buttonLineView];
//    
//    
//    CGFloat buttonBgWidth = SCREEN_WIDTH/3;
//    CGFloat imagebuttonSize = 67;
//    NSArray *titleArray = @[@"朋友圈", @"文章", @"公众号"];
//    NSArray *imageNameArray = @[@"fts_edu_sns_icon", @"fts_edu_article_icon", @"fts_edu_brandcontact_icon"];
//    for (int i = 0; i<3; i++) {
//        
//        //图片和文字的父视图
//        UIButton *buttonBgView = [UIButton buttonWithType:UIButtonTypeCustom];
//        buttonBgView.backgroundColor = [UIColor clearColor];
//        buttonBgView.frame = CGRectMake(i*buttonBgWidth, 0, buttonBgWidth, CGRectGetMaxY(_buttonLineView.bounds));
//        [_buttonLineView addSubview:buttonBgView];
//        
//        
//        //图片视图
//        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [imageButton setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
//        imageButton.frame = CGRectMake(0, 0, imagebuttonSize, imagebuttonSize);
//        imageButton.backgroundColor = RGBCOLOR(229, 229, 231);
//        imageButton.center = CGPointMake(CGRectGetMaxX(buttonBgView.bounds)/2, imageButton.centerY);
//        imageButton.layer.cornerRadius = imagebuttonSize/2;
//        imageButton.clipsToBounds = YES;
//        imageButton.userInteractionEnabled = NO;
//        [buttonBgView addSubview:imageButton];
//        
//        
//        //文字视图
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonBgView.bounds)-20, CGRectGetMaxX(buttonBgView.bounds), 15)];
//        titleLabel.text = titleArray[i];
//        titleLabel.font = [UIFont systemFontOfSize:14];
//        titleLabel.textColor = RGBCOLOR(160, 159, 159);
//        titleLabel.textAlignment = 1;
//        [buttonBgView addSubview:titleLabel];
//    }
//    
//    _buttonLineView.transform = CGAffineTransformMakeTranslation(0, 20);
//    [UIView animateWithDuration:0.2f animations:^{
//        _buttonLineView.transform = CGAffineTransformIdentity;
//    }];
    
}
- (void)aaa
{
    
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
//
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
        
    }
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.imageView.image = [UIImage imageNamed:datasource[@"image"]];
    self.textLabel.text = datasource[@"text"];
    self.detailTextLabel.text = datasource[@"dText"];
    self.detailTextLabel.textColor = [UIColor grayColor];
    
}

@end
