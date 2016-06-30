//
//  ResponseSuccessBlocks.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserCenterResponseModels.h"

@interface ResponseSuccessBlocks : NSObject

/**
 *  登录-请求成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^LoginSuccessBlock)(LoginResponse *responsObject);

/**
 *  发送验证码成功block
 */
typedef void(^RequestsnsSuccessBlock)(RequestsnsResponse *responsObject);

/**
 *  验证验证码
 */
typedef void(^CheckvcodesSuccessBlock)(CheckvcodeResponse *responsObject);


/**
 *  登出-请求成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^LogoutSuccessBlock)(LogoutResponse *responsObject);


/**
 *  找回密码-请求成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^ForgetSuccessBlock)(ForgetResponse *responsObject);

/**
 *  个人简介-请求成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^ProfileSuccessBlock)(ProfileResponse *responsObject);


/**
 *  个人简介更新-请求成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^UpdateSuccessBlock)(UpdateResponse *responsObject);


/**
 *  手机号修改-请求成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^UpdatemobileSuccessBlock)(UpdatemobileResponse *responsObject);


/**
 *  用户名修改-请求成功回调
 *
 *  @param responsObject 返回请求的数据结果
 */
typedef void(^UpdateusernameSuccessBlock)(UpdateusernameResponse *responsObject);


@end

