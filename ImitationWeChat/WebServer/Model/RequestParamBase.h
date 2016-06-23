//
//  RequestParamBase.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

#define SECRET_KEY              @"Ir#&hptos!21x$r--b6)$vf%!ads1b&^-e_^)k2letxg49~qwyh2x6d9j8pqw"

@interface RequestParamBase : BaseModel

/**
 *  当前系统时间戳
 */
@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) NSString *access_token;

@property (strong , nonatomic) NSString *version;

@property (strong , nonatomic) NSString *system;

@property (strong , nonatomic) NSString *uuid;

@property (strong , nonatomic) NSString *sigtype;

/**
 *  请求参数加密
 */
@property (nonatomic, strong) NSString *sig;

/**
 *  请求地址附带参数model解析
 *
 *  @return 解析的参数字典
 */
-(NSDictionary *)paramDictionary;


/**
 *  请求地址附带参数加密
 *
 *  @param postValueDic 参数集合
 *
 *  @return 加密后字符串
 */
-(NSString *)getSignature:(NSDictionary*) postValueDic;


@end
