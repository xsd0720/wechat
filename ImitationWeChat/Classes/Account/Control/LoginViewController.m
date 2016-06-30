//
//  LoginViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "LoginViewController.h"
#import "UserCenterRequest.h"


#define LOGINCELLIDENTIFIER  @"LOGINCELLIDENTIFIER"

#define ACCOUNTTEXTFIELDTAG    210
#define PWDTEXTFIELDTAG        220

@interface LoginCell : UITableViewCell

@property (nonatomic, strong) UILabel *titLabel;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) BOOL enable;

@end

@interface LoginViewController ()

@property (nonatomic, strong) NSString *accountString;

@property (nonatomic, strong) NSString *passwordString;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configSuperTableData];
}


- (void)configSuperTableData
{
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    self.titleLabel.text = @"使用账号和密码登录";


    self.mainTableView.tableHeaderView = self.tableHeaderView;
    [self.operationButton setTitle:@"提交" forState:UIControlStateNormal];
    
    //regis table cell
    [self.mainTableView registerClass:[LoginCell class] forCellReuseIdentifier:LOGINCELLIDENTIFIER];
    
    
    [self.mainTableView reloadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}


#pragma mark --
#pragma mark -- heavy load superclass table method
- (NSInteger)atableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)atableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:LOGINCELLIDENTIFIER forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.enable = NO;
        cell.titLabel.text = @"账户";
        cell.textField.placeholder = @"微信号/邮箱地址/QQ号";
        cell.textField.tag = ACCOUNTTEXTFIELDTAG;
        cell.textField.text = self.accountString;
    }else if(indexPath.row == 1)
    {
        cell.enable = YES;
        cell.titLabel.text = @"密码";
        cell.textField.placeholder = @"请填写密码";
        cell.textField.tag = PWDTEXTFIELDTAG;
        
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
    if (textField.tag == ACCOUNTTEXTFIELDTAG)
    {
        self.accountString = textField.text;
    }else if(textField.tag == PWDTEXTFIELDTAG)
    {
        self.passwordString = textField.text;
    }
    self.operationButton.userInteractionEnabled = (self.accountString.length>0 && self.passwordString.length>5);
}

- (void)operationButtonClick
{
    [UserCenterRequest loginWithMobile:self.accountString password:self.passwordString success:^(LoginResponse *responsObject) {

        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate loginIn];
    
    } failure:^(NSError *error) {
        
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.operationButton removeObserver:self forKeyPath:@"userInteractionEnabled"];
    
}

@end

@implementation LoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
        _titLabel.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:_titLabel];
        
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titLabel.frame)+5, 0, SCREEN_WIDTH-(CGRectGetMaxX(_titLabel.frame)+5), 44)];
        [self addSubview:_textField];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    _titLabel.height = self.bounds.size.height;
}

@end
