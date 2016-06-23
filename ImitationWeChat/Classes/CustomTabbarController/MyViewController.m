//
//  MyViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "MyViewController.h"
#import "TVViewController.h"
#import "MyProfileViewController.h"
#import "WalletViewController.h"
#import "TestViewController.h"
#import "SettingViewController.h"
static NSString *MYCELLIDENTIFIER = @"mycellidentifier";
static NSString *MYHEADERCELLIDENTIFIER = @"mycellheadercellidentifier";
static float  MYHEADERCELLHEIGHT = 87.f;

@interface  MyHeaderCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *numberLabel;

@property (nonatomic,strong) UIView *rightView;


@property (nonatomic,strong) NSDictionary *dic;
@end


@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation MyViewController



-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-64-44)  style:UITableViewStyleGrouped];
        [self.view addSubview:_myTableView];
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        _myTableView.sectionFooterHeight = 1;
        _myTableView.sectionHeaderHeight = 10;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MYCELLIDENTIFIER];
        [_myTableView registerClass:[MyHeaderCell class] forCellReuseIdentifier:MYHEADERCELLIDENTIFIER];
    }
    
    return _myTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNav];
    
    [self.myTableView reloadData];
}
-(void)loadNav{
    self.navigationItem.title = @"我";
}

#pragma mark - tabledelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return MYHEADERCELLHEIGHT;
    }
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return DS.myTableData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[DS.myTableData objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        MyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:MYHEADERCELLIDENTIFIER forIndexPath:indexPath];
        cell.dic = @{
                     @"head":@"000",
                     @"name":@"王辉",
                     @"number":@"微信号:aywanghui"
                     
                     };
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MYCELLIDENTIFIER forIndexPath:indexPath];
    NSDictionary *dic = [[DS.myTableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"text"];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.imageView.layer.cornerRadius = 10;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //个人资料
    if (indexPath.section == 0&&indexPath.row == 0) {
        MyProfileViewController *myProfileVc = [[MyProfileViewController alloc] init];
        myProfileVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myProfileVc animated:YES];
    }
    //相册
    else if (indexPath.section == 1&&indexPath.row == 0){
        
    }
    //收藏
    else if (indexPath.section == 1&&indexPath.row == 1){
        
    }
    //钱包
    else if (indexPath.section == 1&&indexPath.row == 2){
        WalletViewController *walletViewController = [[WalletViewController alloc] init];
        walletViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:walletViewController animated:YES];
    }
    //卡包
    else if (indexPath.section == 1&&indexPath.row == 3){
        TestViewController *tes = [[TestViewController alloc] init];
        tes.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tes animated:YES];
    }
    //表情
    else if (indexPath.section == 2&&indexPath.row == 0){
        
    }
    //设置
    else if (indexPath.section == 3&&indexPath.row == 0){
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
    //电视直播
    else if (indexPath.section == 3&&indexPath.row == 1){
        TVViewController *tvVc = [[TVViewController alloc] init];
        tvVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tvVc animated:YES];
    }
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

@implementation MyHeaderCell
#define Padding  14
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 5;
        _headImageView.clipsToBounds = YES;
        [self addSubview:_headImageView];
        
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_userNameLabel];
        
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor grayColor];
        _numberLabel.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_numberLabel];
        
        
        //accessview
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 18)];
        
        //二维码
        UIImage *qrIm = [UIImage imageNamed:@"setting_myQR"];
        UIImageView *setting_myQR = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        setting_myQR.image = qrIm;
        [_rightView addSubview:setting_myQR];
        
        //箭头
        UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32-7, (18-12)/2, 7, 12)];
        rightArrowImageView.image = [UIImage imageNamed:@"tableview_arrow"];
        [_rightView addSubview:rightArrowImageView];
        
        
        self.accessoryView = _rightView;
     
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
//    NSString *imageUrl = [dic valueForKey:@"head"];
    NSString *userName = [dic valueForKey:@"name"];
    NSString *number = [dic valueForKey:@"number"];
    
    _headImageView.image = [UIImage imageNamed:@"000"];
    _userNameLabel.text = userName;
    _numberLabel.text = number;
    
    
    [_headImageView setFrame:CGRectMake(14, 11, MYHEADERCELLHEIGHT-11*2, MYHEADERCELLHEIGHT-11*2)];
    _headImageView.layer.borderWidth = 1;
    _headImageView.layer.borderColor = [[UIColor grayColor] CGColor];
    _headImageView.layer.cornerRadius = 10;
    [_userNameLabel setFrame:CGRectMake(getViewWidth(_headImageView)+10, _headImageView.frame.origin.y,SCREEN_WIDTH-getViewWidth(_headImageView),getViewHeight(_headImageView)/2)];
    [_numberLabel setFrame:CGRectMake(_userNameLabel.frame.origin.x, getViewHeight(_userNameLabel)-10, CGRectGetWidth(_userNameLabel.frame), CGRectGetHeight(_userNameLabel.frame))];

}
@end
