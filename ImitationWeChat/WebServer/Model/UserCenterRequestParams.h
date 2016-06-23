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
@property (nonatomic, strong) NSString *mobile;

//登录密码
@property (nonatomic, strong) NSString *password;

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


@end


@interface RequestsnsParm : RequestParamBase

/***  手机号*/
@property (nonatomic, strong) NSString *mobile;


@end

@interface CheckvcodeParm : RequestParamBase

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *vcode;

@end
