//
//  WXAVPlayerLoading.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/26.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WXAVPlayerLoading.h"
#import "CircleProgressView.h"

@interface WXAVPlayerLoading()

@property (nonatomic, strong) UIView *playblastView;
@property (nonatomic, strong) UIImageView *playblastImageView;
@property (nonatomic, strong) UIButton *playblastViewPlayButton;

@property (nonatomic, strong) CircleProgressView *cicleProgressView;

@end

@implementation WXAVPlayerLoading


- (CircleProgressView *)cicleProgressView
{
    if (!_cicleProgressView) {
        _cicleProgressView = [[CircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _cicleProgressView.center = self.center;
        [self addSubview:_cicleProgressView];
        _cicleProgressView.progress = 0;
    }
    return _cicleProgressView;
}

- (UIButton *)playblastViewPlayButton
{
    if (!_playblastViewPlayButton) {
        _playblastViewPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playblastViewPlayButton setImage:[UIImage imageNamed:@"abcdef"] forState:UIControlStateNormal];
        _playblastViewPlayButton.frame = self.bounds;
        [_playblastViewPlayButton addTarget:self action:@selector(readyPlay) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _playblastViewPlayButton;
}

- (UIImageView *)playblastImageView
{
    if (!_playblastImageView) {
        _playblastImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _playblastImageView;
}


- (UIView *)playblastView{
    if (!_playblastView) {
        _playblastView = [[UIView alloc] initWithFrame:self.bounds];
        [_playblastView addSubview:self.playblastImageView];
        [_playblastView addSubview:self.playblastViewPlayButton];
    }
    return _playblastView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.playblastView];
    }
    return self;
}

- (void)readyPlay
{
    
//  _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(abc) userInfo:nil repeats:YES];
    
}

//- (void)abc
//{
//    if (self.cicleProgressView.progress >1) {
//        [_timer invalidate];
//    }
//    self.cicleProgressView.progress +=0.1;
//}


@end
