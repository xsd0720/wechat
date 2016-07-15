//
//  AddFriendsSearchViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "AddFriendsSearchViewController.h"
#import "AddFriendsSearchPersonCell.h"
#import "AddFriendsSearchPublicNCell.h"

static NSString *SEARCHPERSIONCELLIDENTIFIER = @"SEARCHPERSIONCELLIDENTIFIER";
static NSString *SEARCHPUBLICNCELLIDENTIFIER = @"SEARCHPUBLICNCELLIDENTIFIER";

@interface AddFriendsSearchViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *searchShowTableView;

@property (nonatomic, strong) NSMutableArray *personDataSource;

@property (nonatomic, strong) NSMutableArray *publicDataSource;

@end

@implementation AddFriendsSearchViewController

-(UITableView *)searchShowTableView{
    if (!_searchShowTableView) {
        _searchShowTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:_searchShowTableView];
        
        _searchShowTableView.delegate = self;
        _searchShowTableView.dataSource = self;
        
        _searchShowTableView.tableFooterView = [UIView new];
        [_searchShowTableView setSeparatorInset:UIEdgeInsetsZero];
        [_searchShowTableView setShowsVerticalScrollIndicator:YES];
        
        [_searchShowTableView registerClass:[AddFriendsSearchPersonCell class] forCellReuseIdentifier:SEARCHPERSIONCELLIDENTIFIER];
        [_searchShowTableView registerClass:[AddFriendsSearchPublicNCell class] forCellReuseIdentifier:SEARCHPUBLICNCELLIDENTIFIER];
        
        _searchShowTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return _searchShowTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self requestData];
    
   
}

- (void)requestData
{
    self.personDataSource = [[NSMutableArray alloc] init];
    self.publicDataSource = [[NSMutableArray alloc] init];
    if (DS.addfriendsSearchTestData[requestResult][@"person"]) {
        [self.personDataSource addObjectsFromArray:DS.addfriendsSearchTestData[requestResult][@"person"]];
    }
    
    if (DS.addfriendsSearchTestData[requestResult][@"public"]) {
        self.publicDataSource = DS.addfriendsSearchTestData[requestResult][@"public"];
    }

    [self.searchShowTableView reloadData];
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.personDataSource.count > 0?35:0;
    }
    return self.publicDataSource.count > 0?35:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 && self.personDataSource.count>0 && self.publicDataSource.count >0) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35-28, SCREEN_WIDTH-40, 28)];
    headerLabel.font = [UIFont systemFontOfSize:13];
    headerLabel.numberOfLines = 0;
    headerLabel.textColor = RGB(128, 127, 132);
    if (section == 0) {
        headerLabel.text = @"个人";
    }else
    {
        headerLabel.text = @"公众号";
    }

    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    v.backgroundColor = [UIColor whiteColor];
    [v addSubview:headerLabel];
    
    return v;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.personDataSource.count;
    }
    return self.publicDataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AddFriendsSearchPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:SEARCHPERSIONCELLIDENTIFIER forIndexPath:indexPath];
        
        NSDictionary *dic = self.personDataSource[indexPath.row];
        cell.datasource = dic;
        return cell;
    }
    
    AddFriendsSearchPublicNCell *cell = [tableView dequeueReusableCellWithIdentifier:SEARCHPUBLICNCELLIDENTIFIER forIndexPath:indexPath];
    NSDictionary *dic = self.publicDataSource[indexPath.row];
    cell.datasource = dic;
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
