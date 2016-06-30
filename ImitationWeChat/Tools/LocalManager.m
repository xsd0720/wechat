//
//  LocalManager.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/30.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "LocalManager.h"
static NSString *access_token = @"access_token";


@implementation LocalManager
+ (LocalManager *)sharedManager
{
    static LocalManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:LOCALMANGERFILEPATH];
        if (dict) {
            if ([dict isKindOfClass:[NSDictionary class]]) {
                 objc_setAssociatedObject(self, &access, dict[access_token], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
    });
    return sharedAccountManagerInstance;
}

- (NSString *)access_token
{
    NSString *access_tokenTmp = objc_getAssociatedObject(self, &associatedkey);
    return access_tokenTmp;
}

- (void)logout
{
    objc_removeAssociatedObjects(self);
    [[NSFileManager defaultManager] removeItemAtPath:LOCALMANGERFILEPATH error:nil];
}

@end
