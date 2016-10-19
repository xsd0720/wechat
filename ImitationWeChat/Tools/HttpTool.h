//
//  HttpTool.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络状况监测枚举
typedef NS_ENUM(NSInteger, NetworkReachableStatus) {
    //未知
    NetworkReachableStatusUnknown       = 1 << 0,
    
    //无网络
    NetworkReachableStatusNotReachable  = 1 << 1,
    
    //无线网络
    NetworkReachableStatusViaWWAN       = 1 << 2,
    
    //Wifi
    NetworkReachableStatusViaWifi       = 1 << 3,
};

/**
 *  七牛图片上传成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^QiniuUploadSuccessBlock)(NSDictionary *responsObject);

/**
 *  请求成功回调Block
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^HttpToolSuccessBlock)(NSDictionary *responsObject);

/**
 *  请求失败回调Block
 *
 *  @param error 返回请求结果的错误代码
 */
typedef void(^HttpToolFailBlock)(NSError *error);


@interface HttpTool : NSObject


/**
 *  单例
 *
 *  @return 单例对象
 */
+ (HttpTool *)sharedInstance;


/**
 *  GET 请求
 *
 *  @param URLString  请求地址URL
 *  @param parameters 附带参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(HttpToolSuccessBlock)success
    failure:(HttpToolFailBlock)failure;


/**
 *  POST 请求
 *
 *  @param URLString  请求地址URL
 *  @param parameters 附带参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(HttpToolSuccessBlock)success
     failure:(HttpToolFailBlock)failure;



/**
 *  开始监听网络状态
 */
+ (void)startInternetListen;


/**
 *  获取网络状态
 */
+ (NSString *)internetStatus;

@end

