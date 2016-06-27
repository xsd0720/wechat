//
//  RegisViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "RegisViewController.h"
#import "CountryViewController.h"
#import "MyNavViewController.h"
#import "ValidMobileViewController.h"
#import "UserCenterRequest.h"

#define  REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER  @"REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER"
#define  REGISGPHONETABLEVIEWCELLIDENTIFIER  @"REGISGPHONETABLEVIEWCELLIDENTIFIER"
#define  EMPTYCELLIDENTIFIER     @"EMPTYCELLIDENTIFIER"

#define COUNRTYCODETAG      100
#define INPUTMOBILETAG      200

@interface PhoneCell : UITableViewCell

@property (nonatomic, strong) UITextField *leftTextField;
@property (nonatomic, strong) UITextField *rightTextField;
@property (nonatomic, strong) UIView *lineview;

@end


@interface CountryCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;


@end

@interface RegisViewController ()<CountryChoiceDelegate, UITextFieldDelegate, UIAlertViewDelegate>

//Save changes to memory
@property (nonatomic, strong) NSString *currentCountryName;
@property (nonatomic, strong) NSString *currentCounryCode;
@property (nonatomic, strong) NSString *currentInputNumberText;

//Global index change object
@property (nonatomic, strong) UILabel *countryNameLabel;
@property (nonatomic, strong) UITextField *countrycodeTextField;
@property (nonatomic, strong) UITextField *inputPhoneNumberTextField;

@end

@implementation RegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configSuperTableData];
}

- (void)configSuperTableData
{

    self.currentCountryName = [PreLoadTool sharedInstance].mmCountry.name;
    self.currentCounryCode = [PreLoadTool sharedInstance].mmCountry.dial_code;
    [self.operationButton setTitle:@"注册" forState:UIControlStateNormal];
    
    //regis table cell
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:EMPTYCELLIDENTIFIER];
    [self.mainTableView registerClass:[CountryCell class] forCellReuseIdentifier:REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER];
    [self.mainTableView registerClass:[PhoneCell class] forCellReuseIdentifier:REGISGPHONETABLEVIEWCELLIDENTIFIER];
    
    
    [self.mainTableView reloadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}


#pragma mark --
#pragma mark -- textfield delegate
- (void)textFieldChanged:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)[notification object];
    
    //the phone code of country
    if (textField.tag == COUNRTYCODETAG) {
        
        if (textField.text.length <= 1)
        {
            self.countryNameLabel.text = LOCALIZATION(@"SELECTFROMLIST");
        }
        else
        {
            MMCountry *mmCountry = [[PreLoadTool sharedInstance] getMMCountryWithPhoneCode:textField.text];
            self.countryNameLabel.text = mmCountry?mmCountry.name:LOCALIZATION(@"COUNTRYCODINVALID");
        }
    }
    
    //the mobile of user input
    else if (textField.tag == INPUTMOBILETAG)
    {
        self.operationButton.userInteractionEnabled = textField.text.length>0?YES:NO;
        self.currentInputNumberText = textField.text;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == COUNRTYCODETAG) {
        if (textField.text.length <= 1 && string.length <=0) {
            return NO;
        }
    }
    if (textField.tag == INPUTMOBILETAG) {
        if (textField.text.length > 10 && string.length != 0) {
            return NO;
        }
    }
    return YES;
}



#pragma mark --
#pragma mark -- heavy load superclass table method
- (NSInteger)atableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)atableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightLabel.text = self.currentCountryName;
        self.countryNameLabel = cell.rightLabel;
        return cell;
    }else if(indexPath.row == 1)
    {
        PhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:REGISGPHONETABLEVIEWCELLIDENTIFIER forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.leftTextField.text = self.currentCounryCode;
        cell.leftTextField.tag = COUNRTYCODETAG;
        cell.leftTextField.delegate = self;
        cell.rightTextField.delegate = self;
        
        cell.rightTextField.tag = INPUTMOBILETAG;
        cell.rightTextField.text = self.currentInputNumberText;
        
        self.countrycodeTextField = cell.leftTextField;
        self.inputPhoneNumberTextField = cell.rightTextField;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EMPTYCELLIDENTIFIER forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)atableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CountryViewController *countryVC = [[CountryViewController alloc] init];
        countryVC.delegate = self;
        MyNavViewController *mynav = [[MyNavViewController alloc] initWithRootViewController:countryVC];
        [self presentViewController:mynav animated:YES completion:nil];
    }
}



- (void)didChoiceCountryCode:(MMCountry *)mmCountry
{
    if (mmCountry) {
        
        self.countryNameLabel.text = mmCountry.name;
        self.countrycodeTextField.text = mmCountry.dial_code;
        
        self.currentCountryName = mmCountry.name;
        self.currentCounryCode = mmCountry.dial_code;
    }
}



- (void)operationButtonClick
{
    //获取注册的手机号
    NSString *phoneNumber = self.inputPhoneNumberTextField.text;
    if (phoneNumber.length <= 0) {
        [self.view makeToast:@"手机号为空"];
        return;
    }
    if (![ValidTool validateMobile:phoneNumber]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码错误" message:@"你输入的是一个无效的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSString *message1 = @"我们将发送验证码短信到这个号码";
    NSString *message2 = [NSString stringWithFormat:@"%@ %@", self.countrycodeTextField.text, self.inputPhoneNumberTextField.text];
    NSString *totalMessage = [NSString stringWithFormat:@"%@\n%@", message1, message2];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认手机号码" message:totalMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        ValidMobileViewController *validMobileVC = [[ValidMobileViewController alloc] init];
//        validMobileVC.mobile = [NSString stringWithFormat:@"%@ %@", self.countrycodeTextField.text, self.inputPhoneNumberTextField.text];
        validMobileVC.mobile = self.inputPhoneNumberTextField.text;
        [self presentViewController:validMobileVC animated:YES completion:nil];
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.operationButton removeObserver:self forKeyPath:@"userInteractionEnabled"];
    
}



@end


@implementation PhoneCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
        _leftTextField.tintColor = RGB(85, 184, 55);
        _leftTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_leftTextField];
        
        _lineview = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftTextField.bounds)-1, 0, 1, 44)];
        _lineview.backgroundColor = RGB(239, 239, 240);
        [_leftTextField addSubview:_lineview];
        
        _rightTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftTextField.frame)+20, 0, SCREEN_WIDTH-CGRectGetMaxX(_leftTextField.frame)-20, 44)];
        _rightTextField.tintColor = RGB(85, 184, 55);
        _rightTextField.placeholder = @"请填写手机号";
        _rightTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_rightTextField];
        
       
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _leftTextField.height = _lineview.height = _rightTextField.height = self.bounds.size.height;
}

@end


@implementation CountryCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.text = @"国家/地区";
        _leftLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftLabel.frame)+20, 0, 200-20, 44)];
        _rightLabel.font = [UIFont systemFontOfSize:16];
        _rightLabel.textColor = [UIColor blackColor];
        [self addSubview:_rightLabel];
        
         self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _leftLabel.height = _rightLabel.height = self.bounds.size.height;
}

@end
