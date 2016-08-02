//
//  WXMovieManager.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/27.
//  Copyright © 2016年 wany. All rights reserved.
//
//NSURL *movieURL = [NSURL fileURLWithPath:sFileNamePath];
//
//MPMoviePlayerController *movewController =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//
//[movewController prepareToPlay];
//
//[self.view addSubview:movewController.view];//设置写在添加之后   // 这里是addSubView
//
//movewController.shouldAutoplay=YES;
//
//[movewController setControlStyle:MPMovieControlStyleDefault];
//
//[movewController setFullscreen:YES];
//
//[movewController.view setFrame:self.view.bounds];
//
//这里注册相关操作的通知
//
//[[NSNotificationCenter defaultCenter] addObserver:self
// 
//                                         selector:@selector(movieFinishedCallback:)
// 
//                                             name:MPMoviePlayerPlaybackDidFinishNotification
// 
//                                           object:moveViewController.movewController]; //播放完后的通知



#import "WXMoviePlayerController.h"
#import "WXAVPlayer.h"
#import "WXAVPlayerControl.h"

@interface WXMoviePlayerController()

@property (nonatomic) UIView *view;

@property (nonatomic) WXAVPlayer *avPlayer;

@property (nonatomic) WXAVPlayerControl *avPlayerControl;

@end


@implementation WXMoviePlayerController

- (WXAVPlayer *)avPlayer
{
    if (!_avPlayer) {
        _avPlayer = [[WXAVPlayer alloc] init];
        _avPlayer.backgroundColor = [UIColor cyanColor];
        
    }
    return _avPlayer;
}



- (instancetype)initWithContentURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        
        self.view = self.avPlayer;
        
    }
    return self;
}




- (void)setFullscreen:(BOOL)fullscreen animated:(BOOL)animated
{
    _fullscreen = fullscreen;
}

@end
