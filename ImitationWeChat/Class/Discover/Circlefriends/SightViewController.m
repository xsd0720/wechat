//
//  SightViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SightViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
@interface SightViewController ()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;

@property (nonatomic, strong) AVCaptureAudioDataOutput *audioOutput;

@property (nonatomic, strong) AVCaptureMovieFileOutput *movieFileOutput;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preLayer;

@property (nonatomic, strong) UIButton *recordButton;

@property (nonatomic, strong) UIView  *sightMaskLayerView;

@property (nonatomic, strong) UIButton *maskButton;

@property (nonatomic, strong) UIView *lineProgress;

@end

@implementation SightViewController
@synthesize session, videoOutput, audioOutput;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    
    [self configVideoRecord];
    
    [self configRecordButton];
}

//配置导航
- (void)configNav
{
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton * button_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_back setTitle:@"取消" forState:UIControlStateNormal];
    [button_back setTitleColor:RGBCOLOR(28, 218, 65) forState:UIControlStateNormal];
    [button_back.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button_back.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_back addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *leftnegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                         target :nil action:nil];
    leftnegativeSpacer.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[leftnegativeSpacer, [[UIBarButtonItem alloc]initWithCustomView:button_back]];

}

- (void)configVideoRecord
{
    //1.创建视频设备(摄像头前，后)
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    //2.初始化一个摄像头输入设备(first是后置摄像头，last是前置摄像头)
    AVCaptureDeviceInput *inputVideo = [AVCaptureDeviceInput deviceInputWithDevice:[devices firstObject] error:NULL];
    
    //3.创建麦克风设备
    AVCaptureDevice *deviceAudio = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    //4.初始化麦克风输入设备
    AVCaptureDeviceInput *inputAudio = [AVCaptureDeviceInput deviceInputWithDevice:deviceAudio error:NULL];
    
    //5.初始化一个movie的文件输出
    self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    //6.初始化一个会话
    self.session = [[AVCaptureSession alloc] init];
    
    //7.将输入输出设备添加到会话中
    if ([session canAddInput:inputVideo]) {
        [session addInput:inputVideo];
    }
    if ([session canAddInput:inputAudio]) {
        [session addInput:inputAudio];
    }
    if ([session canAddOutput:self.movieFileOutput]) {
        [session addOutput:self.movieFileOutput];
    }
    
    //8.创建一个预览涂层
    _preLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //设置图层的大小
    _preLayer.frame = CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, 250*320/SCREEN_WIDTH);
    [_preLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //添加到view上
    [self.view.layer addSublayer:_preLayer];
    //9.开始会话
    [session startRunning];
    
    [self configMaskLayerView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //开始录制，移除蒙板
        [self.sightMaskLayerView removeFromSuperview];
    });
    
    
}

- (void)configLineProgess
{
    self.lineProgress = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_preLayer.frame), SCREEN_WIDTH, 5)];
    self.lineProgress.backgroundColor = RGBCOLOR(133, 228, 58);
    [self.view addSubview:self.lineProgress];
}

//创建蒙板
- (void)configMaskLayerView
{
    self.sightMaskLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, 250*320/SCREEN_WIDTH)];
    self.sightMaskLayerView.backgroundColor = RGBCOLOR(174, 175, 171);
    [self.view addSubview:self.sightMaskLayerView];
    
    UIImage *imageMask = [UIImage imageNamed:@"icon_sight_capture_mask"];
    UIImageView *imageViewMask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageMask.size.width, imageMask.size.height)];
    imageViewMask.center = CGPointMake(CGRectGetMaxX(self.sightMaskLayerView.bounds)/2, CGRectGetMaxY(self.sightMaskLayerView.bounds)/2);
    imageViewMask.image = imageMask;
    [self.sightMaskLayerView addSubview:imageViewMask];
    
    
    _maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_maskButton setBackgroundImage:[UIImage imageNamed:@"sight_label_shadow@2x"] forState:UIControlStateNormal];
    [_maskButton setTitle:@"双击放大" forState:UIControlStateNormal];
    [_maskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _maskButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _maskButton.frame = CGRectMake((SCREEN_WIDTH-100)/2, CGRectGetMaxY(_preLayer.frame)-30, 100, 30);
    [self.view addSubview:_maskButton];
    
}

- (void)configRecordButton
{
    self.recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.backgroundColor = [UIColor clearColor];
    [self.recordButton setTitle:@"按住拍" forState:UIControlStateNormal];
    self.recordButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.recordButton setTitleColor:RGBCOLOR(112, 175, 109) forState:UIControlStateNormal];
    self.recordButton.frame = CGRectMake((SCREEN_WIDTH-150)/2, CGRectGetMaxY(_preLayer.frame)+60, 150, 150);
    self.recordButton.layer.cornerRadius = 150/2;
    self.recordButton.layer.borderWidth = 2;
    self.recordButton.layer.borderColor = [RGBCOLOR(112, 175, 109) CGColor];
    [self.recordButton addTarget:self action:@selector(recordButtonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.recordButton addTarget:self action:@selector(recordButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.recordButton addTarget:self action:@selector(recordButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
     [self.recordButton addTarget:self action:@selector(recordButtonTouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [self.recordButton addTarget:self action:@selector(recordButtonTouchDragEnter) forControlEvents:UIControlEventTouchDragEnter];
    [self.view addSubview:self.recordButton];
}

- (void)recordButtonTouchDown
{
    NSLog(@"recordButtonTouchDown");
    [_maskButton setTitle:@"上移取消" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.recordButton.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.recordButton.alpha = 0.0f;
    }];
}

- (void)recordButtonTouchUpInside
{
     NSLog(@"recordButtonTouchUpInside");
  
}

- (void)recordButtonTouchUpOutside
{
    [_maskButton setTitle:@"双击放大" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.recordButton.transform = CGAffineTransformIdentity;
        self.recordButton.alpha = 1.0f;
    }];
}

- (void)recordButtonTouchDragExit
{
    [_maskButton setTitle:@"松手取消" forState:UIControlStateNormal];
}

- (void)recordButtonTouchDragEnter
{
    [_maskButton setTitle:@"上移取消" forState:UIControlStateNormal];
}

- (NSURL *)recordVideoSavePath
{
    NSString *path = [DocumentPath stringByAppendingPathComponent:@"myVidio.mov"];
    NSURL *url = [NSURL fileURLWithPath:path];
    return url;
}

- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开始录制
- (void)startRecord
{
    [self.movieFileOutput startRecordingToOutputFileURL:[self recordVideoSavePath] recordingDelegate:self];
}

//停止录制
- (void)stopRecord
{
    if ([self.movieFileOutput isRecording]) {
        [self.movieFileOutput stopRecording];
    }
}


#pragma mark - AVCaptureFileOutputRecordingDelegate
//录制完成代理
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    NSLog(@"完成录制,可以自己做进一步的处理");
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
