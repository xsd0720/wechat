//
//  MyQRCodeViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "LXActionSheet.h"
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
    
    
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:@"http://weixin.qq.com/r/XK6AmAPES140rUf79-tO"] withSize:250.0f];
    UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:60.0f andGreen:74.0f andBlue:89.0f];
    self.qrcodeView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetMaxX(_qrCodeBackgroundView.bounds)-200)/2, CGRectGetMaxY(headerImageView.frame)+20, 200, 200)];
    self.qrcodeView.image = customQrcode;
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
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex
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

#pragma mark - InterpolatedUIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - QRCodeGenerator
- (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}


@end
