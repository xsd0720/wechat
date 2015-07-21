//
//  Configuration.h
//  ImitationWeChat
//
//  Created by wang on 14-9-24.
//  Copyright (c) 2014年 SDL. All rights reserved.
//

#ifndef ImitationWeChat_Configuration_h
#define ImitationWeChat_Configuration_h
#define NAVGATIONBAR_BARTINTCOLOR                       RGBCOLOR(231, 231,231)
//#define NAVGATIONBAR_BARTINTCOLOR                       RGBCOLOR(82, 199,216)
#define VIEW_BGCOLOR                                     RGBCOLOR(236, 234, 241)
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
//判断是否是IOS7
#define IOS7 (BOOL)([[UIDevice currentDevice] systemVersion].intValue>=7)
#define IOS8 (BOOL)([[UIDevice currentDevice] systemVersion].intValue>=8)


#define CustomTabarHeight       49
// iOS系统版本
#define SYSTEM_VERSION    [[[UIDevice currentDevice] systemVersion] doubleValue]
// 标准系统状态栏高度
#define SYS_STATUSBAR_HEIGHT                        20
// 热点栏高度
#define HOTSPOT_STATUSBAR_HEIGHT            20
// 导航栏（UINavigationController.UINavigationBar）高度
#define NAVIGATIONBAR_HEIGHT                44
// 工具栏（UINavigationController.UIToolbar）高度
#define TOOLBAR_HEIGHT                              44
// 标签栏（UITabBarController.UITabBar）高度
#define TABBAR_HEIGHT                              44
// APP_STATUSBAR_HEIGHT=SYS_STATUSBAR_HEIGHT+[HOTSPOT_STATUSBAR_HEIGHT]
#define APP_STATUSBAR_HEIGHT                (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
// 根据APP_STATUSBAR_HEIGHT判断是否存在热点栏
#define IS_HOTSPOT_CONNECTED                (APP_STATUSBAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)
// 无热点栏时，标准系统状态栏高度+导航栏高度
#define NORMAL_STATUS_AND_NAV_BAR_HEIGHT    (SYS_STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT)
// 实时系统状态栏高度+导航栏高度，如有热点栏，其高度包含在APP_STATUSBAR_HEIGHT中。
#define STATUS_AND_NAV_BAR_HEIGHT                    (APP_STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT)

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//获取屏幕宽高（没有有状态栏的）
#define MRScreenWidth  CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight CGRectGetHeight([UIScreen mainScreen].applicationFrame)
//#define YHBViewGeight(view)  CGRectGetHeight()
//获取沙盒路径
#define DocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//缓存路径
#define Cache  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//色块 设置颜色(UIColorFromRGB(0xCCFFFF))

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//RGB 数值设置颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//获取指定view高度
#define getViewHeight(v) (v.frame.size.height+v.frame.origin.y)
#define getViewWidth(v) (v.frame.size.width+v.frame.origin.x)

//获取指定view高度
#define viewHeight(v) v.frame.size.height
#define viewWidth(v) v.frame.size.width
//获取window
#define getWindow [[UIApplication sharedApplication] keyWindow]

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

#define GAODEAPPKEY   @"768601178a8ec29d303e4d1f830e23df"


#pragma mark - url



//about
#define ABOUT_URL   @"http://sdl.idcjj.cn/api/html/about.php"
//server
#define SERVER_URL  @"http://sdl.idcjj.cn/api/html/infor.php"

//regAgree
#define REGAGREE_URL    @"http://sdl.idcjj.cn/api/html/regInfor.php"




#define LOGINTYPE    @"loginType"
#define SDLLOGIN    @"sdlLogin"
#define SANFANGLOGIN  @"sanfangLogin"
#endif
