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
static NSString *CONTACTCELLIDENTIFIER  = @"contactcellidentifier";


@interface ContactViewControllerTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userHeadImageView;
@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) NSDictionary *datasource;

@end


@interface ContactViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *contactTableView;

@property (nonatomic,strong) NSArray *contactDataSource;

@property (nonatomic,strong) NSMutableArray *capIndexes;

@property (nonatomic, strong) CustomSearchViewController *searchController;
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
    
    [self.contactTableView reloadData];
}
-(void)setupNav{
    self.navigationItem.title = @"通讯录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_addfriends"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_addfriendsClick)];
    
}

- (void)barbuttonicon_addfriendsClick
{
    
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
