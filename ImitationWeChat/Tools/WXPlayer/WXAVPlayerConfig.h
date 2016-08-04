//
//  WXAVPlayerConfig.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/8/2.
//  Copyright © 2016年 wany. All rights reserved.
//

#ifndef WXAVPlayerConfig_h
#define WXAVPlayerConfig_h

//获取屏幕 宽度、高度
#define VIDEOSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define VIDEOSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark ----------------------------------------top defines----------------------------------------------
#pragma mark --  top defines
//topbar 高度
#define WXAVPlayerControlTopBarHeight                           (MIN(VIDEOSCREEN_WIDTH, VIDEOSCREEN_HEIGHT)*44.0f/320.0f)
#define WXAVPlayerControlTopBarBackButtonMarginLeft             6.0f
#define WXAVPlayerControlTopBarBackButtonMarginTop              0.0f
#define WXAVPlayerControlTopBarBackButtonHeight                 (WXAVPlayerControlTopBarHeight-2*WXAVPlayerControlTopBarBackButtonMarginTop)
#define WXAVPlayerControlTopBarBackButtonWidth                  WXAVPlayerControlTopBarBackButtonHeight
#define WXAVPlayerControlTopBarBackButtonRect                   CGRectMake(WXAVPlayerControlTopBarBackButtonMarginLeft, WXAVPlayerControlTopBarBackButtonMarginTop, WXAVPlayerControlTopBarBackButtonWidth, WXAVPlayerControlTopBarBackButtonHeight)




#pragma mark ----------------------------------------bottom defines----------------------------------------------
#pragma mark -- bottom defines
#define WXAVPlayerControlBottomBarHeight    (MIN(VIDEOSCREEN_WIDTH, VIDEOSCREEN_HEIGHT)*44.0f/320.0f)



#endif /* WXAVPlayerConfig_h */


//GPUImageContrastFilter *secondFilter = [[GPUImageContrastFilter alloc] init];
//[secondFilter setContrast:1.80];
//GPUImageBrightnessFilter *firstFilter = [[GPUImageBrightnessFilter alloc] init];
//[firstFilter setBrightness:0.1]; //GPUImageColorBurnBlendFilter
//GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init];
//filter.red = 0.8;
//filter.green = 1;
//filter.blue = 1.2;
//NSURL *vedioURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"s2" ofType:@"mp4"]];
//GPUImageMovie *movie = [[GPUImageMovie alloc] initWithURL:vedioURL];
//movie.runBenchmark = YES; //
//[movie addTarget:filter];
//[movie addTarget:secondFilter];
//GPUImageMovieWriter *vedioWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:[NSURL fileURLWithPath:@"/Users/huazai/Desktop/t/t16.mov"] size:CGSizeMake(1280, 800)];
//movie.audioEncodingTarget = nil;
//vedioWriter.shouldPassthroughAudio = YES;
//movie.playAtActualSpeed = NO;
//[movie startProcessing];
//[filter addTarget:vedioWriter]; //
//[secondFilter addTarget:vedioWriter];
//[vedioWriter startRecording];
//[vedioWriter setCompletionBlock:^{ NSLog(@"已完成！！！"); }];

//创建滤镜