//
//  ContactViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "ContactViewController.h"
#import "Contact.h"
#import "CustomSearchViewController.h"
#import "SearchViewShowController.h"
#import "AddFriendsViewController.h"
static NSString *CONTACTCELLIDENTIFIER  = @"contactcellidentifier";


@interface ContactViewControllerTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userHeadImageView;
@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) NSDictionary *datasource;

@end


@interface ContactViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating>
@property (nonatomic,strong) UITableView *contactTableView;

@property (nonatomic,strong) NSArray *contactDataSource;

@property (nonatomic,strong) NSMutableArray *capIndexes;

@property (nonatomic, strong) CustomSearchViewController *searchController;

@property (nonatomic, strong) SearchViewShowController *searchShowVC;

@property (nonatomic, strong) UIView *buttonLineView;

@property (nonatomic, strong) UIScrollView *fts_eduScrollview;
@end

@implementation ContactViewController
-(NSArray *)contactDataSource{
    
    if (!_contactDataSource) {
        _contactDataSource = [self getContactDataSource:DS.contactData];
    }
    
    return _contactDataSource;
}

-(UITableView *)contactTableView{
    if (!_contactTableView) {
        _contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT-CustomTabarHeight) style:UITableViewStyleGrouped];
        
     
        [self.view addSubview:_contactTableView];
        
        _contactTableView.delegate = self;
        _contactTableView.dataSource = self;
        _contactTableView.tableFooterView = [UIView new];
        _contactTableView.sectionIndexColor = [UIColor grayColor];
        _contactTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _contactTableView.sectionHeaderHeight = 10;
        _contactTableView.sectionFooterHeight = 0;
        [_contactTableView registerClass:[ContactViewControllerTableViewCell class] forCellReuseIdentifier:CONTACTCELLIDENTIFIER];
        
//        _searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:nil];
//        _contactTableView.tableHeaderView =_searchController.searchBar;
    }
    return _contactTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    
    
    self.searchShowVC = [[SearchViewShowController alloc] init];
    self.searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:_searchShowVC];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.delegate = self;
    self.contactTableView.tableHeaderView = _searchController.searchBar;
    
}
-(void)setupNav{
    self.navigationItem.title = @"通讯录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_addfriends"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_addfriendsClick)];
    
}

- (void)barbuttonicon_addfriendsClick
{
    AddFriendsViewController *addFriendsVC = [[AddFriendsViewController alloc] init];
    addFriendsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addFriendsVC animated:YES];
}

#pragma mark - TableView section
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  self.capIndexes;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}


//#pragma mark - TableView Delegate
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 25;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return @"";
    }
    return self.contactDataSource[section][@"capIndex"];

}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        _searchController = [[CustomSearchViewController alloc] initWithSearchResultsController:nil];
//        return _searchController.searchBar;
//    }
//    return nil;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contactDataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.contactDataSource objectAtIndex:section] objectForKey:@"contacts"] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CONTACTCELLIDENTIFIER forIndexPath:indexPath];
    
    NSDictionary *dic = self.contactDataSource[indexPath.section][@"contacts"][indexPath.row];
//    cell.textLabel.text = dic[@"name"];
    cell.datasource = dic;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
 返回的格式类型
 @{
 "capindex":"A"
 "contacts":[
    @{
        "name":"xxx",
        "image":"png"
    },
    @{
        "name":"xxx",
        "image":"png"
    }
 ]
 }
 */
-(NSArray *)getContactDataSource:(NSArray *)originalArray{
    
    self.capIndexes = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
//    [self.capIndexes addObject:UITableViewIndexSearch];
    
    
    
    //构建一个
    
    
    
    NSMutableArray* tempCapsArray[27];
    for(NSInteger x = 0; x<27;x++)
    {
        tempCapsArray[x] = [[NSMutableArray alloc] initWithCapacity:8];
    }
    
    NSMutableArray* ma = [NSMutableArray arrayWithObject:DS.contactHeaderSectionData];
    for(NSDictionary* dict in originalArray){
      
        
        char c = [dict[@"name"] firstLetter];
        if(c>='a'&& c<='z')
        {
         
            [tempCapsArray[c-'a'] addObject:dict];
        }
        else if(c>='A' && c<='Z')
        {
            [tempCapsArray[c-'A'] addObject:dict];
            
        }
        else
        {
            [tempCapsArray[26] addObject:dict];
        }
        
        
    }
    
    
    for(NSInteger y = 0; y < 26; y++)
    {
        if(tempCapsArray[y].count)
        {
            char temp ='A'+y;
            NSString* str = [NSString stringWithUTF8String:&temp];
            if (![self.capIndexes containsObject:str]) {
                [self.capIndexes addObject:str];
            }
            
            NSDictionary *dic = @{
                                  @"capIndex":str,
                                  @"contacts":tempCapsArray[y]
                                  };
            
            [ma addObject:dic];
        }
    }
    
    if(tempCapsArray[26].count)
    {
        
        char temp[2] = {0};
        temp[0] = '#';
        NSString* str = [NSString stringWithUTF8String:temp];
        if (![self.capIndexes containsObject:str]) {
            [self.capIndexes addObject:str];
        }
        
        NSDictionary *dic = @{
                              @"capIndex":str,
                              @"contacts":tempCapsArray[26]
                              };
        
        [ma addObject:dic];
    }

    
    return ma;
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
    self.contactTableView.transform = CGAffineTransformTranslate(self.contactTableView.transform, 0, -44);
    self.contactTableView.height = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT;
}
- (void)willDismissSearchController:(UISearchController *)searchController
{
    [UIView animateWithDuration:0.3f animations:^{
        self.contactTableView.transform = CGAffineTransformIdentity;
        self.contactTableView.height = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT-CustomTabarHeight;
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


@implementation ContactViewControllerTableViewCell

#define Padding 15
#define UserHeadImageSize   35

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_userHeadImageView];
        
        //用户名
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNameLabel.font = [UIFont systemFontOfSize:16.0f];
        _userNameLabel.textColor = RGBACOLOR(13, 13, 13, 1);
        [self addSubview:_userNameLabel];
        
    }
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    _userHeadImageView.image = [UIImage imageNamed:datasource[@"image"]];
    _userNameLabel.text = datasource[@"name"];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _userHeadImageView.frame = CGRectMake(Padding, (CGRectGetMaxY(self.bounds)-UserHeadImageSize)/2, UserHeadImageSize, UserHeadImageSize);
    
    _userNameLabel.frame = CGRectMake(CGRectGetMaxX(_userHeadImageView.frame)+10, 0, SCREEN_WIDTH-CGRectGetMaxX(_userHeadImageView.frame)-20, CGRectGetMaxY(self.bounds));
    
}

@end
