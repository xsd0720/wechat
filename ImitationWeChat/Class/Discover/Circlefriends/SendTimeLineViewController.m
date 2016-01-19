//
//  SendTimeLineViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SendTimeLineViewController.h"
#import "UIPlaceHolderTextView.h"

#define SENDTIMELINETABLECELLIDENTIFIER @"SENDTIMELINETABLECELLIDENTIFIER"

@interface SendTimeLinTableViewCell : UITableViewCell

//栏目名称
@property (nonatomic, strong) UILabel *columnNameLabel;

//栏目图片(option)
@property (nonatomic, strong) UIImageView *columnImageView;

//栏目详细(option)
@property (nonatomic, strong) UILabel *columnDetailLabel;

@property (nonatomic, strong) NSDictionary *datasource;

@end

@interface SendTimeLineViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) UIPlaceHolderTextView *sendTextView;

@property (nonatomic, strong) UITableView *sendTimeLineTableView;
@end

@implementation SendTimeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self.view addSubview:self.sendTimeLineTableView];
}

- (UITextView *)sendTextView
{
    if (!_sendTextView) {
        _sendTextView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(15, 10+64, SCREEN_WIDTH-30, 75)];
        _sendTextView.text = @"iOS中UITextField带有PlaceHolder属性,可以方便用于提示输入。但是同样可以进行文本输入的UITextView控件则没有PlaceHolder属性,还是有些不方便的,尤其是对于略带...";
        _sendTextView.font = [UIFont systemFontOfSize:15];
        _sendTextView.placeholder = @"这一刻的想法。。。";
        _sendTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _sendTextView;
}


- (UITableView *)sendTimeLineTableView
{
    if (!_sendTimeLineTableView) {
        _sendTimeLineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _sendTimeLineTableView.delegate = self;
        _sendTimeLineTableView.dataSource = self;
//        _sendTimeLineTableView.tableHeaderView = self.tableHeaderView;
        _sendTimeLineTableView.tableFooterView = [UIView new];
        [_sendTimeLineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SENDTIMELINETABLECELLIDENTIFIER];
    }
    return _sendTimeLineTableView;
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_back setTitle:@"取消" forState:UIControlStateNormal];
    [button_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button_back.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button_back.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_back addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * button_send= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_send setTitle:@"发送" forState:UIControlStateNormal];
    [button_send setTitleColor:RGBCOLOR(28, 218, 65) forState:UIControlStateNormal];
    [button_send.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button_send.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_send addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftnegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                      target :nil action:nil];
    leftnegativeSpacer.width = -10;
    
    UIBarButtonItem *rightnegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                          target : nil action : nil ];
    rightnegativeSpacer.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[leftnegativeSpacer, [[UIBarButtonItem alloc]initWithCustomView:button_back]];
    
    self.navigationItem.rightBarButtonItems =  @[rightnegativeSpacer, [[UIBarButtonItem alloc]initWithCustomView:button_send]];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SENDTIMELINETABLECELLIDENTIFIER forIndexPath:indexPath];
//    cell.columnNameLabel.text = @"123";
//    cell.columnImageView.image = [UIImage imageNamed:@"111"];
    cell.textLabel.text =@"123";
    cell.imageView.image = [UIImage imageNamed:@"AlbumLocationIcon"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendButtonClick
{
    NSLog(@"发送");
}
@end

@implementation SendTimeLinTableViewCell
#define Padding   10
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //栏目名称
        _columnNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding, 0, SCREEN_WIDTH, 20)];
        _columnNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_columnNameLabel];
        
        
        
        //栏目图片
        _columnImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _columnImageView.contentMode = UIViewContentModeScaleAspectFit;
        _columnImageView.clipsToBounds = YES;
        _columnImageView.layer.borderColor = [RGBCOLOR(202, 202, 202) CGColor];
        [self addSubview:_columnImageView];
        
        
        
        //栏目详情
        _columnDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 100, 0, 100, 20)];
        _columnDetailLabel.font = [UIFont systemFontOfSize:16];
        _columnDetailLabel.textAlignment = 2;
        _columnDetailLabel.textColor = RGBCOLOR(155, 155, 155);
        [self addSubview:_columnDetailLabel];
        
        _columnImageView.hidden = YES;
        _columnDetailLabel.hidden = YES;
    }
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    _columnImageView.hidden = YES;
    _columnDetailLabel.hidden = YES;
    
    NSString *text = datasource[@"text"];
    _columnNameLabel.text = text;
    
    NSString *obj = datasource[@"obj"];
    
    if ([datasource[@"type"] isEqualToString:@"1"]) {
        //图片
        _columnImageView.hidden = NO;
        _columnImageView.image = [UIImage imageNamed:obj];
    }
    else
    {
        //文字
        _columnDetailLabel.hidden = NO;
        _columnDetailLabel.text = obj;
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _columnNameLabel.centerY = CGRectGetMaxY(self.bounds)/2;
    
    
    CGFloat headImageSize = CGRectGetMaxY(self.bounds)-20;
    
    _columnImageView.frame = CGRectMake(SCREEN_WIDTH - 30 - headImageSize, 10, headImageSize, headImageSize);
    _columnImageView.centerY = CGRectGetMaxY(self.bounds)/2;
    _columnDetailLabel.centerY = CGRectGetMaxY(self.bounds)/2;
}
@end
