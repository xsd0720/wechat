//
//  UserCenterRequest.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "UserCenterRequest.h"
#import "UserCenterRequestParams.h"


@implementation UserCenterRequest

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
                failure:(LWHttpToolFailBlock)failure
{
    //登录参数模型
    LoginParam *loginParam = [[LoginParam alloc] init];
    
    //手机号
    loginParam.mobile = mobile;
    
    //密码(md5加密)
    loginParam.password = [password md5HexDigest];
    
    //设备uuid
    //    loginParam.uuid = [LWSystem UUID];
    
    //Post 请求
    [HttpTool POST:LoginURL
          parameters:[loginParam paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(responsObject){
                     NSLog(@"%@", responsObject);
                     //登录返回数据模型
                     LoginResponse *loginResponse = [[LoginResponse alloc] initWithDictionary:(NSDictionary *)responsObject error:nil];
                     
//                     [[LWLocalManager sharedManager]loginWithLoginResponse:loginResponse];
                     
                     
                     success(loginResponse);
                 }
                 
             }
             failure:^(NSError *error) {
                 
                 /**
                  *  失败回调
                  *  @param error 错误代码
                  */
                 if(error){
                     failure(error);
                 }
             }];

}


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
                     failure:(LWHttpToolFailBlock)failure{
    
    //注册参数模型
    RegisterParam *regisParam = [[RegisterParam alloc] init];
    
    //用户名
    regisParam.username = username;
    
    //手机号
    regisParam.mobile = mobile;
    
    //密码(md5加密)
    regisParam.password = [password md5HexDigest];
    
    //Post 请求
    [HttpTool POST:RegisURL
          parameters:[regisParam paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     //注册返回数据模型
                     LoginResponse *registerResponse = [[LoginResponse alloc] initWithDictionary:responsObject error:nil];

                     success(registerResponse);
                 }
                 
             }
             failure:^(NSError *error) {
                 
                 /**
                  *  失败回调
                  *  @param error 错误代码
                  */
                 if(failure){
                     failure(error);
                 }
             }];
    
    
}

/**
 *  发送验证码
 */
+ (void)requestsnsWithMobile:(NSString *)mobile
                      opcode:(int)opcode
                     success:(RequestsnsSuccessBlock)success
                     failure:(LWHttpToolFailBlock)failure{
    
    RequestsnsParm *snsParm = [[RequestsnsParm alloc] init];
    
    //手机号
    snsParm.mobile = mobile;
    
    //POST 请求
    [HttpTool POST:RequestsnsURL
          parameters:[snsParm paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     RequestsnsResponse *snsResponse = [[RequestsnsResponse alloc] initWithDictionary:responsObject error:nil];
                     
                     success(snsResponse);
                 }
                 
             }
             failure:^(NSError *error) {
                 
                 /**
                  *  失败回调
                  *  @param error 错误代码
                  */
                 if(failure){
                     failure(error);
                 }
             }];
}

+ (void)checkvcodeWithMobile:(NSString *)mobile
                       vcode:(NSString *)vcode
                     success:(CheckvcodesSuccessBlock)success
                     failure:(LWHttpToolFailBlock)failure{
    CheckvcodeParm *checkVCode = [[CheckvcodeParm alloc] init];
    
    //手机号
    checkVCode.mobile = mobile;
    checkVCode.vcode = vcode;
    
    //POST 请求
    [HttpTool POST:CheckvcodeURL
          parameters:[checkVCode paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     CheckvcodeResponse *checkResponse = [[CheckvcodeResponse alloc] initWithDictionary:responsObject error:nil];
                     
                     success(checkResponse);
                 }
                 
             }
             failure:^(NSError *error) {
                 
                 /**
                  *  失败回调
                  *  @param error 错误代码
                  */
                 if(failure){
                     failure(error);
                 }
             }];
}

@end
