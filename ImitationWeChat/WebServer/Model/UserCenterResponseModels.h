//
//  UserCenterResponseModels.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseModelBase.h"


//profile
@interface profile : BaseModel

//用户id
@property (nonatomic, copy) NSString *userID;

//手机号
@property (nonatomic, strong) NSString *mobile;

//头像
@property (nonatomic, strong) NSString *head_pic_url;

//用户名
@property (nonatomic, strong) NSString *username;


@property (nonatomic, strong) NSString *wechatnumber;

//我的二维码
@property (nonatomic, strong) NSString *myQrCode;


@property (nonatomic, strong) NSArray *myaddresses;

//性别
@property (nonatomic, strong) NSString *gender;

//地区
@property (nonatomic, strong) NSString *location;

//个性签名
@property (nonatomic, strong) NSString *personSig;

//linkedLn 账号
@property (nonatomic, strong) NSString *linkedLnAccount;

@end


/**
 *  登录返回数据
 */
@interface LoginResponse : ResponseModelBase

//access_token
@property (nonatomic, strong) NSString *access_token;

//登录后返回的需要传的值
@property (nonatomic, strong) NSString *mobile;

@end



/**
 *  发送验证码成功
 */
@interface RequestsnsResponse : ResponseModelBase

@end


/**
 *  验证验证码是否正确成功
 */
@interface CheckvcodeResponse : ResponseModelBase

@end


/**
 *  登出返回数据
 */
@interface LogoutResponse : ResponseModelBase

@end




/**
 *  忘记密码返回数据
 */
@interface ForgetResponse : ResponseModelBase

@end




/**
 *  个人简介返回数据
 */
@interface ProfileResponse : ResponseModelBase

//profile model
@property (nonatomic, strong) profile *profile;

@end




/**
 *  更新个人简介返回数据
 */
@interface UpdateResponse : BaseModel

//状态
@property (nonatomic, strong) NSString *status;

//状态码
@property (nonatomic, strong) NSString *status_code;

@end


/**
 *  手机号修改返回数据
 */
@interface UpdatemobileResponse : BaseModel

//状态
@property (nonatomic, strong) NSString *status;

//状态码
@property (nonatomic, strong) NSString *status_code;

@end


/**
 *  用户名修改返回数据
 */
@interface UpdateusernameResponse : ResponseModelBase

@end
