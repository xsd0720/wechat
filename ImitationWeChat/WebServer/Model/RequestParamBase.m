//
//  RequestParamBase.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "RequestParamBase.h"
#import "NSString+md5.h"
@implementation RequestParamBase
/**
 *  请求地址附带参数model解析
 *
 *  @return 解析的参数字典
 */
-(NSDictionary *)paramDictionary{
    
    //设置时间戳
    self.timestamp = [LWSystem timeNow];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    self.version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];;
    self.system = @"ios";
    self.uuid = [LWSystem UUID];
    self.sigtype = @"ios";
    
//    NSString *access_token = [LWLocalManager sharedManager].access_token;
//    if (access_token.length>0) {
//        self.access_token = access_token;
//    }
    
    //获取参数字典(未添加sig前)
    NSDictionary*tempParamDic = [self toDictionary];
    
    //设置加密字符串
    self.sig = [self getSignature:tempParamDic];
    
    //转换成字典格式返回
    return [self toDictionary];
}

/**
 *  请求地址附带参数加密
 *
 *  @param postValueDic 参数集合
 *
 *  @return 加密后字符串
 */
-(NSString *)getSignature:(NSDictionary*) postValueDic {
    NSMutableString *postStr = [[NSMutableString alloc] init];
    NSArray *sortedKeys = [[postValueDic allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    NSArray *objects = [postValueDic objectsForKeys: sortedKeys notFoundMarker: [NSNull null]];
    for (int i = 0; i < [sortedKeys count]; i++) {
        [postStr appendString:sortedKeys[i]];
        [postStr appendString:@"="];
        if ([objects[i] isKindOfClass:[NSNumber class]]) {
            [postStr appendString:[NSString stringWithFormat:@"%d", [(NSNumber*)objects[i] intValue]]];
        }
        else if ([objects[i] isKindOfClass:[NSString class]]) {
            [postStr appendString:objects[i]];
        }
        else {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objects[i]
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                         encoding:NSUTF8StringEncoding];
            [postStr appendString:jsonString];
        }
        [postStr appendString:@"&"];
    }
    [postStr appendString:SECRET_KEY];
    return [postStr md5HexDigest];
}

@end
