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
    NetworkReachableStatusUnknown       =-1,
    
    //无网络
    NetworkReachableStatusNotReachable  =0,
    
    //无线网络
    NetworkReachableStatusViaWWAN       =1,
    
    //Wifi
    NetworkReachableStatusViaWifi       =2,
};

typedef NS_ENUM(NSInteger, BannerType) {
    
    //无状态
    BannerType_null  = 0,
    //商品详情
    BannerType_goods  = 1,
    //视频
    BannerType_media = 2,
    //是自媒体人
    BannerType_media_rofile = 3,
    //店铺
    BannerType_shop = 4,
    //评论(自媒体人回复了评论)
    BannerType_comment = 5,
    //聚合
    BannerType_goods_and_media = 6,
    //html
    BannerType_html = 7,
    
    //评论
    BannerType_reply = 8,
    
    //9为评论被赞
    BannerType_agree = 9,
    
    //10为QA里面被@
    BannerType_be_at = 10,
    
    //11
    BannerType_official = 11
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

