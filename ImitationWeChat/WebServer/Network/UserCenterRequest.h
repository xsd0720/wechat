//
//  UserCenterRequest.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpTool.h"

#import "ResponseSuccessBlocks.h"

@interface UserCenterRequest : NSObject

/**
 *  登录
 *
 *  Method          POST
 *  @param mobile   手机号
 *  @param password 密码
 *  @param success  请求成功
 *  @param failure  请求失败
 */
+ (void)loginWithMobile:(NSString *)mobile
               password:(NSString *)password
                success:(LoginSuccessBlock)success
                failure:(LWHttpToolFailBlock)failure;

/**
 *  注册账号
 *
 *  Method          POST
 *  @param username 用户名
 *  @param mobile   手机号
 *  @param password 密码
 *  @param success  请求成功
 *  @param failure  请求失败
 */
+ (void)registerWithUserName:(NSString *)username
                      mobile:(NSString *)mobile
                    password:(NSString *)password
                     success:(LoginSuccessBlock)success
                     failure:(LWHttpToolFailBlock)failure;


/**
 *  发送验证码
 */
+ (void)requestsnsWithMobile:(NSString *)mobile
                      opcode:(int)opcode
                     success:(RequestsnsSuccessBlock)success
                     failure:(LWHttpToolFailBlock)failure;


//验证验证码
+ (void)checkvcodeWithMobile:(NSString *)mobile
                       vcode:(NSString *)vcode
                     success:(CheckvcodesSuccessBlock)success
                     failure:(LWHttpToolFailBlock)failurel;

@end
