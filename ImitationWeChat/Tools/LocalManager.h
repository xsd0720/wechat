//
//  LocalManager.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/30.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCenterRequestParams.h"
#define LOCALMANAGER [LocalManager sharedManager]
@interface LocalManager : NSObject

@property (nonatomic, strong) NSString *access_token;

@property (nonatomic, strong) NSString *mobile;

+ (LocalManager *)sharedManager;

- (void)loginWithLoginResponse:(LoginParam *)param;

@end
