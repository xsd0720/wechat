//
//  AppDelegate.m
//  ImitationWeChat
//
//  Created by wany on 14/12/12.
//  Copyright (c) 2014年 wany. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingViewController.h"
#import "MyTabBarController.h"
#import "SendTimeLineViewController.h"
#import "MyNavViewController.h"
#import "TopWindow.h"
#import <iflyMSC/iflyMSC.h>
#import "BottlerViewController.h"
#import "UserCenterRequest.h"
#import "WelcomeViewController.h"
#import "PreLoadTool.h"
#import "LocalManager.h"
#define APPID_VALUE           @"569364d0"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //加载讯飞语音加载讯飞语音加载讯飞语音
//    [self loadXunFei];
    
    //加载windows rootViewController
    [self loadWindow];
    
//    [TopWindow show];

    
    return YES;
}





- (void)loginIn
{
    self.window.rootViewController = [[MyTabBarController alloc] init];
}

- (void)logout
{
    self.window.rootViewController = [[WelcomeViewController alloc] init];
}

-(void)loadWindow{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    
//    self.window.rootViewController = [[MyTabBarController alloc] init];
    
    if ([LocalManager sharedManager].access_token)
    {
         self.window.rootViewController = [[MyTabBarController alloc] init];
    }
    else
    {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[PreLoadTool sharedInstance] readData];
        });
        self.window.rootViewController = [[WelcomeViewController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
- (void)loadXunFei
{
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    //输出版本号
    NSLog(@"IFlyMSC version:%@",[IFlySetting getVersion]);
    
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
#pragma message "'createUtility' should be call before any business using."
    [IFlySpeechUtility createUtility:initString];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
