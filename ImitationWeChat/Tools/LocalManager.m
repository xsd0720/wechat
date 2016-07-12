//
//  LocalManager.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/30.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "LocalManager.h"
static NSString *access_token = @"access_token";
static NSString *mobile = @"mobile";
static const char accessTokenAssociatedKey;
static const char mobileAssociatedKey;

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
                 objc_setAssociatedObject(sharedAccountManagerInstance, &accessTokenAssociatedKey, dict[access_token], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                 objc_setAssociatedObject(sharedAccountManagerInstance, &mobileAssociatedKey, dict[mobile], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
    });
    return sharedAccountManagerInstance;
}

- (NSString *)access_token
{
    NSString *access_tokenTmp = objc_getAssociatedObject(self, &accessTokenAssociatedKey);
    return access_tokenTmp;
}

- (NSString *)mobile
{
    NSString *mobileTmp = objc_getAssociatedObject(self, &mobileAssociatedKey);
    return mobileTmp;
}

- (void)loginWithLoginResponse:(LoginResponse *)param
{
    objc_setAssociatedObject(self, &accessTokenAssociatedKey, param.access_token, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mobileAssociatedKey, param.mobile, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [NSKeyedArchiver archiveRootObject:[param toDictionary] toFile:LOCALMANGERFILEPATH];
}


- (void)save
{
    
}

- (void)logout
{
    objc_removeAssociatedObjects(self);
    [[NSFileManager defaultManager] removeItemAtPath:LOCALMANGERFILEPATH error:nil];
}

@end
