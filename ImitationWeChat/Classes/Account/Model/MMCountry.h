//
//  MMCountry.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *name = @"name";
static NSString *country_name_cn = @"country_name_cn";
static NSString *country_name_en = @"country_name_en";
static NSString *country_id = @"country_id";
static NSString *country_latin = @"country_latin";
static NSString *country_code = @"country_code";
static NSString *ab = @"ab";

//@interface MMCountry : NSObject
//
//@property (nonatomic, strong) NSString *name;   //国家名(本地化后的版本)
//@property (nonatomic, strong) NSString *country_name_cn;   //国家名(中)
//@property (nonatomic, strong) NSString *country_name_en;   //国家名(英)
//@property (nonatomic, strong) NSString *country_id;   //国家代号
//@property (nonatomic, strong) NSString *country_latin;  //国家名的拉丁文(只包含基本拉丁字母)
//@property (nonatomic, strong) NSString *country_code;  //区号
//@property (nonatomic, strong) NSString *ab;     //缩写
//
//@end



@interface MMCountry : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *latin;
@property (nonatomic, strong) NSString *dial_code;

@end