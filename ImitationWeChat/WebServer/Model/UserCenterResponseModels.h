//
//  UserCenterResponseModels.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseModelBase.h"

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