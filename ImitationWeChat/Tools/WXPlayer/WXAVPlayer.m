//
//  WXAVPlayer.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WXAVPlayer.h"

//播放状态
static void *AVPlayerStatusObservationContext = &AVPlayerStatusObservationContext;

//监听播放暂停
static void *AVPlayerRateObservationContext = &AVPlayerRateObservationContext;

//播放资源发生改变
static void *AVPlayerCurrentItemObservationContext = &AVPlayerCurrentItemObservationContext;

//缓冲进度
static void *AVPlayerloadedTimeRangesObservationContext = &AVPlayerloadedTimeRangesObservationContext;

//播放buffer为空
static void *AVPlayerPlaybackBufferEmptyObservationContext = &AVPlayerPlaybackBufferEmptyObservationContext;

//buffer 缓存完成
static void *AVPlayerPlaybackBufferFullObservationContext = &AVPlayerPlaybackBufferFullObservationContext;

//可以正常播放缓存
static void *AVPlayerPlaybackLikelyToKeepUpObservationContext = &AVPlayerPlaybackLikelyToKeepUpObservationContext;


@implementation WXAVPlayer

#pragma mark -
#pragma mark -- get method group


- (WXAVPlayerLoading *)wxAVPlayerLoading
{
    if (!_wxAVPlayerLoading) {
        _wxAVPlayerLoading = [[WXAVPlayerLoading alloc] initWithFrame:self.bounds];
    }
    return _wxAVPlayerLoading;
}

/**
 *  播放器视觉输出
 */
- (AVPlayerLayer *)mAVPlayerLayer
{
    if (!_mAVPlayerLayer) {
        _mAVPlayerLayer = [[AVPlayerLayer alloc] init];
        _mAVPlayerLayer.videoGravity = AVLayerVideoGravityResize;
        _mAVPlayerLayer.frame = self.bounds;

    }
    return _mAVPlayerLayer;
}


- (AVPlayer *)mAVPlayer
{
    if (!_mAVPlayer) {
        _mAVPlayer = [[AVPlayer alloc] init];
        _mAVPlayer.usesExternalPlaybackWhileExternalScreenIsActive = YES;
        [_mAVPlayer addObserver:self
                         forKeyPath:@"currentItem"
                            options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                            context:AVPlayerCurrentItemObservationContext];
    }
    return _mAVPlayer;
}

/**
 *  播放器控制层
 */

- (WXAVPlayerControl *)mAVPlayerControl
{
    if (!_mAVPlayerControl) {
        _mAVPlayerControl = [[WXAVPlayerControl alloc] initWithFrame:self.bounds];
    }
    return _mAVPlayerControl;
}

#pragma mark -
#pragma mark -- set method group

///**
// *  播放器控制层
// */
//- (void)setMPlayerItem:(AVPlayerItem *)mPlayerItem
//{
//    _mPlayerItem = mPlayerItem;
//    
//    //mPlayerItem 准备播放时, 监听AVPlayerItem "status" 属性
//    [self.mPlayerItem addObserver:self
//                       forKeyPath:@"status"
//                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
//                          context:AVPlayerStatusObservationContext];
//    
//    
////    [self.mPlayerItem addObserver:self
////                       forKeyPath:@"playbackBufferEmpty"
////                          options:NSKeyValueObservingOptionNew
////                          context:AVPlayerPlaybackBufferEmptyObservationContext];
////    
////    [self.mPlayerItem addObserver:self
////                       forKeyPath:@"playbackBufferFull"
////                          options:NSKeyValueObservingOptionNew
////                          context:AVPlayerPlaybackBufferFullObservationContext];
////    
////    [self.mPlayerItem addObserver:self
////                       forKeyPath:@"playbackLikelyToKeepUp"
////                          options:NSKeyValueObservingOptionNew
////                          context:AVPlayerPlaybackLikelyToKeepUpObservationContext];
//    
////    //监听缓冲进度
////    [self.mPlayerItem addObserver:self
////                     forKeyPath:@"loadedTimeRanges"
////                        options:NSKeyValueObservingOptionNew
////                        context:AVPlayerloadedTimeRangesObservationContext];
//
//
//    
//    
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"播放控件的样式。默认为WXMovieControlStyleDefault。" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor darkGrayColor];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_button addTarget:self action:@selector(abc) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
//        NSError *error;
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:&error];
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
//        
//        //播放器载体
//        [self.layer addSublayer:self.mAVPlayerLayer];
//        
//        //添加自定义控制层
//        [self addSubview:self.mAVPlayerControl];
    }
    return self;
}

- (void)abc
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"恭喜获得二等奖" delegate:nil cancelButtonTitle:@"晓得了" otherButtonTitles:nil];
    [alert show];
}

- (void)setContentURL:(NSURL *)contentURL
{
    if (! [_contentURL isEqual:contentURL] && contentURL)
    {
        _contentURL = contentURL;

        
        //创建 asset 加载 url 对应资源,创建缓存关键字
        AVURLAsset *asset = [AVURLAsset URLAssetWithURL:_contentURL options:nil];
        
        NSArray *requestedKeys = @[@"playable"];
        
        //加载资源
        [asset loadValuesAsynchronouslyForKeys:requestedKeys completionHandler:
         ^{
             dispatch_async( dispatch_get_main_queue(),
                            ^{
                                //修改avplayer
                                [self prepareToPlayAsset:asset withKeys:requestedKeys];
                            });
         }];

    }
}


/**
 *  加载播放视频
 *
 *  @param asset         播放的资源00
 *  @param requestedKeys 缓存的key
 */
- (void)prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys
{
    //检查音频资源是否加载成功
    for (NSString *thisKey in requestedKeys)
    {
        NSError *error = nil;
        AVKeyValueStatus keyStatus = [asset statusOfValueForKey:thisKey error:&error];
        if (keyStatus == AVKeyValueStatusFailed)
        {
            //加载失败做相应处理
            [self assetFailedToPrepareForPlayback:error];
            
            return;
        }
    }
    
    /*  音频资源加载成功
     *  使用AVAsset播放属性检测asset是否可以播放
     */
    if (!asset.playable) {
        
        //生成错误信息
        NSError *assetCannotBePlayedError = [NSError errorWithDomain:@"Item cannot be played" code:0 userInfo:nil];
        
        //加载失败做相应处理
        [self assetFailedToPrepareForPlayback:assetCannotBePlayedError];
        
        return;
        
    }
    
    //使用正确加载的asset资源创建 AVPlayerItem 实例
    self.mPlayerItem = [AVPlayerItem playerItemWithAsset:asset];

    //确保播放新的资源
    if (self.mAVPlayer.currentItem != self.mPlayerItem)
    {
        //替换新的播放资源
        [self.mAVPlayer replaceCurrentItemWithPlayerItem:self.mPlayerItem];
        
        [self.mAVPlayerLayer setPlayer:self.mAVPlayer];
    }
}


/**
 *  加载asset发生错误
 *
 *  @param error 错误信息
 */
-(void)assetFailedToPrepareForPlayback:(NSError *)error{
    NSLog(@"assetFailedToPrepareForPlayback=====>>%@", [error description]);
}



/**
 *  播放结束
 *
 *  @param notification 消息
 */
- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    
}


/**
 *  缓冲播放完,AVPlayer自动暂停
 *
 *  @param notification 消息
 */
- (void)playerItemPlaybackStalled:(NSNotification *)notification
{
    
}



/**
 *  AVPlayerItem "status" 发生改变,更新相关UI
 *  AVPlayerItem "currentItem" 发生改变
 *  AVPlayerItem "rate" 发生改变
 *
 *  @param path    监听属性名称
 *  @param object  监听的对象
 *  @param change  属性的变化
 *  @param context 监听属性的key
 */
- (void)observeValueForKeyPath:(NSString*) path
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
    
    //status 发生改变
    if (context == AVPlayerStatusObservationContext)
    {
        
        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status)
        {
                
                //未知原因无法正常播放
            case AVPlayerItemStatusUnknown:
            {
                
            }
                break;
                
            case AVPlayerItemStatusReadyToPlay:
            {
            }
                break;
                
            case AVPlayerItemStatusFailed:
            {
                
                AVPlayerItem *playerItem = (AVPlayerItem *)object;
                [self assetFailedToPrepareForPlayback:playerItem.error];
            }
                
                break;
        }
        
    }
    
    //rate 发生改变
    else if (context == AVPlayerRateObservationContext)
    {
        
    }
    
    //currentItem 发生改变
    else if (context == AVPlayerCurrentItemObservationContext)
    {
    
    }
    
    else if (context == AVPlayerloadedTimeRangesObservationContext)
    {

//        //缓冲进度
//        NSTimeInterval timeInterval = [self availableDuration];
//        CGFloat totalDuration = CMTimeGetSeconds(self.mPlayerItem.duration);
//        
//        CGFloat progress = self.videoControl.bottomBar.progressView.cacheProgressView.progress;
//        
//        if (isfinite(totalDuration)) {
//            if (!isnan(totalDuration)) {
//                if (!isnan(timeInterval)) {
//                    if (self.mPlayerItem.isPlaybackLikelyToKeepUp) {
//                        self.videoControl.bottomBar.progressView.cacheProgressView.progress = MAX(timeInterval / totalDuration, progress);
//                    }
//                    else
//                    {
//                        self.videoControl.bottomBar.progressView.cacheProgressView.progress = timeInterval / totalDuration;
//                    }
//                    
//                }
//                
//            }
//            
//        }
        
    }
    
    //没有缓存可以播放
    else if (context == AVPlayerPlaybackBufferEmptyObservationContext)
    {
        NSLog(@"AVPlayerPlaybackBufferEmptyObservationContext %@", change);
//        AVPlayerItem *playerItem = (AVPlayerItem *)object;
//        if (playerItem.isPlaybackBufferEmpty) {
//            if (self.isPlaying) {
//                [self.videoControl startLoading];
//                [self.mAVPlayer pause];
//            }
//            
//        }
    }
    
    
    else if (context == AVPlayerPlaybackBufferFullObservationContext)
    {
        LWLog(@"AVPlayerPlaybackBufferFullObservationContext %@", change);
    }
    
    //有缓存可以播放了
    else if (context == AVPlayerPlaybackLikelyToKeepUpObservationContext)
    {

    }
    
    else
    {
        [super observeValueForKeyPath:path ofObject:object change:change context:context];
    }
    
}

/**
 *  计算缓冲进度0
 *
 *  @return 返回缓冲的时间总长
 */
- (NSTimeInterval)availableDuration
{
    NSArray *loadedTimeRanges = [[self.mAVPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    NSTimeInterval result = 0.0;
    if (!CMTimeRangeEqual(timeRange, kCMTimeRangeZero)) {
        result = CMTimeGetSeconds(CMTimeAdd(timeRange.start, timeRange.duration));// 计算缓冲总进度
    }
    NSLog(@"%f", result);
    
    return result;
}


- (void)play
{
    if (self.mAVPlayer.currentItem) {
        [self.mAVPlayer play];
    }
}

- (void)pause
{
    if (self.mAVPlayer.currentItem) {
        [self.mAVPlayer pause];
    }
}

/**
 *  静音
 */
- (void)audioMute
{
    if (self.mPlayerItem) {
        NSArray *audioTracks = [self.mPlayerItem.asset tracksWithMediaType:AVMediaTypeAudio];
        NSMutableArray * allAudioParams = [NSMutableArray array];
        for (AVAssetTrack *track in audioTracks) {
            AVMutableAudioMixInputParameters *audioInputParams =[AVMutableAudioMixInputParameters audioMixInputParameters];
            [audioInputParams setVolume:0.0 atTime:kCMTimeZero ];
            [audioInputParams setTrackID:[track trackID]];
            [allAudioParams addObject:audioInputParams];
        }
        AVMutableAudioMix * audioZeroMix = [AVMutableAudioMix audioMix];
        [audioZeroMix setInputParameters:allAudioParams];
        
        [self.mPlayerItem setAudioMix:audioZeroMix];
    }
}


/**
 *  恢复声音
 */
- (void)audioNormal
{
    [self.mPlayerItem setAudioMix:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button.frame = CGRectMake(0, 100, CGRectGetMaxX(self.bounds), 60);
    self.button.centerY = CGRectGetMaxY(self.bounds)/2;
}

@end
