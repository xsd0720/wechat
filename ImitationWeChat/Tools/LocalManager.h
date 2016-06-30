//
//  LocalManager.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/30.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LOCALMANAGER [LocalManager sharedManager]
@interface LocalManager : NSObject

@property (nonatomic, strong) NSString *access_token;

+ (LocalManager *)sharedManager;

@end
