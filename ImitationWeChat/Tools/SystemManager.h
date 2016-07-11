//
//  SystemManager.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemManager : NSObject

/**
 *  获取设备UUID
 *
 *  @return 返回设备的UUID
 */
+(NSString *)UUID;



/**
 *  获取当前系统时间(utc)
 *
 *  @return 当前系统时间(utc)
 */
+(NSString *)timeNow;

/**
 *  设置流量播放通知状态
 *
 *  @param flowPlayNotification 状态
 */
+ (void)setFlowPlayNotification:(BOOL)flowPlayNotification;


/**
 *  获取流量播放通知状态
 *
 *  @return 状态
 */
+ (BOOL)flowPlayNotification;

/**
 *  设置自动播放状态
 *
 *  @param flowPlayNotification 状态
 */
+ (void)setAutoPlayNotification:(BOOL)autoPlayNotification;


/**
 *  获取自动播放状态
 *
 *  @return 状态
 */
+ (BOOL)autoPlayNotification;

/**
 *  设置推送通知状态
 *
 *  @param remoteNotification 状态
 */
+ (void)setRemoteNotification:(BOOL)remoteNotification;


/**
 *  获取推送通知状态
 *
 *  @return 状态
 */
+ (BOOL)remoteNotification;


/**
 *  相机权限
 */
+ (BOOL)isCanVisitCamera;


/**
 *  相册权限
 */
+ (BOOL)isCanVisitAssetsLibrary;


/**
 *  获取推送通知状态
 */
+ (BOOL)getRemoteStatus;


/**
 *  验证敏感词(YES：包含， NO：不包含)
 */
+ (BOOL)validateSensitiveWord:(NSString *)vString;

@end
