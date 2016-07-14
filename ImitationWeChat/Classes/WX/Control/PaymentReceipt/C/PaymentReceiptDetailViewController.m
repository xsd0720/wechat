//
//  PaymentReceiptDetailViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/13.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "PaymentReceiptDetailViewController.h"
#import "QRCode.h"
#import "LXActionSheet.h"
#import <objc/runtime.h>
#import "NSTimer+CycleScrollView.h"
static const char chaAssociatedkey;
static const char defaultCenterAssociatedkey;
@interface PaymentReceiptDetailViewController ()<LXActionSheetDelegate>

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *payMainView;

@property (nonatomic, strong) UIView *panHandleView;

@property (nonatomic, strong) UIView *panHandleViewTemp;

@property (nonatomic, strong) UIImageView *imgViewQRCode;

@property (nonatomic, strong) LXActionSheet *actionSheet;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *updatePrompt ;

@end

@implementation PaymentReceiptDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    
    [self configMainUI];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refreshPayCodeSomething) userInfo:nil repeats:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)configNav
{
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_navView];
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 200, 44)];
    _titleView.centerX = _navView.width/2;
    [_navView addSubview:_titleView];
    
    
    UILabel *upTitleViewItemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetMaxX(_titleView.bounds), CGRectGetMaxY(_titleView.bounds)/2)];
    upTitleViewItemLabel.textColor = [UIColor whiteColor];
    upTitleViewItemLabel.textAlignment = 1;
    upTitleViewItemLabel.font = [UIFont boldSystemFontOfSize:15];
    [_titleView addSubview:upTitleViewItemLabel];
    
    UILabel *bottomTitleViewItemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(upTitleViewItemLabel.frame), CGRectGetMaxX(_titleView.bounds), 12)];
    bottomTitleViewItemLabel.text = @"微信安全支付";
    bottomTitleViewItemLabel.textColor = [UIColor whiteColor];
    bottomTitleViewItemLabel.font = [UIFont systemFontOfSize:10];
    bottomTitleViewItemLabel.textAlignment = 1;
    [_titleView addSubview:bottomTitleViewItemLabel];
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [closeButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(5, 20, 50, 44);
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView addSubview:closeButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [rightButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView addSubview:rightButton];
    
    
    if (self.moneyType == MoneyTypePay) {
        upTitleViewItemLabel.text = @"付款";
        [rightButton setImage:[UIImage imageNamed:@"barbuttonicon_more"] forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(SCREEN_WIDTH-50-5, 20, 50, 44);
    }else
    {
        upTitleViewItemLabel.text = @"收钱";
        [rightButton setTitle:@"设置金额" forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(SCREEN_WIDTH-80-5, 20, 80, 44);
    }
    
}


- (void)configMainUI
{
    CGFloat marginLeftRight = 14;
    CGFloat orginY = CGRectGetMaxY(_navView.frame)+30;
    CGFloat payMainViewHeight = SCREEN_HEIGHT*0.7;
    _payMainView = [[UIView alloc] initWithFrame:CGRectMake(marginLeftRight, orginY, SCREEN_WIDTH-2*marginLeftRight, payMainViewHeight)];
    _payMainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_payMainView];
   
    if (self.moneyType == MoneyTypePay) {
        
        [self refreshPayCodeSomething];
        
        _payMainView.backgroundColor = wechatGraycolor;
        
       
        
        UIButton *selectPayType = [[UIButton alloc] initWithFrame:CGRectMake(0, _payMainView.height-64, _payMainView.width, 44)];
        [selectPayType setTitle:@"零钱,更换" forState:UIControlStateNormal];
        [selectPayType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        selectPayType.titleLabel.font = [UIFont systemFontOfSize:13];
        [selectPayType addTarget:self action:@selector(selectPayTypeClick) forControlEvents:UIControlEventTouchUpInside];
        [_payMainView addSubview:selectPayType];

        
        _updatePrompt = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64, SCREEN_WIDTH, 20)];
        _updatePrompt.text = @"每分钟自动更新";
        _updatePrompt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _updatePrompt.font = [UIFont systemFontOfSize:14];
        _updatePrompt.textAlignment = 1;
        [self.view addSubview:_updatePrompt];
        
        UIButton *bottomPrompt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomPrompt setImage:[UIImage imageNamed:@"Wechatpay_Bottom_Icon"] forState:UIControlStateNormal];
        [bottomPrompt setTitle:@" 微信支付" forState:UIControlStateNormal];
        [bottomPrompt setTitleColor:wechatGraycolor forState:UIControlStateNormal];
        bottomPrompt.titleLabel.font = [UIFont systemFontOfSize:13];
        bottomPrompt.frame = CGRectMake(0, SCREEN_HEIGHT-44, 100, 44);
        bottomPrompt.centerX = self.view.centerX;
        [self.view addSubview:bottomPrompt];
        
    }else{
    
        UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, _payMainView.width, 40)];
        promptLabel.text = @"无需加好友，扫二维码向我付钱";
        promptLabel.font = [UIFont boldSystemFontOfSize:13];
        promptLabel.textAlignment = 1;
        [_payMainView addSubview:promptLabel];
        
        UIImageView *dashImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(promptLabel.frame)+20, CGRectGetMaxX(promptLabel.bounds), 5)];
        dashImageView.image = [UIImage drawDashLineRect:dashImageView.frame];
        [_payMainView addSubview:dashImageView];
        
        
        CGFloat imageViewQrCodeSize = _payMainView.width*0.68;
        _imgViewQRCode = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewQrCodeSize, imageViewQrCodeSize)];
        _imgViewQRCode.center = CGPointMake(_payMainView.width/2, _payMainView.height/2+50);
        _imgViewQRCode.image = [QRCode createQRCodeImage:@"https://wx.tenpay.com/f2f?t=AQAAANUaWXYCim2MVADnMmmmAX0%3D" size:_imgViewQRCode.width icon:@"000"];
        [_payMainView addSubview:_imgViewQRCode];


    }
}

- (UIView *)panHandleViewTemp
{
    if (!_panHandleViewTemp) {
        CGFloat marginLeftRight = 14;
        CGFloat orginY = CGRectGetMaxY(_navView.frame)+30;
        
        _panHandleViewTemp = [[UIView alloc] initWithFrame:CGRectMake(marginLeftRight, orginY, _payMainView.width, _payMainView.height-60)];
        _panHandleViewTemp.backgroundColor = [UIColor whiteColor];
        
        if (_panHandleView.superview) {
            [self.view insertSubview:_panHandleViewTemp belowSubview:_panHandleView];
        }else{
            [self.view addSubview:_panHandleViewTemp];
        }
        
        NSMutableString *stringRandom = [[NSMutableString alloc] init];;
        for (int i=0; i<22; i++) {
            NSString *s = [NSString stringWithFormat:@"%i", arc4random()%9];
            [stringRandom appendString:s];
            if ((i+1) %4 == 0 && i!=0 && i<18) {
                [stringRandom appendString:@" "];
            }
        }
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _payMainView.width, 35)];
        label.text = stringRandom;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = 1;
        [_panHandleViewTemp addSubview:label];
        
        UIImageView *txmImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 35, _payMainView.width-30, 140)];
        txmImage.image=[UIImage generateBarCode:label.text width:txmImage.frame.size.width height:txmImage.frame.size.height];
        [_panHandleViewTemp addSubview:txmImage];
        
        CGFloat imageViewQrCodeSize = _payMainView.width*0.53;
        _imgViewQRCode = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewQrCodeSize, imageViewQrCodeSize)];
        _imgViewQRCode.center = CGPointMake(_payMainView.width/2, _payMainView.height/2+40);
        _imgViewQRCode.image = [QRCode createQRCodeImage:label.text size:_imgViewQRCode.width];
        [_panHandleViewTemp addSubview:_imgViewQRCode];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        [_panHandleViewTemp addGestureRecognizer:pan];

    }
    return _panHandleViewTemp;
}


- (void)panHandle:(UIPanGestureRecognizer *)recognizer
{
    UIView* view = self.navigationController.view;

    CGPoint location = [recognizer locationInView:view];
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        
        CGPoint chaPoint = CGPointMake(_panHandleView.centerX - location.x, _panHandleView.centerY - location.y);
        
        NSString *pointString = NSStringFromCGPoint(chaPoint);
        
        objc_setAssociatedObject(self, &chaAssociatedkey, pointString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &defaultCenterAssociatedkey, NSStringFromCGPoint(_panHandleView.center), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
      
        [self resetpanHandleViewTemp];
        
        [_timer pauseTimer];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        NSString *pointString = objc_getAssociatedObject(self, &chaAssociatedkey);
        CGPoint point = CGPointFromString(pointString);
        _panHandleView.center = CGPointMake(location.x+point.x, location.y+point.y);
        
        
        
        NSString *defaultPointString = objc_getAssociatedObject(self, &defaultCenterAssociatedkey);
        CGPoint defaultPoint = CGPointFromString(defaultPointString);
        CGFloat xDist = fabs((fabs(_panHandleView.center.x) - fabs(defaultPoint.x)));
        CGFloat yDist = fabs((fabs(_panHandleView.center.y) - fabs(defaultPoint.y)));
        CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
        
        [self updatePanHandleViewSubAlpha:1 - distance/350];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if(CGRectContainsPoint(_payMainView.frame, _panHandleView.center))
        {
            NSString *pointString = objc_getAssociatedObject(self, &defaultCenterAssociatedkey);
            CGPoint point = CGPointFromString(pointString);
            self.view.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.1 animations:^{
                _panHandleView.center = point;
                
                [self updatePanHandleViewSubAlpha:1];
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled = YES;
                [self resetpanHandleViewTemp];
                [_timer resumeTimer];
            }];
            
        }else
        {
            NSString *pointString = objc_getAssociatedObject(self, &chaAssociatedkey);
            CGPoint point = CGPointFromString(pointString);
            point = CGPointMake(_panHandleView.center.x + point.x*10, _panHandleView.center.y + point.y*10);
            
            [UIView animateWithDuration:0.2 animations:^{
                _panHandleView.center = point;
                
                [self updatePanHandleViewSubAlpha:0];
            
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled = YES;
                [self refreshPayCodeSomething];
                [_timer resumeTimer];
            }];
        }
    }
    
}

- (void)refreshPayCodeSomething
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (_panHandleView) {
        [_panHandleView removeFromSuperview];
        _panHandleView = nil;
    }
    
    _updatePrompt.textColor = [UIColor whiteColor];
    _updatePrompt.text = @"已更新";
    
    _panHandleView = self.panHandleViewTemp;
    _panHandleViewTemp = nil;
    
    [self performSelector:@selector(restUpDataPromptLabel) withObject:nil afterDelay:0.6];
    
}

- (void)restUpDataPromptLabel
{
    _updatePrompt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    _updatePrompt.text = @"每分钟自动更新";
}

- (void)resetpanHandleViewTemp
{
    if (_panHandleViewTemp) {
        [_panHandleViewTemp removeFromSuperview];
        _panHandleViewTemp = nil;
    }
    if (!self.panHandleViewTemp.superview) {
        [self.view insertSubview:self.panHandleViewTemp belowSubview:self.panHandleView];
    }
}

- (void)updatePanHandleViewSubAlpha:(CGFloat)alpha
{
    for (UIView *v in _panHandleView.subviews) {
        v.alpha = alpha;
    }
}

- (void)selectPayTypeClick
{
    
}

- (void)closeButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)rightButtonClick
{
    if (self.moneyType == MoneyTypePay) {
        self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"使用说明", @"暂停使用", nil];
        [self.actionSheet showInView:self.view];

    }
}


- (void)didClickOnButtonIndex:(int)buttonIndex
{
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
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
