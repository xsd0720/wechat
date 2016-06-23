//
//  WXViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "WXViewController.h"
#import "WxTableCell.h"
#import "EyeLayer.h"
#import "CustomSearchViewController.h"
#import "SearchViewShowController.h"
#import "KxMenu.h"
#import "UserCenterRequest.h"
#define SEARCHBARHEIGHT        44
static NSString *WXTABLECELLIDENTIFIER = @"wxtablecellidentifier";

@interface WXViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchControllerDelegate>

@property (nonatomic,strong) UITableView *wxTableView;

@property (nonatomic, strong) UIScrollView *searchScrollView;

@property (nonatomic, strong) CustomSearchViewController *searchController;

@property (nonatomic, strong) SearchViewShowController *searchShowVC;

@property (nonatomic, strong) UIView *buttonLineView;

@property (nonatomic, strong) UIScrollView *fts_eduScrollview;


@property (nonatomic, strong) UIView *wxTableHeaderView;

@property (nonatomic, strong) EyeLayer *eyeLayer;

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
        [_wxTableView setExclusiveTouch:YES];
    
        
//        _wxTableView.tableHeaderView = self.eyeLayer;
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50)/2, -80, 50, 50)];
//        imageView.image = [UIImage imageNamed:@"ChatListBackgroundLogo"];
        [_wxTableView addSubview:self.wxTableHeaderView];
        
    
        
    }
    return _wxTableView;
}

- (UIView *)wxTableHeaderView
{
    if (!_wxTableHeaderView) {
        _wxTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -200, SCREEN_WIDTH, 200)];
        _wxTableHeaderView.backgroundColor = [UIColor blackColor];
        [_wxTableHeaderView addSubview:self.eyeLayer];
    }
    return _wxTableHeaderView;
}

- (EyeLayer *)eyeLayer
{
    if (!_eyeLayer) {
        _eyeLayer = [[EyeLayer alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-EyeLayerWidth)/2, 150, EyeLayerWidth, EyeLayerHeight)];
    }
    return _eyeLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNav];
    
    self.searchShowVC = [[SearchViewShowController alloc] init];
    
    self.searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:_searchShowVC];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.delegate = self;
    self.wxTableView.tableHeaderView = _searchController.searchBar;
    
    
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [UserCenterRequest loginWithMobile:@"12414234" password:@"23424" success:^(LoginResponse *responsObject) {
//        NSLog(@"%@", responsObject);
//    } failure:^(NSError *error) {
//        
//    }];

    [UserCenterRequest registerWithUserName:@"datou" mobile:@"18888888888" password:@"123456" success:^(LoginResponse *responsObject) {
        NSLog(@"%@", responsObject);
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [KxMenu dismissMenu];
}

-(void)loadNav{
    

    self.navigationItem.title = @"微信";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_addClick)];
    
}

//＋号码
- (void)barbuttonicon_addClick
{

    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"发起群聊"
                     image:[UIImage imageNamed:@"contacts_add_newmessage"]
                    target:self
                    action:@selector(pushMenuItem1)],
      
      [KxMenuItem menuItem:@"添加朋友"
                     image:[UIImage imageNamed:@"contacts_add_friend"]
                    target:self
                    action:@selector(pushMenuItem2)],
      
      [KxMenuItem menuItem:@"扫一扫"
                     image:[UIImage imageNamed:@"contacts_add_scan"]
                    target:self
                    action:@selector(pushMenuItem3)],
      
      [KxMenuItem menuItem:@"收付款"
                     image:[UIImage imageNamed:@"receipt_payment_icon"]
                    target:self
                    action:@selector(pushMenuItem4)],
      ];
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(SCREEN_WIDTH-100, STATUS_AND_NAV_BAR_HEIGHT+2, 140, 0)
                 menuItems:menuItems];
}


#pragma mark - pushMenuItem

//发起群聊
- (void)pushMenuItem1
{
    
    NSLog(@"发起群聊");
}

//添加朋友
- (void)pushMenuItem2
{
    
    NSLog(@"添加朋友");
}

//扫一扫
- (void)pushMenuItem3
{
    
    NSLog(@"扫一扫");
}

//收付款
- (void)pushMenuItem4
{
    
    NSLog(@"收付款");
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

    
    _fts_eduScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT)];
    _fts_eduScrollview.backgroundColor = RGBCOLOR(246, 245, 241);
    _fts_eduScrollview.tag= 100;
    _fts_eduScrollview.contentSize = CGSizeMake(_fts_eduScrollview.bounds.size.width, _fts_eduScrollview.bounds.size.height+1);
    [self.navigationController.view addSubview:_fts_eduScrollview];
    

    _buttonLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 100)];
    [_fts_eduScrollview addSubview:_buttonLineView];
    
    
    CGFloat buttonBgWidth = SCREEN_WIDTH/3;
    CGFloat imagebuttonSize = 67;
    NSArray *titleArray = @[@"朋友圈", @"文章", @"公众号"];
    NSArray *imageNameArray = @[@"fts_edu_sns_icon", @"fts_edu_article_icon", @"fts_edu_brandcontact_icon"];
    for (int i = 0; i<3; i++) {
        
        //图片和文字的父视图
        UIButton *buttonBgView = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBgView.backgroundColor = [UIColor clearColor];
        buttonBgView.frame = CGRectMake(i*buttonBgWidth, 0, buttonBgWidth, CGRectGetMaxY(_buttonLineView.bounds));
        [_buttonLineView addSubview:buttonBgView];
        
        
        //图片视图
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageButton setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        imageButton.frame = CGRectMake(0, 0, imagebuttonSize, imagebuttonSize);
        imageButton.backgroundColor = RGBCOLOR(229, 229, 231);
        imageButton.center = CGPointMake(CGRectGetMaxX(buttonBgView.bounds)/2, imageButton.centerY);
        imageButton.layer.cornerRadius = imagebuttonSize/2;
        imageButton.clipsToBounds = YES;
        imageButton.userInteractionEnabled = NO;
        [buttonBgView addSubview:imageButton];
        
        
        //文字视图
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonBgView.bounds)-20, CGRectGetMaxX(buttonBgView.bounds), 15)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = RGBCOLOR(160, 159, 159);
        titleLabel.textAlignment = 1;
        [buttonBgView addSubview:titleLabel];
    }
    
    _buttonLineView.transform = CGAffineTransformMakeTranslation(0, 20);
    [UIView animateWithDuration:0.2f animations:^{
        _buttonLineView.transform = CGAffineTransformIdentity;
    }];
    
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<0) {
        [self.eyeLayer animationWith:scrollView.contentOffset.y];
    }
   
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
