//
//  WXMovieManager.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/27.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WXMoviePlayerController.h"


@interface WXMoviePlayerController()

@end


@implementation WXMoviePlayerController

- (instancetype)initWithContentURL:(NSURL *)url
{
    self = [super init];
    if (self) {
    
    }
    return self;
}


- (void)setFullscreen:(BOOL)fullscreen animated:(BOOL)animated
{
    _fullscreen = fullscreen;
}

@end
