//
//  SimpleProfileViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SimpleProfileViewController.h"
#import "SimpleProfileHeaderCell.h"
#import "SimpleProfileAlbumCell.h"

static NSString *SIMPLEPROFILEDEFINCELLIDENTIFIER = @"SIMPLEPROFILEDEFINCELLIDENTIFIER";
static NSString *SIMPLEPROFILEHEADERCELLIDENTIFIER = @"SIMPLEPROFILEHEADERCELLIDENTIFIER";
static NSString *SIMPLEPROFILEALBUMCELLIDENTIFIER = @"SIMPLEPROFILEALBUMCELLIDENTIFIER";

@interface SimpleProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *tableFooterView;

@property (nonatomic, strong) NSDictionary *baseProfileDataSource;

@property (nonatomic, strong) NSArray *albDataSource;

@end

@implementation SimpleProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    
    _baseProfileDataSource = DS.testProfileData[@"profile"];
    _albDataSource = DS.testProfileData[@"alb"];
    
    [self.mainTableView reloadData];
}

/**
 *  懒加载tableiview
 */
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
        [self.view addSubview:_mainTableView];

        
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SIMPLEPROFILEDEFINCELLIDENTIFIER];
        [_mainTableView registerClass:[SimpleProfileHeaderCell class] forCellReuseIdentifier:SIMPLEPROFILEHEADERCELLIDENTIFIER];
        [_mainTableView registerClass:[SimpleProfileAlbumCell class] forCellReuseIdentifier:SIMPLEPROFILEALBUMCELLIDENTIFIER];
        _mainTableView.backgroundColor = self.view.backgroundColor;
        _mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _mainTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = self.tableFooterView;
        
    }
    return _mainTableView;
}

- (UIView *)tableFooterView
{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
        UIButton *sendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendMessageButton.frame = CGRectMake(15, 15, _tableFooterView.width-30, 50);
        [sendMessageButton setTitle:@"发送消息" forState:UIControlStateNormal];
        sendMessageButton.titleLabel.font = [UIFont systemFontOfSize:16];
        sendMessageButton.backgroundColor = wechatButtonColor;
        [sendMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendMessageButton.layer.borderColor = [RGB(63, 143, 39) CGColor];
        sendMessageButton.layer.borderWidth = 1;
        sendMessageButton.layer.cornerRadius = 5;
        [_tableFooterView addSubview:sendMessageButton];
        
        
        
        UIButton *videoChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        videoChatButton.frame = CGRectMake(15, CGRectGetMaxY(sendMessageButton.frame)+15, _tableFooterView.width-30, 50);
        [videoChatButton setTitle:@"视频聊天" forState:UIControlStateNormal];
        [videoChatButton setTitleColor:RGB(71, 71, 72) forState:UIControlStateNormal];
        videoChatButton.titleLabel.font = [UIFont systemFontOfSize:16];
        videoChatButton.backgroundColor = RGB(247, 248, 249);
        videoChatButton.layer.borderColor = [RGB(221, 221, 224) CGColor];
        videoChatButton.layer.borderWidth = 1;
        videoChatButton.layer.cornerRadius = 5;
        [_tableFooterView addSubview:videoChatButton];
        
        
    }
    return _tableFooterView;
}

- (void)setUpNav
{
    self.title = @"详细资料";
}


#pragma mark --
#pragma mark -- tableview delegate and datasource



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        return 95;
    }
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 2) {
        return 3;
    }
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        SimpleProfileHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:SIMPLEPROFILEHEADERCELLIDENTIFIER forIndexPath:indexPath];
        cell.datasource = _baseProfileDataSource;
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SIMPLEPROFILEDEFINCELLIDENTIFIER forIndexPath:indexPath];
        cell.textLabel.text = @"设置备注和标签";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else
    {
        SimpleProfileAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:SIMPLEPROFILEALBUMCELLIDENTIFIER forIndexPath:indexPath];
        
        cell.datasource = _albDataSource[indexPath.row];
        
        return cell;
    }

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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

@end
