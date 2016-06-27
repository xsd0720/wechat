//
//  AccountBaseViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/27.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "AccountBaseViewController.h"

@interface AccountBaseViewController ()

@end

@implementation AccountBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNav];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:_navView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


#pragma mark ---
#pragma mark --- make custom navigation
- (void)configNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)];
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:_navView];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelButton setTitleColor:RGB(92, 156, 64) forState:UIControlStateNormal];
    _cancelButton.frame = CGRectMake(15, 20, 44, 44);
    [_cancelButton addTarget:self action:@selector(cancelButtonIndex) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_cancelButton];
}

#pragma mark --- 
#pragma mark --- make tableview subview

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"请输入你的手机号";
    }
    return _titleLabel;
}
- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:self.titleLabel];
    }
    return _tableHeaderView;
}


- (UIButton *)operationButton
{
    if (!_operationButton) {
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, 44);
        _operationButton.layer.cornerRadius = 5;
        _operationButton.backgroundColor = RGB(175, 221, 168);


        _operationButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_operationButton addTarget:self action:@selector(operationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_operationButton addObserver:self forKeyPath:@"userInteractionEnabled" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        _operationButton.userInteractionEnabled = NO;
        [self updateOperationButtonBgImage:@"Success_BtnGreen"];
    }
    return _operationButton;
}
- (UIView *)tableFooterView
{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _tableFooterView.backgroundColor = [UIColor whiteColor];
        [_tableFooterView addSubview:self.operationButton];
    }
    return _tableFooterView;
}



/**
 *  懒加载tableiview
 */
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_mainTableView];
        [self.view bringSubviewToFront:self.navView];
        _mainTableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
        _mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    
        // 设置cell的重用

        _mainTableView.tableHeaderView = self.tableHeaderView;
        
        _mainTableView.tableFooterView = self.tableFooterView;
       
    }
    return _mainTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self atableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self atableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self atableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)atableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)cancelButtonIndex
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    int userInteractionEnabledOld = [[change objectForKey:NSKeyValueChangeOldKey] intValue];
    int userInteractionEnabledNew = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
    if (userInteractionEnabledOld == userInteractionEnabledNew) {
        return;
    }
    BOOL userInteractionEnabled = [[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:0] ];
    NSString *imageName;
    if (userInteractionEnabled) {
        imageName = @"Success_BtnGreen";
    }
    else
    {
        imageName = @"Success_BtnGreenHl";
    }
    [self updateOperationButtonBgImage:imageName];
}

- (void)updateOperationButtonBgImage:(NSString *)imName
{
    UIImage *im = [UIImage imageNamed:imName];
    im = [im stretchableImageWithLeftCapWidth:im.size.width/2 topCapHeight:im.size.height/2];
    [self.operationButton setBackgroundImage:im forState:UIControlStateNormal];
}

- (void)operationButtonClick
{
    
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
