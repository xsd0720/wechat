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
                failure:(HttpToolFailBlock)failure
{
    //登录参数模型
    LoginParam *loginParam = [[LoginParam alloc] init];
    
    //手机号
    loginParam.mobile = mobile;
    
    //密码(md5加密)
    loginParam.password = [password md5HexDigest];
    
    //设备uuid
    //    loginParam.uuid = [System UUID];
    
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
                     
                     [[LocalManager sharedManager]loginWithLoginResponse:loginResponse];
                     
                     
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
                wechatNumber:(NSString *)wechatNumber
                    password:(NSString *)password
                     success:(LoginSuccessBlock)success
                     failure:(HttpToolFailBlock)failure{
    
    //注册参数模型
    RegisterParam *regisParam = [[RegisterParam alloc] init];
    
    //用户名
    regisParam.username = username;
    
    //手机号
    regisParam.mobile = mobile;
    
    //密码(md5加密)
    regisParam.password = [password md5HexDigest];
    
    regisParam.wechatnumber = wechatNumber;
    
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
                     failure:(HttpToolFailBlock)failure{
    
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
                     failure:(HttpToolFailBlock)failure{
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


/**
 *  账号登出
 *
 *  Method              POST
 *  @param mobile       手机号
 *  @param success      请求成功
 *  @param failure      请求失败
 */
+ (void)logoutSuccess:(LogoutSuccessBlock)success
              failure:(HttpToolFailBlock)failure{
    
    //账号登出参数模型
    LogoutParam *logoutParam = [[LogoutParam alloc] init];
    
    //Post 请求
    [HttpTool POST:LogoutURL
          parameters:[logoutParam paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     //登出模型
                     LogoutResponse *logoutResponse = [[LogoutResponse alloc] initWithDictionary:responsObject error:nil];
                     
                     success(logoutResponse);
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
 *  找回密码
 *
 *  Method         POST
 *  @param mobile   手机号
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)forgetWithMobile:(NSString *)mobile
                 success:(ForgetSuccessBlock)success
                 failure:(HttpToolFailBlock)failure{
    //找回密码参数模型
    ForgetParam *forgetParam = [[ForgetParam alloc] init];
    
    //手机号
    forgetParam.mobile = mobile;
    
    //Post 请求
    [HttpTool POST:ForgetURL
          parameters:[forgetParam paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     NSLog(@"forgetResponsObject====>>>%@",responsObject);
                     
                     //找回密码模型
                     ForgetResponse * forgetResponse = [[ForgetResponse alloc] initWithDictionary:responsObject error:nil];
                     
                     success(forgetResponse);
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
 *  个人简介
 *
 *  Method:             GET
 *  @param success      请求成功
 *  @param failure      请求失败
 */
+ (void)profileSuccess:(ProfileSuccessBlock)success
               failure:(HttpToolFailBlock)failure{
    //个人简介参数模型
    ProfileParam *profileParam = [[ProfileParam alloc] init];
    
    profileParam.mobile = [[LocalManager sharedManager] mobile];
    
    //Get 请求
    [HttpTool POST:ProfileURL
         parameters:[profileParam paramDictionary]
            success:^(NSDictionary *responsObject) {
                
                
                /**
                 *  成功回调
                 *  @param responseObject 请求的数据结果
                 */
                if(success){
                    
                    //个人简介模型
                    ProfileResponse *profileResponse = [[ProfileResponse alloc] initWithDictionary:responsObject error:nil];
                
                    
                    success(profileResponse);
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
 *  更新个人简介
 *
 *  @param password     新密码
 *  @param success      请求成功
 *  @param failure      请求失败
 */
+ (void)updateWithPassword:(NSString *)password
                   success:(LoginSuccessBlock)success
                   failure:(HttpToolFailBlock)failure{
    
    //更新个人简介参数模型
    UpdateParam *updateParam = [[UpdateParam alloc] init];
    

    
    //新密码
    updateParam.password = [password md5HexDigest];
    
    //Post 请求
    [HttpTool POST:UpdateURL
          parameters:[updateParam paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     //更新个人简介模型
                     LoginResponse *login = [[LoginResponse alloc] initWithDictionary:responsObject error:nil];
                     
                     success(login);
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
 *  手机号码修改
 *
 *  @param mobile  手机号
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)updatemobileWithNewmobile:(NSString *)newmobile
                          success:(UpdatemobileSuccessBlock)success
                          failure:(HttpToolFailBlock)failure{
    //手机号码修改参数模型
    UpdatemobileParam *updateMobileParam = [[UpdatemobileParam alloc] init];
    

    
    //新手机号
    updateMobileParam.newmobile = newmobile;
    
    //Post 请求
    [HttpTool POST:UpdatemobileURL
          parameters:[updateMobileParam paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     //手机号修改模型
                     UpdatemobileResponse *updateMobileResponse = [[UpdatemobileResponse alloc] initWithDictionary:responsObject error:nil];
                     
                     success(updateMobileResponse);
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
 *  用户名修改
 *
 *  @param newusername 新用户名
 *  @param success     请求成功
 *  @param failure     请求失败
 */
+ (void)updateusernameWithNewusername:(NSString *)newusername
                              success:(UpdateusernameSuccessBlock)success
                              failure:(HttpToolFailBlock)failure{
    
    //用户名修改参数模型
    UpdateusernameParam *updateusernameParam = [[UpdateusernameParam alloc] init];
    

    
    //新用户名
    updateusernameParam.newusername = newusername;
    
    //access_token
    //    updateusernameParam.access_token = [LocalManager sharedManager].access_token;
    
    //Post 请求
    [HttpTool POST:UpdateusernameURL
          parameters:[updateusernameParam paramDictionary]
             success:^(NSDictionary *responsObject) {
                 
                 
                 /**
                  *  成功回调
                  *  @param responseObject 请求的数据结果
                  */
                 if(success){
                     
                     //用户名修改模型
                     UpdateusernameResponse *updateusernameResponse = [[UpdateusernameResponse alloc] initWithDictionary:responsObject error:nil];
                     
                     success(updateusernameResponse);
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
