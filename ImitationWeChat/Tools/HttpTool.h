//
//  HttpTool.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络状况监测枚举
typedef NS_ENUM(NSInteger, LWNetworkReachableStatus) {
    //未知
    LWNetworkReachableStatusUnknown       =-1,
    
    //无网络
    LWNetworkReachableStatusNotReachable  =0,
    
    //无线网络
    LWNetworkReachableStatusViaWWAN       =1,
    
    //Wifi
    LWNetworkReachableStatusViaWifi       =2,
};

typedef NS_ENUM(NSInteger, LWBannerType) {
    
    //无状态
    LWBannerType_null  = 0,
    //商品详情
    LWBannerType_goods  = 1,
    //视频
    LWBannerType_media = 2,
    //是自媒体人
    LWBannerType_media_rofile = 3,
    //店铺
    LWBannerType_shop = 4,
    //评论(自媒体人回复了评论)
    LWBannerType_comment = 5,
    //聚合
    LWBannerType_goods_and_media = 6,
    //html
    LWBannerType_html = 7,
    
    //评论
    LWBannerType_reply = 8,
    
    //9为评论被赞
    LWBannerType_agree = 9,
    
    //10为QA里面被@
    LWBannerType_be_at = 10,
    
    //11
    LWBannerType_official = 11
};


/**
 *  七牛图片上传成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^LWQiniuUploadSuccessBlock)(NSDictionary *responsObject);

/**
 *  请求成功回调Block
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^LWHttpToolSuccessBlock)(NSDictionary *responsObject);

/**
 *  请求失败回调Block
 *
 *  @param error 返回请求结果的错误代码
 */
typedef void(^LWHttpToolFailBlock)(NSError *error);


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
    success:(LWHttpToolSuccessBlock)success
    failure:(LWHttpToolFailBlock)failure;


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
     success:(LWHttpToolSuccessBlock)success
     failure:(LWHttpToolFailBlock)failure;



/**
 *  开始监听网络状态
 */
+ (void)startInternetListen;


/**
 *  获取网络状态
 */
+ (NSString *)internetStatus;

@end

