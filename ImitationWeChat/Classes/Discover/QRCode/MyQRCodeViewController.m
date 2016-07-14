//
//  MyQRCodeViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "LXActionSheet.h"
#import "QRCode.h"
@interface MyQRCodeViewController()<LXActionSheetDelegate>
@property (nonatomic, strong) LXActionSheet *actionSheet;
@end

@implementation MyQRCodeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadNav];
    
    self.view.backgroundColor = RGBCOLOR(45, 49, 50);
    _qrCodeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(22, 60+64, (SCREEN_WIDTH - 44), (SCREEN_HEIGHT-120 - 64))];
    _qrCodeBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_qrCodeBackgroundView];
    
    
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    headerImageView.image = [UIImage imageNamed:@"111.png"];
    headerImageView.layer.borderColor = [RGBCOLOR(216, 217, 217) CGColor];
    headerImageView.layer.borderWidth = 1;
    headerImageView.layer.cornerRadius = 5;
    headerImageView.clipsToBounds = YES;
    [_qrCodeBackgroundView addSubview:headerImageView];
    
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerImageView.frame)+10, CGRectGetMinY(headerImageView.frame)+10, 200, 20)];
    userNameLabel.text = @"王辉👦";
    userNameLabel.font = [UIFont boldSystemFontOfSize:15];
    [_qrCodeBackgroundView addSubview:userNameLabel];
   
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerImageView.frame)+10, CGRectGetMaxY(headerImageView.frame)-20, 200, 20)];
    addressLabel.text = @"阿尔及利亚";
    addressLabel.font = [UIFont systemFontOfSize:13];
    [_qrCodeBackgroundView addSubview:addressLabel];
  
    
    UIImage *qrcode = [QRCode createQRCodeImage:@"http://weixin.qq.com/r/XK6AmAPES140rUf79-tO" size:250.0f];
    self.qrcodeView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetMaxX(_qrCodeBackgroundView.bounds)-200)/2, CGRectGetMaxY(headerImageView.frame)+20, 200, 200)];
    self.qrcodeView.image = qrcode;
    [_qrCodeBackgroundView addSubview:self.qrcodeView];

    
    
    UILabel  *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_qrCodeBackgroundView.bounds)-17-20, CGRectGetMaxX(_qrCodeBackgroundView.bounds), 20)];
    promptLabel.text = @"扫一扫上面的二维码图案，加我微信";
    promptLabel.textColor = RGBCOLOR(151, 151, 151);
    promptLabel.font = [UIFont systemFontOfSize:10];
    promptLabel.textAlignment = 1;
    [_qrCodeBackgroundView addSubview:promptLabel];
    
}

-(void)loadNav{
    self.navigationItem.title = @"我的二维码";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_moreClick)];
    
}

- (void)barbuttonicon_moreClick
{
    self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"换个样式", @"保存图片", nil];
    
    [self.actionSheet showInView:self.view];
}


#pragma mark - Actionsheetdelegate

//点击项目
- (void)didClickOnButtonIndex:(int)buttonIndex
{
    if ((int)buttonIndex == 0) {
        
        // 换个样式

    }
    else if ((int)buttonIndex == 1)
    {
        //  保存图片
        UIGraphicsBeginImageContextWithOptions(_qrCodeBackgroundView.bounds.size, NO, 0);
        [_qrCodeBackgroundView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*  viewImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(viewImage,nil,nil,nil);
        
        [self.view makeToast:@"保存成功"];
    }
}

//点击取消
- (void)didClickOnCancelButton
{
    NSLog(@"cancelButton");
}




@end
