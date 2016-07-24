//
//  WXAVPlayer.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WXAVPlayerControl.h"
@interface WXAVPlayer : UIView

@property (nonatomic, strong) UIView *playblastView;
@property (nonatomic, strong) UIImageView *playblastImageView;
@property (nonatomic, strong) UIButton *playblastViewPlayButton;

/**
 *  播放器视觉输出
 */
@property (nonatomic, strong) AVPlayerLayer     *mAVPlayerLayer;

/**
 *  播放器
 */
@property (nonatomic, strong) AVPlayer          *mAVPlayer;

/**
 *  播放项
 */
@property (strong) AVPlayerItem          *mPlayerItem;


/**
 *  自定义控制层
 */
@property (nonatomic, strong) WXAVPlayerControl *mAVPlayerControl;

/**
 *  播放URL
 */
@property (nonatomic, strong) NSURL             *contentURL;


- (void)play;

- (void)pause;

@end
