//
//  WelcomeViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RegisViewController.h"
#import "LoginViewController.h"
@interface WelcomeViewController ()
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LaunchImage@2x.png" ofType:nil];
    _bgImageView.image = [UIImage imageWithContentsOfFile:path];
    [self.view addSubview:_bgImageView];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = RGB(85, 184, 55);
    loginButton.layer.cornerRadius = 5;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(SCREEN_WIDTH/12, SCREEN_HEIGHT-100, SCREEN_WIDTH/3, 35);
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:loginButton];
    
    UIButton *regisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    regisButton.backgroundColor = RGB(85, 184, 55);
    regisButton.layer.cornerRadius = 5;
    [regisButton setTitle:@"注册" forState:UIControlStateNormal];
    [regisButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    regisButton.titleLabel.font = [UIFont systemFontOfSize:16];
    regisButton.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/12-SCREEN_WIDTH/3, SCREEN_HEIGHT-100, SCREEN_WIDTH/3, 35);
    [self.view addSubview:regisButton];
    
    
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [regisButton addTarget:self action:@selector(regisButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)loginButtonClick
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)regisButtonClick
{
    RegisViewController *regisVC = [[RegisViewController alloc] init];
    [self presentViewController:regisVC animated:YES completion:nil];
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
