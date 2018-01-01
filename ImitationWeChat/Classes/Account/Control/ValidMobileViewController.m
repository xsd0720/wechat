//
//  ValidMobileViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/27.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "ValidMobileViewController.h"
#import "UserCenterRequest.h"
#import "FillSimpleInfoViewController.h"
#define VALIDCELLIDENTIFIER @"VALIDCELLIDENTIFIER"

#define VALIDINPUTTAG    300

@interface ValidCell : UITableViewCell

@property (nonatomic, strong) UILabel *titLabel;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) BOOL enable;

@end

@interface ValidMobileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextField *validTextField;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int currentNumber;
@end

@implementation ValidMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self sendMobileValidCode];
//    [self.cancelButton setImage:[UIImage imageNamed:@"fts_search_backicon_ios7"] forState:UIControlStateNormal];
//    self.cancelButton.width = 60;
    
    [self configSuperTableData];
    
    UIButton *bb = [UIButton buttonWithType:UIButtonTypeCustom];
    [bb setTitle:@"say" forState:UIControlStateNormal];
    bb.frame = CGRectMake(0, SCREEN_HEIGHT-50, 50, 50);
    [self.view addSubview:bb];
  
    
}

- (void)sendMobileValidCode
{
    [UserCenterRequest requestsnsWithMobile:self.mobile opcode:0 success:^(RequestsnsResponse *responsObject) {
        NSLog(@"%@", responsObject);
        [self configTime];
    } failure:^(NSError *error) {
        self.titleLabel.text = @"短信验证码发送失败，返\n回重新发送";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self dismissViewControllerAnimated:YES completion:nil];
        });
       
    }];
}

- (void)configSuperTableData
{
    [self.cancelButton setTitle:@"返回" forState:UIControlStateNormal];
    
    self.titleLabel.text = @"短信验证码已发送，请\n填写验证码";
    self.titleLabel.height = 60;
    self.tableHeaderView.height = 100;
    
    
    self.mainTableView.tableHeaderView = self.tableHeaderView;
    [self.operationButton setTitle:@"提交" forState:UIControlStateNormal];
    
    //regis table cell
    [self.mainTableView registerClass:[ValidCell class] forCellReuseIdentifier:VALIDCELLIDENTIFIER];
    
    
    [self.mainTableView reloadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UserCenterRequest toukan:self.mobile success:^(NSDictionary *responsObject) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码" message:responsObject[@"data"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    } failure:^(NSError *error) {
        
    }];
}
- (void)configTime
{

    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 30)];
    self.timeLabel.textColor = RGB(117, 118, 119);
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.text = @"接收短信大约需要60秒";
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableFooterView addSubview:self.timeLabel];
    
    _currentNumber = 60;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:YES];
}

- (void)updateTimeLabel
{
    _currentNumber --;
    if (_currentNumber <= 0) {
        _currentNumber = 0;
        [_timer invalidate];
    }
    self.timeLabel.text = [NSString stringWithFormat:@"接收短信大约需要%i秒", _currentNumber];
}

#pragma mark --
#pragma mark -- heavy load superclass table method
- (NSInteger)atableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)atableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ValidCell *cell = [tableView dequeueReusableCellWithIdentifier:VALIDCELLIDENTIFIER forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.enable = NO;
        cell.titLabel.text = @"手机号";
        cell.textField.text = self.mobile;
    }else if(indexPath.row == 1)
    {
        cell.enable = YES;
        cell.titLabel.text = @"验证码";
        cell.textField.tag = VALIDINPUTTAG;
        
        self.validTextField = cell.textField;
    }
    else
    {
        cell.textField.userInteractionEnabled = NO;
    }
    return cell;
}


#pragma mark --
#pragma mark -- textfield delegate
- (void)textFieldChanged:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)[notification object];
    

    //the mobile of user input
    if (textField.tag == VALIDINPUTTAG)
    {
        self.operationButton.userInteractionEnabled = textField.text.length>0?YES:NO;
    }
    
}


- (void)operationButtonClick
{
    if (self.validTextField.text.length<6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:@"验证码少于6位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }

    [UserCenterRequest checkvcodeWithMobile:self.mobile vcode:self.validTextField.text success:^(CheckvcodeResponse *responsObject) {
        FillSimpleInfoViewController *fillSimpleInfoVC = [[FillSimpleInfoViewController alloc] init];
        fillSimpleInfoVC.mobile = self.mobile;
        [self presentViewController:fillSimpleInfoVC animated:YES completion:nil];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.operationButton removeObserver:self forKeyPath:@"userInteractionEnabled"];
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timer invalidate];
}

@end


@implementation ValidCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
        _titLabel.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:_titLabel];
        
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titLabel.frame)+5, 0, SCREEN_WIDTH-(CGRectGetMaxX(_titLabel.frame)+5), 44)];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_textField];
    }
    return self;
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    _textField.userInteractionEnabled = enable;
    if (!enable)
    {
        _titLabel.textColor = RGB(117, 118, 119);
        _titLabel.text = @"手机号";
        
    }
    else
    {
        _titLabel.textColor = [UIColor blackColor];
        _textField.placeholder = @"请输入验证码";
        
    }
    _textField.textColor = _titLabel.textColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titLabel.height = self.bounds.size.height;
}

@end

