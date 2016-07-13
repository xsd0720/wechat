//
//  PaymentReceiptDetailViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/13.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "PaymentReceiptDetailViewController.h"
#import "QRCode.h"
@interface PaymentReceiptDetailViewController ()

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *payMainView;

@property (nonatomic, strong) UIImageView *imgViewQRCode;

@end

@implementation PaymentReceiptDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    
    [self configMainUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)configNav
{
    
    self.view.backgroundColor = RGB(220, 193, 71);
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_navView];
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 200, 44)];
    _titleView.centerX = _navView.width/2;
    [_navView addSubview:_titleView];
    
    
    UILabel *upTitleViewItemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetMaxX(_titleView.bounds), CGRectGetMaxY(_titleView.bounds)/2)];
    upTitleViewItemLabel.text = @"收钱";
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
    CGFloat marginLeftRight = 14;
    CGFloat orginY = CGRectGetMaxY(_navView.frame)+30;
    CGFloat payMainViewHeight = SCREEN_HEIGHT*0.7;
    _payMainView = [[UIView alloc] initWithFrame:CGRectMake(marginLeftRight, orginY, SCREEN_WIDTH-2*marginLeftRight, payMainViewHeight)];
    _payMainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_payMainView];
    
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
    [_payMainView addSubview:_imgViewQRCode];
    [self loadqrcode];
}
- (void)loadqrcode {
 //用于生成二维码的字符串source
    NSString *source = @"https://wx.tenpay.com/f2f?t=AQAAANUaWXYCim2MVADnMmmmAX0%3D";

     //使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
     CIImage *imgQRCode = [QRCode createQRCodeImage:source];

     //使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
     UIImage *imgAdaptiveQRCode = [QRCode resizeQRCodeImage:imgQRCode
                                                                                          withSize:_imgViewQRCode.frame.size.width];

     //默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片，例如：蓝白色的二维码图片
//     imgAdaptiveQRCode = [QRCode specialColorImage:imgAdaptiveQRCode
//                                                                         withRed:33.0
//                                                                           green:114.0
//                                                                            blue:237.0]; //0~255

     //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
     UIImage *imgIcon = [UIImage createRoundedRectImage:[UIImage imageNamed:@"000"]
                                                                          withSize:CGSizeMake(44, 44)
                                                                        withRadius:2];
     //使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
     imgAdaptiveQRCode = [QRCode addIconToQRCodeImage:imgAdaptiveQRCode
                                                                           withIcon:imgIcon
                                                                       withIconSize:imgIcon.size];

 //    imgAdaptiveQRCode = [KMQRCode addIconToQRCodeImage:imgAdaptiveQRCode
 //                                              withIcon:imgIcon
 //                                             withScale:3];

     _imgViewQRCode.image = imgAdaptiveQRCode;
     //设置图片视图的圆角边框效果
//     _imgViewQRCode.layer.masksToBounds = YES;
//     _imgViewQRCode.layer.cornerRadius = 10.0;
//     _imgViewQRCode.layer.borderColor = [UIColor lightGrayColor].CGColor;
//     _imgViewQRCode.layer.borderWidth = 4.0;
    
}

- (void)closeButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
