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
#import "SendSigntViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define NEED_TO_WRITE_TO_THE_ALBUM      0

#define LOW_ALPHA   0.7f
#define HIGH_ALPHA  1.0f
//对焦
#define ADJUSTINT_FOCUS @"adjustingFocus"
#define SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE      1   //对焦框是否一直闪到对焦完成

#define MINRECORDTIME       1


@interface SightViewController ()<AVCaptureFileOutputRecordingDelegate>
{
    int alphaTimes;
}
@property (nonatomic) dispatch_queue_t sessionQueue;

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureMovieFileOutput *movieFileOutput;

@property (nonatomic, strong) UIView *preLayerView;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preLayer;

@property (nonatomic, strong) UIButton *recordButton;

@property (nonatomic, strong) UIView  *sightMaskLayerView;

@property (nonatomic, strong) UIButton *maskButton;

@property (nonatomic, strong) UIView *lineProgress;

@property (nonatomic, strong) AVCaptureDeviceInput *inputVideo;

@property (nonatomic, strong) UIImageView *focusImageView;

@property (nonatomic, strong) NSDate *startRecordDate;

@end

@implementation SightViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createQueue];
    
    [self configNav];
    
    [self configVideoRecord];
    
    [self configRecordButton];
    
    [self configLineProgess];
}

/**
 *  创建一个队列，防止阻塞主线程
 */
- (void)createQueue {
    dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    self.sessionQueue = sessionQueue;
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
    _inputVideo = [AVCaptureDeviceInput deviceInputWithDevice:[devices firstObject] error:NULL];

    
    //3.创建麦克风设备
    AVCaptureDevice *deviceAudio = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    //4.初始化麦克风输入设备
    AVCaptureDeviceInput *inputAudio = [AVCaptureDeviceInput deviceInputWithDevice:deviceAudio error:NULL];
    
    //5.初始化一个movie的文件输出
    self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    //6.初始化一个会话
    self.session = [[AVCaptureSession alloc] init];
    
    //7.将输入输出设备添加到会话中
    if ([self.session canAddInput:_inputVideo]) {
        [self.session addInput:_inputVideo];
    }
    if ([self.session canAddInput:inputAudio]) {
        [self.session addInput:inputAudio];
    }
    if ([self.session canAddOutput:self.movieFileOutput]) {
        [self.session addOutput:self.movieFileOutput];
    }
    
    _preLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, 250*320/SCREEN_WIDTH)];
    _preLayerView.clipsToBounds = YES;
    _preLayerView.layer.masksToBounds = YES;
    [self.view addSubview:_preLayerView];
    
    UITapGestureRecognizer *oneTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneGesClick:)];
    [_preLayerView addGestureRecognizer:oneTapGes];
    
    UITapGestureRecognizer *doubleTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleGesClick:)];
    doubleTapGes.numberOfTapsRequired = 2;
    [_preLayerView addGestureRecognizer:doubleTapGes];
    
    [oneTapGes requireGestureRecognizerToFail:doubleTapGes];
    
    
    //8.创建一个预览涂层
    _preLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    //设置图层的大小
    _preLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250*320/SCREEN_WIDTH);
    [_preLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //添加到view上
    [_preLayerView.layer addSublayer:_preLayer];
    //9.开始会话
    [self.session startRunning];
    
    [self configMaskLayerView];
    
    [self addFocusView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //开始录制，移除蒙板
        [self.sightMaskLayerView removeFromSuperview];
    });
    
   
    
}


- (void)oneGesClick:(UIGestureRecognizer *)gesture
{
    //对焦框
    [_focusImageView setCenter:[gesture locationInView:gesture.view]];
    _focusImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _focusImageView.alpha = 1.f;
        _focusImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f delay:0.5f options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _focusImageView.alpha = 0.f;
        } completion:nil];
    }];
    [self focusInPoint:[gesture locationInView:self.view]];
}

- (void)doubleGesClick:(UIGestureRecognizer *)gesture
{
//    UITouch *touch = [touches anyObject];
//    [self focusInPoint:[touch locationInView:self.view]];
    [self startShowFocusView:[gesture locationInView:gesture.view]];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    if (_preLayer.affineTransform.a == 2) {
        [_preLayer setAffineTransform:CGAffineTransformIdentity];
    }else
    {
      [_preLayer setAffineTransform:CGAffineTransformMakeScale(2, 2)];
    }
    
    [CATransaction commit];
}

- (void)startShowFocusView:(CGPoint)currTouchPoint
{
    //对焦框
    [_focusImageView setCenter:currTouchPoint];
    _focusImageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    
#if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
    [UIView animateWithDuration:0.1f animations:^{
        _focusImageView.alpha = HIGH_ALPHA;
        _focusImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [self showFocusInPoint:currTouchPoint];
    }];
#else
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _focusImageView.alpha = 1.f;
        _focusImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f delay:0.5f options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _focusImageView.alpha = 0.f;
        } completion:nil];
    }];
#endif
}

//对焦的框
- (void)addFocusView {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touch_focus_x"]];
    imgView.alpha = 0;
    imgView.frame = CGRectMake(0, 0, 40, 40);
    [_preLayerView addSubview:imgView];
    self.focusImageView = imgView;
    
#if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device && [device isFocusPointOfInterestSupported]) {
        [device addObserver:self forKeyPath:ADJUSTINT_FOCUS options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
#endif
}

#pragma mark -------------touch to focus---------------
#if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
//监听对焦是否完成了
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:ADJUSTINT_FOCUS]) {
        BOOL isAdjustingFocus = [[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1] ];
        //        SCDLog(@"Is adjusting focus? %@", isAdjustingFocus ? @"YES" : @"NO" );
        //        SCDLog(@"Change dictionary: %@", change);
        if (!isAdjustingFocus) {
            alphaTimes = -1;
        }
    }
}

- (void)showFocusInPoint:(CGPoint)touchPoint {
    
    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        int alphaNum = (alphaTimes % 2 == 0 ? HIGH_ALPHA : LOW_ALPHA);
        self.focusImageView.alpha = alphaNum;
        alphaTimes++;
        
    } completion:^(BOOL finished) {
        
        if (alphaTimes != -1) {
            [self showFocusInPoint:touchPoint];
        } else {
            self.focusImageView.alpha = 0.0f;
        }
    }];
}
#endif


/**
 *  点击后对焦
 *
 *  @param devicePoint 点击的point
 */
- (void)focusInPoint:(CGPoint)devicePoint {
    //    if (CGRectContainsPoint(_previewLayer.bounds, devicePoint) == NO) {
    //        return;
    //    }
    
    devicePoint = [self convertToPointOfInterestFromViewCoordinates:devicePoint];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposeWithMode:AVCaptureExposureModeContinuousAutoExposure atDevicePoint:devicePoint monitorSubjectAreaChange:YES];
}


- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposeWithMode:(AVCaptureExposureMode)exposureMode atDevicePoint:(CGPoint)point monitorSubjectAreaChange:(BOOL)monitorSubjectAreaChange {
    
    dispatch_async(_sessionQueue, ^{
        AVCaptureDevice *device = [_inputVideo device];
        NSError *error = nil;
        if ([device lockForConfiguration:&error])
        {
            if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:focusMode])
            {
                [device setFocusMode:focusMode];
                [device setFocusPointOfInterest:point];
            }
            if ([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:exposureMode])
            {
                [device setExposureMode:exposureMode];
                [device setExposurePointOfInterest:point];
            }
            [device setSubjectAreaChangeMonitoringEnabled:monitorSubjectAreaChange];
            [device unlockForConfiguration];
        }
        else
        {
            NSLog(@"%@", error);
        }
    });
}

/**
 *  外部的point转换为camera需要的point(外部point/相机页面的frame)
 *
 *  @param viewCoordinates 外部的point
 *
 *  @return 相对位置的point
 */
- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates {
    CGPoint pointOfInterest = CGPointMake(.5f, .5f);
    CGSize frameSize = _preLayer.bounds.size;
    
    AVCaptureVideoPreviewLayer *videoPreviewLayer = self.preLayer;
    
    if([[videoPreviewLayer videoGravity]isEqualToString:AVLayerVideoGravityResize]) {
        pointOfInterest = CGPointMake(viewCoordinates.y / frameSize.height, 1.f - (viewCoordinates.x / frameSize.width));
    } else {
        CGRect cleanAperture;
        for(AVCaptureInputPort *port in [[self.session.inputs lastObject]ports]) {
            if([port mediaType] == AVMediaTypeVideo) {
                cleanAperture = CMVideoFormatDescriptionGetCleanAperture([port formatDescription], YES);
                CGSize apertureSize = cleanAperture.size;
                CGPoint point = viewCoordinates;
                
                CGFloat apertureRatio = apertureSize.height / apertureSize.width;
                CGFloat viewRatio = frameSize.width / frameSize.height;
                CGFloat xc = .5f;
                CGFloat yc = .5f;
                
                if([[videoPreviewLayer videoGravity]isEqualToString:AVLayerVideoGravityResizeAspect]) {
                    if(viewRatio > apertureRatio) {
                        CGFloat y2 = frameSize.height;
                        CGFloat x2 = frameSize.height * apertureRatio;
                        CGFloat x1 = frameSize.width;
                        CGFloat blackBar = (x1 - x2) / 2;
                        if(point.x >= blackBar && point.x <= blackBar + x2) {
                            xc = point.y / y2;
                            yc = 1.f - ((point.x - blackBar) / x2);
                        }
                    } else {
                        CGFloat y2 = frameSize.width / apertureRatio;
                        CGFloat y1 = frameSize.height;
                        CGFloat x2 = frameSize.width;
                        CGFloat blackBar = (y1 - y2) / 2;
                        if(point.y >= blackBar && point.y <= blackBar + y2) {
                            xc = ((point.y - blackBar) / y2);
                            yc = 1.f - (point.x / x2);
                        }
                    }
                } else if([[videoPreviewLayer videoGravity]isEqualToString:AVLayerVideoGravityResizeAspectFill]) {
                    if(viewRatio > apertureRatio) {
                        CGFloat y2 = apertureSize.width * (frameSize.width / apertureSize.height);
                        xc = (point.y + ((y2 - frameSize.height) / 2.f)) / y2;
                        yc = (frameSize.width - point.x) / frameSize.width;
                    } else {
                        CGFloat x2 = apertureSize.height * (frameSize.height / apertureSize.width);
                        yc = 1.f - ((point.x + ((x2 - frameSize.width) / 2)) / x2);
                        xc = point.y / frameSize.height;
                    }
                    
                }
                
                pointOfInterest = CGPointMake(xc, yc);
                break;
            }
        }
    }
    
    return pointOfInterest;
}

- (void)configLineProgess
{
    self.lineProgress = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_preLayerView.frame), 0, 3)];
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
    _maskButton.frame = CGRectMake((SCREEN_WIDTH-100)/2, CGRectGetMaxY(_preLayerView.frame)-30, 100, 30);
    [self.view addSubview:_maskButton];
    
}

- (void)configRecordButton
{
    self.recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.backgroundColor = [UIColor clearColor];
    [self.recordButton setTitle:@"按住拍" forState:UIControlStateNormal];
    self.recordButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.recordButton setTitleColor:RGBCOLOR(112, 175, 109) forState:UIControlStateNormal];
    self.recordButton.frame = CGRectMake((SCREEN_WIDTH-150)/2, CGRectGetMaxY(_preLayerView.frame)+60, 150, 150);
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
    self.lineProgress.backgroundColor = RGBCOLOR(133, 228, 58);
    self.startRecordDate = [NSDate date];
    
    self.lineProgress.width = SCREEN_WIDTH;
    self.lineProgress.centerX = self.view.centerX;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.recordButton.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.recordButton.alpha = 0.0f;
    }];

    [UIView animateWithDuration:8 animations:^{
        self.lineProgress.width = 0;
        self.lineProgress.centerX = self.view.centerX;
    } completion:^(BOOL finished) {
        
    }];
    
//    [self startRecord];
}

- (void)recordButtonTouchUpInside
{
    [self.lineProgress.layer removeAllAnimations];
     NSLog(@"recordButtonTouchUpInside");
    [_maskButton setTitle:@"双击放大" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.recordButton.transform = CGAffineTransformIdentity;
        self.recordButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        //录制完成，判断时间是否过短
        NSDate *currentDate = [NSDate date];
        if ([currentDate timeIntervalSinceDate:self.startRecordDate] <=MINRECORDTIME) {
            [_maskButton setTitle:@"好好录,别闹" forState:UIControlStateNormal];
        }
        else
        {
            SendSigntViewController *sendSigntVC = [[SendSigntViewController alloc] init];
            sendSigntVC.playPathURL = [self recordVideoSavePath];
            [self.navigationController pushViewController:sendSigntVC animated:YES];
        }

    }];

    
//    [self stopRecord];
}

- (void)recordButtonTouchUpOutside
{
    [_maskButton setTitle:@"双击放大" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.recordButton.transform = CGAffineTransformIdentity;
        self.recordButton.alpha = 1.0f;
    }];
    [self.lineProgress.layer removeAllAnimations];
}

- (void)recordButtonTouchDragExit
{
    [_maskButton setTitle:@"松手取消" forState:UIControlStateNormal];
    self.lineProgress.backgroundColor = [UIColor purpleColor];
}

- (void)recordButtonTouchDragEnter
{
    [_maskButton setTitle:@"上移取消" forState:UIControlStateNormal];
    self.lineProgress.backgroundColor = RGBCOLOR(133, 228, 58);
}

- (NSURL *)recordVideoSavePath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths lastObject];
    NSString *aa = [docPath stringByAppendingPathComponent:@"output.mp4"];

    NSURL *fileURL = [NSURL fileURLWithPath:aa];
    return fileURL;

}

- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开始录制
- (void)startRecord
{
    if (self.movieFileOutput) {
      
        [self.movieFileOutput startRecordingToOutputFileURL:[self recordVideoSavePath] recordingDelegate:self];
    }
   
}

//停止录制
- (void)stopRecord
{
    if ([self.movieFileOutput isRecording]) {
        [self.movieFileOutput stopRecording];
    }
}


#pragma mark - AVCaptureFileOutputRecordingDelegate

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections

{
    NSLog(@"start record video");
    
}

//录制完成代理
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    NSLog(@"完成录制,可以自己做进一步的处理");
#if NEED_TO_WRITE_TO_THE_ALBUM
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // 将临时文件夹中的视频文件复制到 照片 文件夹中，以便存取
    [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
     
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    
                                    if (error) {
                                        
                                        NSLog(@"error %@", error);
                                        
                                    }
                                    
                                    else
                                        
                                       NSLog(@"保存成功 %@", error);
                                    
                                }];
#endif
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
