//
//  WXAVPlayerConfig.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/8/2.
//  Copyright © 2016年 wany. All rights reserved.
//

#ifndef WXAVPlayerConfig_h
#define WXAVPlayerConfig_h

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
