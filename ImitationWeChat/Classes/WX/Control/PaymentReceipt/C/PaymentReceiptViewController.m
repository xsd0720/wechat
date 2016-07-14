//
//  PaymentReceiptViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/12.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "PaymentReceiptViewController.h"
#import "PaymentReceiptDetailViewController.h"
#import "UIImage+Color.h"
#import "PresentAnimator.h"
@interface PaymentReceiptViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *shouButton;

@property (nonatomic, strong) UIButton *fuButton;

@property (nonatomic, strong) PresentAnimator *presentAnimator;

@end

@implementation PaymentReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    
    [self configMainUI];
    
    self.presentAnimator = [PresentAnimator new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)configNav
{
    
    self.view.backgroundColor = RGB(238, 239, 245);
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_navView];
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 200, 44)];
    _titleView.centerX = _navView.width/2;
    [_navView addSubview:_titleView];
    
    
    UILabel *upTitleViewItemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetMaxX(_titleView.bounds), CGRectGetMaxY(_titleView.bounds)/2)];
    upTitleViewItemLabel.text = @"收付款";
    upTitleViewItemLabel.textColor = RGB(65, 65, 65);
    upTitleViewItemLabel.textAlignment = 1;
    upTitleViewItemLabel.font = [UIFont boldSystemFontOfSize:15];
    [_titleView addSubview:upTitleViewItemLabel];
    
    UILabel *bottomTitleViewItemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(upTitleViewItemLabel.frame), CGRectGetMaxX(_titleView.bounds), 12)];
    bottomTitleViewItemLabel.text = @"微信安全支付";
    bottomTitleViewItemLabel.textColor = RGB(38, 38, 38);
    bottomTitleViewItemLabel.font = [UIFont systemFontOfSize:10];
    bottomTitleViewItemLabel.textAlignment = 1;
    [_titleView addSubview:bottomTitleViewItemLabel];
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [closeButton setTitleColor:RGB(30, 30, 31) forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(5, 20, 50, 44);
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView addSubview:closeButton];
}

- (void)configMainUI
{
    CGFloat buttonWidth = SCREEN_WIDTH * 0.93;
    CGFloat leftRightMargin = (SCREEN_WIDTH - buttonWidth)/2;
    CGFloat marginTop = CGRectGetMaxY(_navView.frame)+30;
    CGFloat buttonHeight = (SCREEN_HEIGHT * 0.77-leftRightMargin)/2;

    
    
    _shouButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shouButton.frame = CGRectMake(leftRightMargin, marginTop, buttonWidth, buttonHeight);
    [_shouButton setBackgroundImage:[UIImage ImageWithColor:wechatGraycolor frame:_shouButton.frame] forState:UIControlStateHighlighted];
    [_shouButton addTarget:self action:@selector(shouButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shouButton];
    
    
    _fuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fuButton.frame = _shouButton.frame;

    [_fuButton addTarget:self action:@selector(fuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_fuButton setBackgroundImage:[UIImage ImageWithColor:wechatGraycolor frame:_fuButton.frame] forState:UIControlStateHighlighted];
    _fuButton.originY = CGRectGetMaxY(_shouButton.frame)+leftRightMargin;
    [self.view addSubview:_fuButton];

    
    [self setUpButtonSubView:_fuButton];
    [self setUpButtonSubView:_shouButton];

}



- (void)fuButtonClick
{
    for (UIView *v in _fuButton.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            CGRect rr = [_fuButton convertRect:v.frame toView:self.view];
            self.presentAnimator.startRect = rr;
            self.presentAnimator.startViewColor = v.backgroundColor;
            break;
        }
    }
    
    PaymentReceiptDetailViewController *paymentReceiptDetailVC = [[PaymentReceiptDetailViewController alloc] init];
    paymentReceiptDetailVC.moneyType = MoneyTypePay;
    paymentReceiptDetailVC.transitioningDelegate = self;
    paymentReceiptDetailVC.view.backgroundColor = self.presentAnimator.startViewColor;
    [self presentViewController:paymentReceiptDetailVC animated:YES completion:nil];
    
}

- (void)shouButtonClick
{
    for (UIView *v in _shouButton.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            
            CGRect rr = [_shouButton convertRect:v.frame toView:self.view];
            self.presentAnimator.startRect = rr;
            self.presentAnimator.startViewColor = v.backgroundColor;
            break;
        }
    }
    
    PaymentReceiptDetailViewController *paymentReceiptDetailVC = [[PaymentReceiptDetailViewController alloc] init];
    paymentReceiptDetailVC.moneyType = MoneyTypeReceive;
    paymentReceiptDetailVC.transitioningDelegate = self;
    paymentReceiptDetailVC.view.backgroundColor = self.presentAnimator.startViewColor;
    [self presentViewController:paymentReceiptDetailVC animated:YES completion:nil];
}

- (void)setUpButtonSubView:(UIView *)preView
{
    [preView setExclusiveTouch:YES];
    preView.backgroundColor = [UIColor whiteColor];
    preView.layer.borderColor = [RGB(228, 229, 232) CGColor];
    preView.layer.borderWidth = 1;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 150/2, 150/2);
    

    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    button.layer.cornerRadius = button.width/2;
    button.layer.allowsEdgeAntialiasing = YES;
    [preView addSubview:button];
    button.centerY = preView.height/2-24;
    button.centerX = preView.width/2;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, preView.height/2+38, preView.width, 25)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = 1;
    [preView addSubview:label];
    
    if (preView == _shouButton) {
        [button setBackgroundColor:RGB(220, 193, 71)];
        [button setTitle:@"收" forState:UIControlStateNormal];
        
        label.text = @"我要收款";
    }else
    {
        [button setBackgroundColor:RGB(84, 182, 54)];
        [button setTitle:@"付" forState:UIControlStateNormal];
        label.text = @"向商家付款";
    }
}


- (void)closeButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    return self.presentAnimator;
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
