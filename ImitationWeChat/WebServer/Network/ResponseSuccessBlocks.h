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

@end

