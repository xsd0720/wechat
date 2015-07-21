//
//  QRCodeViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QrCodeHollowView.h"


#import "QRCodeDetailViewController.h"
#import "TabBarItem.h"
static float QRBorderMarginTop = 80.f;

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    CABasicAnimation *animation;
    QrCodeHollowView *hollowView;
    UILabel *promptLabel;
    
    UIView *chooseView;
}
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic,strong) NSArray *chooseSubViewData;

@property (nonatomic,strong) NSMutableArray *chooseItemArray;

@end

@implementation QRCodeViewController


-(NSArray *)chooseSubViewData{
    return @[
             
             @{
                @"imageName":@"ScanQRCode",
                @"imageName_HL":@"ScanQRCode_HL",
                @"text":@"扫码"
                 },
             @{
                 @"imageName":@"ScanBook",
                 @"imageName_HL":@"ScanBook_HL",
                 @"text":@"封面"
                 },
             @{
                 @"imageName":@"ScanStreet",
                 @"imageName_HL":@"ScanStreet_HL",
                 @"text":@"街景"
                 },
             @{
                 @"imageName":@"ScanWord",
                 @"imageName_HL":@"ScanWord_HL",
                 @"text":@"翻译"
                 }
             ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setUpQRCodeUI];
    [self setUpChooseView];
    [self startReading];

}
-(void)setupNav{
    self.navigationItem.title = @"二维码/条码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
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
    

}

//加载功能选择
-(void)setUpChooseView{
    chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
    chooseView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    [self.view addSubview:chooseView];
    
//    CGFloat padding = 10;
    CGFloat w = chooseView.frame.size.width/4;
    CGFloat h = chooseView.frame.size.height;
    
    
    _chooseItemArray = [NSMutableArray array];
    
    for (int i=0; i<4; i++) {
        TabBarItem *tabbrItem = [[TabBarItem alloc] initWithFrame:CGRectMake(i*w,0, w, h)];
       // [tabbrItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        tabbrItem.button.frame = CGRectMake(0,0, w, h-12);
        [tabbrItem.button setImage:[UIImage imageNamed:self.chooseSubViewData[i][@"imageName"]] forState:UIControlStateNormal];
        [tabbrItem.button setImage:[UIImage imageNamed:self.chooseSubViewData[i][@"imageName_HL"]] forState:UIControlStateSelected];
        tabbrItem.label.text = self.chooseSubViewData[i][@"text"];
        tabbrItem.label.frame  = CGRectMake(0, tabbrItem.frame.size.height-12, w, 8);
        [chooseView addSubview:tabbrItem];
        tabbrItem.tag = i;
        [tabbrItem addTarget:self action:@selector(chooseViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_chooseItemArray addObject:tabbrItem];
        
        if (i == 0) {
            tabbrItem.selected = YES;
        }
    }
    
    
}
//功能选择
-(void)chooseViewClick:(UIButton *)button{
    
    [_chooseItemArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = NO;
    }];
    button.selected = YES;
    
    switch (button.tag) {
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

//开启二维码扫描
- (BOOL)startReading {
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
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

//得到扫描结果
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            QRCodeDetailViewController *qrDetailVc = [[QRCodeDetailViewController alloc] init];
            qrDetailVc.showQrData = [metadataObj stringValue];
            [self.navigationController pushViewController:qrDetailVc animated:YES];
            
        }
    }
}

@end
