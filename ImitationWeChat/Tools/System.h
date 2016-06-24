//
//  System.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCountry.h"

@interface System : NSObject

@property (nonatomic, strong) NSMutableDictionary *dicCode;

@property (nonatomic, strong) MMCountry *mmCountry;

/**
 *  单例
 *
 *  @return 单例
 */
+ (System *)sharedInstance;

- (void)readData;

@end
