//
//  QRCodeViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QrCodeHollowView.h"
#import "MyQRCodeViewController.h"

#import "QRCodeDetailViewController.h"
#import "QRCode.h"
//自定义tabbar
#import "ChooseTabbar.h"

static float QRBorderMarginTop = 80.f;

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,ChooseTabbarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    CABasicAnimation *animation;
    QrCodeHollowView *hollowView;
    UILabel *promptLabel;
    
    ChooseTabbar *chooseTabbar;
    
    BOOL isGetResult;
}
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;


@property (nonatomic,strong) NSMutableArray *chooseItemArray;

@end

@implementation QRCodeViewController

/**
 *  设置相机
 */
- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
        _imagePickerController.navigationBar.barTintColor = [UIColor blackColor];
        _imagePickerController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        
        //系统返回默认蓝色 改成白色
        _imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    }
    return _imagePickerController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setUpQRCodeUI];
    [self setUpChooseView];
    [self startReading];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    isGetResult = NO;
}

-(void)setupNav{
    self.navigationItem.title = @"二维码/条码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    UIButton *rightBarItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarItemButton.frame = CGRectMake(0, 0, 44, 30);
    [rightBarItemButton setTitle:@"相册" forState:UIControlStateNormal];
    rightBarItemButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarItemButton addTarget:self action:@selector(rightBarItemButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarItemButton];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set-new"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_setClick)];
    [self.navigationItem addRightBarButtonItem:rightBarItem];
    
}

- (void)rightBarItemButtonClick
{
    //  系统相册
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        // Only movie
//        NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//        self.imagePickerController.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
//    }
    [self presentViewController:self.imagePickerController animated:YES completion:^{
    }];
}


#pragma mark - imagepickerDelgate

//  用户选中图片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
   //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
//    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);

    [QRCode recognizeImage:image block:^(ZXBarcodeFormat barcodeFormat, NSString *str) {
       
        NSLog(@"%@", str);
        [self.view makeToast:str];
    }];
    
    
}

//加载二维码扫描UI
-(void)setUpQRCodeUI{

    //移动条的可视范围
    UIView *moveLineBoundView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, QRBorderMarginTop, 200, 200)];
    moveLineBoundView.center =  self.view.center;
    moveLineBoundView.layer.masksToBounds = YES;
    [self.view addSubview:moveLineBoundView];
    
    
    //移动条
    UIImageView *imageViewScanLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -moveLineBoundView.frame.size.height, moveLineBoundView.frame.size.width, moveLineBoundView.frame.size.height)];
    imageViewScanLine.image = [UIImage imageNamed:@"qrcode_scanline_qrcode"];
    [moveLineBoundView addSubview:imageViewScanLine];
    
    
    
    UIImage *qrcode_borderImage = [UIImage imageNamed:@"qrcode_border"];
    qrcode_borderImage = [qrcode_borderImage stretchableImageWithLeftCapWidth:qrcode_borderImage.size.width/2 topCapHeight:qrcode_borderImage.size.height/2];
    CGFloat border = 0;
    UIImageView *qrcode_borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(moveLineBoundView.frame.origin.x-border, moveLineBoundView.frame.origin.y-border, moveLineBoundView.frame.size.width+border+border, moveLineBoundView.frame.size.height+border+border)];
    //    imageView.backgroundColor = [UIColor redColor];
    qrcode_borderImageView.image = qrcode_borderImage;
    [self.view addSubview:qrcode_borderImageView];
    
    
    
    //加载动画
    animation =
    [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:moveLineBoundView.frame.size.height+imageViewScanLine.frame.size.height];
    animation.removedOnCompletion = YES;
    [animation setDuration:2.0];
    animation.repeatCount = MAXFLOAT;
    [imageViewScanLine.layer addAnimation:animation forKey:nil];
    
    
    
    //镂空View
    hollowView = [[QrCodeHollowView alloc] initWithFrame:self.view.frame];
    hollowView.hollowRect = qrcode_borderImageView.frame;
    [self.view addSubview:hollowView];
    
    
    //提示文字
    promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, getViewHeight(qrcode_borderImageView), SCREEN_WIDTH, 30)];
    promptLabel.textAlignment = 1;
    promptLabel.text = @"将二维码/条码放入框中,既可自动扫描";
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.font = [UIFont systemFontOfSize:13.f];
    [self.view addSubview:promptLabel];
    
    UIButton *myQrCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myQrCodeButton.frame = CGRectMake((SCREEN_WIDTH-100)/2, CGRectGetMaxY(promptLabel.frame)+35, 100, 30);
    [myQrCodeButton setTitle:@"我的二维码" forState:UIControlStateNormal];
    myQrCodeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [myQrCodeButton setTitleColor:RGBCOLOR(31, 161, 27) forState:UIControlStateNormal];
    [myQrCodeButton  addTarget:self action:@selector(myQrCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myQrCodeButton];
    
    

}

#pragma mark ChooseTabbar

//加载功能选择
-(void)setUpChooseView{
    chooseTabbar = [[ChooseTabbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60) subViewData:DS.qrCodeChooseSubViewData  normalColor:[UIColor grayColor] hightlightColor:RGBCOLOR(72, 165, 15)];
    chooseTabbar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    chooseTabbar.delegate = self;
    [self.view addSubview:chooseTabbar];
}
//choosetabbar delegate
-(void)ChooseTabbarDidSelectItem:(NSInteger)index{
    switch (index) {
        case 0:
        {
            promptLabel.text = @"将二维码/条码放入框中,既可自动扫描";
        }
            break;
        case 1:
        {
            promptLabel.text = @"将书、CD、电影海报放入框内，即可自动扫描";
        }
            break;
        case 2:
        {
            promptLabel.text = @"扫一下周围环境，寻找附近街景";
        }
            break;
        case 3:
        {
            promptLabel.text = @"将英文单词放入框内";
        }
            break;
        default:
            break;
    }

}


#pragma mark -  二维码扫描
//开启二维码扫描
- (BOOL)startReading {
    
    isGetResult = NO;
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
//    captureMetadataOutput.rectOfInterest = CGRectMake(0, 0, 100, 100);
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    [_captureSession startRunning];
    
    return YES;
}
-(void)stopReading{
    isGetResult = YES;
    
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

//得到扫描结果
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

    if (isGetResult) {
        return;
    }
    isGetResult = YES;
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            QRCodeDetailViewController *qrDetailVc = [[QRCodeDetailViewController alloc] init];
            qrDetailVc.showQrData = [metadataObj stringValue];
            [self.navigationController pushViewController:qrDetailVc animated:YES];
            
        }
    }
}

//我的二维码
- (void)myQrCodeButtonClick
{
    MyQRCodeViewController *myQRCodeViewController = [[MyQRCodeViewController alloc] init];
    [self.navigationController pushViewController:myQRCodeViewController animated:YES];
}

@end
