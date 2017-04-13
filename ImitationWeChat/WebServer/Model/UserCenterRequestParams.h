//
//  UserCenterRequestParams.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParamBase.h"

/**
 *  1.登录参数构造
 */
@interface  LoginParam : RequestParamBase

//登录手机号
@property (nonatomic, strong) NSString *name;

//登录密码
@property (nonatomic, strong) NSString *pwd;

//uuid
//@property (nonatomic, strong) NSString *uuid;

//设备操作系统
@property (nonatomic, strong) NSString *device;

@end



/**
 *  2.注册参数构造
 */
@interface RegisterParam : RequestParamBase

//注册用户名
@property (nonatomic, strong) NSString *username;

//注册手机号
@property (nonatomic, strong) NSString *mobile;

//注册密码
@property (nonatomic, strong) NSString *password;

//生日
@property (nonatomic, strong) NSString *birthday;

//性别
@property (nonatomic, strong) NSString *gender;

//头像
@property (nonatomic, strong) NSString *head_pic_url;

@property (nonatomic, strong) NSString *wechatnumber;


@end


@interface RequestsnsParm : RequestParamBase

/***  手机号*/
@property (nonatomic, strong) NSString *mobile;


@end

@interface CheckvcodeParm : RequestParamBase

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *vcode;

@end


/**
 *  3.账号登出
 */
@interface LogoutParam : RequestParamBase

//手机号
@property (nonatomic, strong) NSString *mobile;

//access_token
//@property (nonatomic, strong) NSString *access_token;


@end



/**
 *  4.个人简介更新
 */
@interface UpdateParam : RequestParamBase

//access_token
//@property (nonatomic, strong) NSString *access_token;

//新密码
@property (nonatomic, strong) NSString *password;

//手机号码
@property (nonatomic, strong) NSString *mobile;


@end



/**
 *  5.找回密码
 */
@interface ForgetParam : RequestParamBase

//手机号
@property (nonatomic, strong) NSString *mobile;

@end


/**
 *  6.获取用户个人简介
 */
@interface ProfileParam : RequestParamBase

//access_token
//@property (nonatomic, strong) NSString *access_token;

//手机号
@property (nonatomic, strong) NSString *mobile;


@end

/**
 *  7.手机号修改
 */
@interface UpdatemobileParam : RequestParamBase

//旧手机号
@property (nonatomic, strong) NSString *mobile;

//新手机号
@property (nonatomic, strong) NSString *newmobile;

//access_token
//@property (nonatomic, strong) NSString *access_token;

@end


/**
 *  8.用户名修改
 */
@interface UpdateusernameParam : RequestParamBase

//手机号
@property (nonatomic, strong) NSString *mobile;

//新用户名
@property (nonatomic, strong) NSString *newusername;

//access_token
//@property (nonatomic, strong) NSString *access_token;

@end

