//
//  WXMoviePlayerViewController.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/8/2.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMoviePlayerController.h"
@interface WXMoviePlayerViewController : UIViewController

- (instancetype)initWithContentURL:(NSURL *)contentURL;

@property (nonatomic, readonly) WXMoviePlayerController *moviePlayer;

@end

// -----------------------------------------------------------------------------
// UIViewController Additions
// Additions to present a fullscreen movie player as a modal view controller using the standard movie player transition.

@interface UIViewController (WXMoviePlayerViewController)

- (void)presentMoviePlayerViewControllerAnimated:(MPMoviePlayerViewController *)moviePlayerViewController NS_DEPRECATED_IOS(3_2, 9_0, "Use AVPlayerViewController in AVKit.") __TVOS_PROHIBITED;
- (void)dismissMoviePlayerViewControllerAnimated NS_DEPRECATED_IOS(3_2, 9_0, "Use AVPlayerViewController in AVKit.") __TVOS_PROHIBITED;

@end