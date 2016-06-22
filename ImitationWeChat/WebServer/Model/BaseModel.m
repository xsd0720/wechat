//
//  BaseModel.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
/**
 *  重写父类该方法
 *
 *  @param propertyName value
 *
 *  @return 是否不需要返回value的空的键值对
 */
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}


@end
