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

#define  REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER  @"REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER"
#define  REGISGPHONETABLEVIEWCELLIDENTIFIER  @"REGISGPHONETABLEVIEWCELLIDENTIFIER"
#define EMPTYCELLIDENTIFIER     @"EMPTYCELLIDENTIFIER"

@interface PhoneCell : UITableViewCell

@property (nonatomic, strong) UITextField *leftTextField;
@property (nonatomic, strong) UITextField *rightTextField;
@property (nonatomic, strong) UIView *lineview;

@end


@interface CountryCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;


@end

@interface RegisViewController ()<UITableViewDelegate, UITableViewDataSource, CountryChoiceDelegate, UITextFieldDelegate>

//nav
@property(nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *FooterView;

@property (nonatomic, strong) UIButton *regisButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSString *currentCountryName;

@property (nonatomic, strong) NSString *currentCounryCode;

@property (nonatomic, strong) UITextField *countrycodeTextField;

@property (nonatomic, strong) UITextField *inputPhoneNumberTextField;

@end

@implementation RegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self configNav];
    [self configData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"请输入你的手机号";
    }
    return _titleLabel;
}


- (UIView *)FooterView
{
    if (!_FooterView) {
        _FooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _FooterView.backgroundColor = [UIColor whiteColor];
        
        [_FooterView addSubview:self.regisButton];
    }
    return _FooterView;
}

- (UIButton *)regisButton
{
    if (!_regisButton) {
        _regisButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _regisButton.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, 44);
        _regisButton.layer.cornerRadius = 5;
        _regisButton.backgroundColor = RGB(85, 184, 55);
        _regisButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_regisButton setTitle:@"注册" forState:UIControlStateNormal];
        [_regisButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_regisButton addTarget:self action:@selector(regisButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regisButton;
}

/**
 *  懒加载tableiview
 */
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_mainTableView];
        
        _mainTableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        
        // 设置cell的重用
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:EMPTYCELLIDENTIFIER];
        [_mainTableView registerClass:[CountryCell class] forCellReuseIdentifier:REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER];
        [_mainTableView registerClass:[PhoneCell class] forCellReuseIdentifier:REGISGPHONETABLEVIEWCELLIDENTIFIER];
        _mainTableView.tableHeaderView = self.titleLabel;
        
        _mainTableView.tableFooterView = self.FooterView;
        _mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _mainTableView;
}


- (void)configNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)];
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:_navView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelButton setTitleColor:RGB(92, 156, 64) forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(15, 20, 44, 44);
    [cancelButton addTarget:self action:@selector(cancelButtonIndex) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:cancelButton];
    
    [self.view bringSubviewToFront:_navView];
}

- (void)configData
{

    
    self.currentCountryName = [System sharedInstance].mmCountry.name;
    self.currentCounryCode = [System sharedInstance].mmCountry.dial_code;
    [self.mainTableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)textFieldChanged:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)[notification object];
    if (textField.tag == 100) {
       
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length <= 1 && string.length <=0) {
        return NO;
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:REGISGCOUNTRYTABLEVIEWCELLIDENTIFIER forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightLabel.text = self.currentCountryName;
        return cell;
    }else if(indexPath.row == 1)
    {
        PhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:REGISGPHONETABLEVIEWCELLIDENTIFIER forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftTextField.text = self.currentCounryCode;
        cell.leftTextField.tag = 100;
        cell.leftTextField.delegate = self;
        cell.rightTextField.tag = 200;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EMPTYCELLIDENTIFIER forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
    
    self.currentCountryName = mmCountry.name;
    self.currentCounryCode = mmCountry.dial_code;
    [self.mainTableView reloadData];
}

- (void)cancelButtonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)regisButtonClick
{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _leftLabel.height = _rightLabel.height = self.bounds.size.height;
}

@end
