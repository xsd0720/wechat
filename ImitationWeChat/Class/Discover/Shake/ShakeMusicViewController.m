//
//  ShakeMusicViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/13.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "ShakeMusicViewController.h"
#import "UIImage+MostColor.h"
#import "GradientLayerView.h"
#import "FMLrcView.h"
#import "NSString+URLParse.h"
@interface ShakeMusicViewController ()
@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UIColor *mostColor;

@property (nonatomic, strong) FMLrcView *licView;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) NSTimer *progressUpdateTimer;
@end

@implementation ShakeMusicViewController


//- (UIImageView *)getGraView:(CGRect)frame
//{
//    UIImage *im = [UIImage imageNamed:@"Albumtimeline_video_shadow_down"];
//    im = [im stretchableImageWithLeftCapWidth:im.size.width/2 topCapHeight:im.size.height/2];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
//    imageView.image = im;
//    return imageView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取图片主色调
    UIImage *headerImage = [UIImage imageNamed:@"longjuanfeng.jpg"];
    self.mostColor = [headerImage mostColor];
    self.view.backgroundColor = self.mostColor;

    
    //添加专辑图片
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
    _headerImageView.image = headerImage;
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.clipsToBounds = YES;
    [self.view addSubview:_headerImageView];
    
    CGFloat graViewHeight = 50;
    _licView = [[FMLrcView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerImageView.frame)+30, SCREEN_WIDTH, 255)];
    _licView.backgroundColor = self.mostColor;
    [self.view addSubview:_licView];
    
    
    GradientLayerView *graView1 = [[GradientLayerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerImageView.frame)-175, SCREEN_WIDTH, 175) mostColor:self.mostColor];
    graView1.direction = DirectionDown;
    graView1.userInteractionEnabled = NO;
    [self.view addSubview:graView1];

    
    GradientLayerView *graView2 = [[GradientLayerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerImageView.frame)+30, SCREEN_WIDTH, graViewHeight) mostColor:self.mostColor];
    graView2.direction = DirectionUP;
    graView2.userInteractionEnabled = NO;
    [self.view addSubview:graView2];
    
    
    GradientLayerView *graView3 = [[GradientLayerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_licView.frame)-graViewHeight, SCREEN_WIDTH, graViewHeight) mostColor:self.mostColor];
    graView3.direction = DirectionDown;
    graView3.userInteractionEnabled = NO;
    [self.view addSubview:graView3];
    
    
    
    UIImage *playButtonImage = [UIImage imageNamed:@"player_star_button"];
    CGFloat pw = playButtonImage.size.width*1.5;
    CGFloat ph = playButtonImage.size.height*1.5;
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake((SCREEN_WIDTH-pw)/2, SCREEN_HEIGHT-50-ph, pw, ph);
    [playButton setBackgroundImage:[UIImage imageNamed:@"player_star_button"] forState:UIControlStateNormal];
    [playButton setBackgroundImage:[UIImage imageNamed:@"player_suspend_button"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    [self setRadioViewLrc];
    
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"longjuanfeng" ofType:@"mp3"]] error:nil];
    _audioPlayer.volume = 1;
    [_audioPlayer prepareToPlay];
    
    [self startTimer];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 44, 44);
    [backButton setImage:[UIImage imageNamed:@"fts_search_backicon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
}

- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)playButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_audioPlayer play];
    }
    else
    {
        [_audioPlayer pause];
    }
    
}

//设置歌词显示
-(void)setRadioViewLrc
{
    [_licView setLrcSourcePath:[[NSBundle mainBundle] pathForResource:@"longjuanfeng" ofType:@"lrc"]];
}

//开始定时器
-(void)startTimer
{
    _progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                            target:self
                                                          selector:@selector(updatePlaybackProgress)
                                                          userInfo:nil
                                                           repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_progressUpdateTimer forMode:NSRunLoopCommonModes];
}

- (void)updatePlaybackProgress
{
    NSLog(@"====%@   %f", [self conversionSecondsToTime:_audioPlayer.currentTime], _audioPlayer.currentTime);
    NSString *currentTimeString = [self conversionSecondsToTime:_audioPlayer.currentTime];
    
    [_licView scrollViewMoveLabelWith:currentTimeString];
}


- (NSString *)conversionSecondsToTime:(double)time
{
    double minutesRemaining = floor(time / 60.0);
    double secondsRemaining = fmod(time, 60.0);
    
    NSString *secondsRemainingString = [NSString stringWithFormat:@"%.2f", secondsRemaining];
    NSString *tempString = [[secondsRemainingString componentsSeparatedByString:@"."] firstObject];
    if (tempString.length == 1) {
        secondsRemainingString = [NSString stringWithFormat:@"0%@", secondsRemainingString];
    }
    NSString *timeRmainingString = [NSString stringWithFormat:@"%02.0f:%@", minutesRemaining, secondsRemainingString];
    return timeRmainingString;
    
//    //禁止四舍五入
//    double minutesRemaining = floor(time / 60.0);
//    double secondsRemaining = fmod(time, 60.0);
//
//    NSString *secondsRemainingString = [self notRounding:secondsRemaining afterPoint:2];
//    NSString *tempString = [[secondsRemainingString componentsSeparatedByString:@"."] firstObject];
//    if (tempString.length == 1) {
//        secondsRemainingString = [NSString stringWithFormat:@"0%@", secondsRemainingString];
//    }
//    
//    NSString *timeRmainingString = [NSString stringWithFormat:@"%02.0f:%@", minutesRemaining, secondsRemainingString];
//    return timeRmainingString;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_progressUpdateTimer invalidate];
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
