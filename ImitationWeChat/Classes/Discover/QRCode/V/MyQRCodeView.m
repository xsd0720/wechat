//
//  MyQRCodeView.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MyQRCodeView.h"
#import "QRCode.h"
@interface MyQRCodeView()

@property (nonatomic, strong) UIView *qrCodeBackgroundView;

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIImageView *qrcodeView;

@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation MyQRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _qrCodeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _qrCodeBackgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_qrCodeBackgroundView];
        
        
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        _headerImageView.image = [UIImage imageNamed:@"111.png"];
        _headerImageView.layer.borderColor = [RGBCOLOR(216, 217, 217) CGColor];
        _headerImageView.layer.borderWidth = 1;
        _headerImageView.layer.cornerRadius = 5;
        _headerImageView.clipsToBounds = YES;
        [_qrCodeBackgroundView addSubview:_headerImageView];
        
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, CGRectGetMinY(_headerImageView.frame)+10, 200, 20)];
        _userNameLabel.text = @"王辉👦";
        _userNameLabel.font = [UIFont boldSystemFontOfSize:15];
        [_qrCodeBackgroundView addSubview:_userNameLabel];
        
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, CGRectGetMaxY(_headerImageView.frame)-20, 200, 20)];
        _addressLabel.text = @"阿尔及利亚";
        _addressLabel.font = [UIFont systemFontOfSize:13];
        [_qrCodeBackgroundView addSubview:_addressLabel];
        
        
        UIImage *qrcode = [QRCode createQRCodeImage:@"http://weixin.qq.com/r/XK6AmAPES140rUf79-tO" size:250.0f];
        _qrcodeView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetMaxX(_qrCodeBackgroundView.bounds)-200)/2, CGRectGetMaxY(_headerImageView.frame)+20, 200, 200)];
        _qrcodeView.image = qrcode;
        [_qrCodeBackgroundView addSubview:_qrcodeView];
        
        
        
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_qrCodeBackgroundView.bounds)-17-20, CGRectGetMaxX(_qrCodeBackgroundView.bounds), 20)];
        _promptLabel.text = @"扫一扫上面的二维码图案，加我微信";
        _promptLabel.textColor = RGBCOLOR(151, 151, 151);
        _promptLabel.font = [UIFont systemFontOfSize:10];
        _promptLabel.textAlignment = 1;
        [_qrCodeBackgroundView addSubview:_promptLabel];

    }
    return self;
}

@end
