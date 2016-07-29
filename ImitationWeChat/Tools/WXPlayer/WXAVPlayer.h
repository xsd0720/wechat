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
#import "WXAVPlayerLoading.h"
@interface WXAVPlayer : UIView

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
@property (nonatomic, strong) AVPlayerItem          *mPlayerItem;


/**
 *  自定义控制层
 */
@property (nonatomic, strong) WXAVPlayerControl *mAVPlayerControl;


/**
 *
 */
@property (nonatomic, strong) WXAVPlayerLoading *wxAVPlayerLoading;

/**
 *  播放URL
 */
@property (nonatomic, strong) NSURL             *contentURL;


- (void)play;

- (void)pause;

- (void)audioMute;

- (void)audioNormal;

@end
