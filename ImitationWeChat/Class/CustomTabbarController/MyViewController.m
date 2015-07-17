//
//  MyViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "MyViewController.h"

static NSString *MYCELLIDENTIFIER = @"mycellidentifier";
static NSString *MYHEADERCELLIDENTIFIER = @"mycellheadercellidentifier";
static float  MYHEADERCELLHEIGHT = 90.f;

@interface  MyHeaderCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *numberLabel;

@property (nonatomic,strong) UIImageView *setting_myQR;


@property (nonatomic,strong) NSDictionary *dic;
@end


@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSArray *myTableData;
@end

@implementation MyViewController

-(NSArray *)myTableData{
    return @[
             @[
                 @{@"image":@"000",
                   @"text":@"大头娃娃"}
                 ],
             @[
                 @{@"image":@"MoreMyAlbum",
                   @"text":@"相册"},
                 @{@"image":@"MoreMyFavorites",
                   @"text":@"收藏"},
                 @{@"image":@"MoreMyBankCard",
                   @"text":@"钱包"},
                 @{@"image":@"MyCardPackageIcon",
                   @"text":@"卡包"},
                 
                 ],
             @[
                 @{@"image":@"MoreExpressionShops",
                   @"text":@"表情"}
                 ],
             @[
                 
                 @{@"image":@"MoreSetting",
                   @"text":@"设置"}

                 ]
             
             ];
}

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-64-44)  style:UITableViewStyleGrouped];
        [self.view addSubview:_myTableView];
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MYCELLIDENTIFIER];
        [_myTableView registerClass:[MyHeaderCell class] forCellReuseIdentifier:MYHEADERCELLIDENTIFIER];
    }
    
    return _myTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 4;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        MyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:MYHEADERCELLIDENTIFIER forIndexPath:indexPath];
        cell.dic = @{
                     @"head":@"000",
                     @"name":@"大头娃娃",
                     @"number":@"微信号:datouwawa"
                     
                     };
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MYCELLIDENTIFIER forIndexPath:indexPath];
    NSDictionary *dic = [[self.myTableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"text"];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.imageView.layer.cornerRadius = 10;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
#define Padding  5
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 5;
        [self addSubview:_headImageView];
        
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_userNameLabel];
        
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor grayColor];
        _numberLabel.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_numberLabel];
        
        
        UIImage *qrIm = [UIImage imageNamed:@"setting_myQR"];
        
        
        
        _setting_myQR = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _setting_myQR.image = qrIm;
        self.accessoryView = _setting_myQR;
     
        
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
    
    
    [_headImageView setFrame:CGRectMake(Padding*2, Padding, MYHEADERCELLHEIGHT-Padding*2, MYHEADERCELLHEIGHT-Padding*2)];
    _headImageView.layer.borderWidth = 1;
    _headImageView.layer.borderColor = [[UIColor grayColor] CGColor];
    _headImageView.layer.cornerRadius = 10;
    [_userNameLabel setFrame:CGRectMake(getViewWidth(_headImageView)+10, _headImageView.frame.origin.y,SCREEN_WIDTH-getViewWidth(_headImageView),getViewHeight(_headImageView)/2)];
    [_numberLabel setFrame:CGRectMake(_userNameLabel.frame.origin.x, getViewHeight(_userNameLabel)-10, CGRectGetWidth(_userNameLabel.frame), CGRectGetHeight(_userNameLabel.frame))];

}
@end
