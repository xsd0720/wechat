//
//  WXAVPlayerControl.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WXAVPlayerControl.h"


@interface WXAVPlayerControl()

//顶
@property (nonatomic, strong) WXAVPlayerControlTopBar *topBar;

//底
@property (nonatomic, strong) WXAVPlayerControlBottomBar *bottomBar;

//中
@property (nonatomic, strong) WXAVPlayerControlMainBar *mainBar;

@end

@implementation WXAVPlayerControl


/**
 * top show bar(eg:video title, backbutton.....)
 */
- (WXAVPlayerControlTopBar *)topBar
{
    if (!_topBar) {
        _topBar = [[WXAVPlayerControlTopBar alloc] init];
        _topBar.backgroundColor = [UIColor cyanColor];
        [self addSubview:_topBar];
    }
    return _topBar;
}

/**
 *  bottom show bar(eg:timeprogress,videolayer fullscreen...)
 */
- (WXAVPlayerControlBottomBar *)bottomBar
{
    if (!_bottomBar) {
        _bottomBar = [[WXAVPlayerControlBottomBar alloc] init];
        _bottomBar.backgroundColor = [UIColor greenColor];
        [self addSubview:_bottomBar];
    }
    return _bottomBar;
}

/**
 *  main show bar(eg:playpausebutton...)
 */
- (WXAVPlayerControlMainBar *)mainBar
{
    if (!_mainBar) {
        _mainBar = [[WXAVPlayerControlMainBar alloc] init];
        [self addSubview:_mainBar];
    }
    return _mainBar;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
