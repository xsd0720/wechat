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
                failure:(HttpToolFailBlock)failure;

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
                wechatNumber:(NSString *)wechatNumber
                    password:(NSString *)password
                     success:(LoginSuccessBlock)success
                     failure:(HttpToolFailBlock)failure;


/**
 *  发送验证码
 */
+ (void)requestsnsWithMobile:(NSString *)mobile
                      opcode:(int)opcode
                     success:(RequestsnsSuccessBlock)success
                     failure:(HttpToolFailBlock)failure;


//验证验证码
+ (void)checkvcodeWithMobile:(NSString *)mobile
                       vcode:(NSString *)vcode
                     success:(CheckvcodesSuccessBlock)success
                     failure:(HttpToolFailBlock)failurel;


/**
 *  账号登出
 *
 *  @param mobile       手机号
 *  @param success      请求成功
 *  @param failure      请求失败
 */
+ (void)logoutSuccess:(LogoutSuccessBlock)success
              failure:(HttpToolFailBlock)failure;




/**
 *  找回密码
 *
 *  Method         POST
 *  @param mobile  手机号
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+(void)forgetWithMobile:(NSString *)mobile
                success:(ForgetSuccessBlock)success
                failure:(HttpToolFailBlock)failure;





/**
 *  个人简介
 *
 *  Method:             GET
 *  @param success      请求成功
 *  @param failure      请求失败
 */
+ (void)profileSuccess:(ProfileSuccessBlock)success
               failure:(HttpToolFailBlock)failure;





/**
 *  更新个人简介
 *
 *  @param password     新密码
 *  @param success      请求成功
 *  @param failure      请求失败
 */
+ (void)updateWithPassword:(NSString *)password
                   success:(LoginSuccessBlock)success
                   failure:(HttpToolFailBlock)failure;




/**
 *  手机号码修改
 *
 *  @param newmobile  新手机号
 *  @param success    请求成功
 *  @param failure    请求失败
 */
+ (void)updatemobileWithNewmobile:(NSString *)newmobile
                          success:(UpdatemobileSuccessBlock)success
                          failure:(HttpToolFailBlock)failure;






/**
 *  用户名修改
 *
 *  @param newusername 新用户名
 *  @param success     请求成功
 *  @param failure     请求失败
 */
+ (void)updateusernameWithNewusername:(NSString *)newusername
                              success:(UpdateusernameSuccessBlock)success
                              failure:(HttpToolFailBlock)failure;

@end
