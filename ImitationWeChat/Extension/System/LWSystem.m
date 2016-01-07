//
//  LWSystem.m
//  lilworld
//
//  Created by xwmedia01 on 15/7/31.
//  Copyright (c) 2015年 zp. All rights reserved.
//

#import "LWSystem.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

//登录后access_token
#define LWACCESSTOKEN        @"access_token"

static  NSString *flowPlayNotificationStatus = @"flowPlayNotificationStatus";
static  NSString *remoteNotificationStatus = @"remoteNotificationStatus";

@implementation LWSystem


/**
 *  获取设备UUID
 *
 *  @return 返回设备的UUID
 */
+(NSString *)UUID{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

/**
 *  获取当前系统时间(utc)
 *
 *  @return 当前系统时间(utc)
 */
+(NSString *)timeNow{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm:ss MM-dd-yyyy Z"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    return currentDateStr;
}

/**
 *  设置流量播放通知状态
 *
 *  @param flowPlayNotification 状态
 */
+ (void)setFlowPlayNotification:(BOOL)flowPlayNotification
{
    [[NSUserDefaults standardUserDefaults] setBool:flowPlayNotification forKey:flowPlayNotificationStatus];
}


/**
 *  获取流量播放通知状态
 *
 *  @return 状态
 */
+ (BOOL)flowPlayNotification
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:flowPlayNotificationStatus]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:flowPlayNotificationStatus];
    }
    return NO;
}


///**
// *  设置推送通知状态
// *
// *  @param remoteNotificationStatus 状态
// */
//+ (void)setRemoteNotification:(BOOL)remoteNotification
//{
//    if ([LWSystem getRemoteStatus]) {
//        
//        //YES.关闭推送 NO.开启推送。
//        [GeTuiSdk setPushModeForOff:!remoteNotification];
//        
//        //本地存储推送状态
//        [[NSUserDefaults standardUserDefaults] setBool:remoteNotification forKey:remoteNotificationStatus];
//    }
//}
//
//
//
///**
// *  获取推送通知状态
// *
// *  @return 状态
// */
//+ (BOOL)remoteNotification
//{
//    if ([LWSystem getRemoteStatus]) {
//        if ([[NSUserDefaults standardUserDefaults] valueForKey:remoteNotificationStatus]) {
//            return [[NSUserDefaults standardUserDefaults] boolForKey:remoteNotificationStatus];
//        }
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:remoteNotificationStatus];
//        //YES.关闭推送 NO.开启推送。
//        [GeTuiSdk setPushModeForOff:NO];
//        return YES;
//    }
//    //YES.关闭推送 NO.开启推送。
//    [GeTuiSdk setPushModeForOff:YES];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:remoteNotificationStatus];
//    return NO;
//}


/**
 *  相机权限
 */
+ (BOOL)isCanVisitCamera
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iphone的”设置-隐私-相机“中允许访问相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }

    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //设备不支持相机
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"当前设备不支持相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}


/**
 *  相册权限
 */
+ (BOOL)isCanVisitAssetsLibrary
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==AVAuthorizationStatusDenied){
        //无权限
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相册" message:@"请在iphone的”设置-隐私-照片“中允许访问相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
        return YES;
}


///**
// *  获取推送通知状态(YES:允许，NO:不允许)
// */
//+ (BOOL)getRemoteStatus
//{
//    if(IOS_8)
//    {
//        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        if (UIUserNotificationTypeNone != setting.types) {
//            return YES;
//        }
//        return NO;
//    }
//    else
//    {
//        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//        int typeBadge = (type & UIRemoteNotificationTypeBadge);
//        int typeSound = (type & UIRemoteNotificationTypeSound);
//        int typeAlert = (type & UIRemoteNotificationTypeAlert);
//        BOOL ret =  typeBadge || typeSound || typeAlert;
//        
//        return ret;
//    }
//}

/**
 *  验证敏感词(YES：包含， NO：不包含)
 */
+ (BOOL)validateSensitiveWord:(NSString *)vString
{
    //读取data数据
    NSData *dataKeywords = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"keywords.txt" ofType:nil]];
    
    //转换字符串
    NSString *dataKeywordsString = [[NSString alloc] initWithData:dataKeywords encoding:NSUTF8StringEncoding];
    
    dataKeywordsString = [dataKeywordsString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    //转换数组
    NSArray *keywordsArray = [dataKeywordsString componentsSeparatedByString:@"\n"];
    
    //输入文字去空格
    vString = [vString stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    //验证是否包含敏感词
    for (NSString *obj in keywordsArray) {
        if ([obj isEqualToString:vString]) {
            return YES;
        }
    }
    return NO;
}

@end
