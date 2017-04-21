//
//  HttpTool.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

#import <objc/runtime.h>

static const char associatedkey;

@implementation HttpTool
/**
 *  单例
 *
 *  @return 单例
 */
+ (HttpTool *)sharedInstance
{
    static HttpTool *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


/**
 *  GET 请求
 *
 *  @param URLString  请求地址URL
 *  @param parameters 附带参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(HttpToolSuccessBlock)success
    failure:(HttpToolFailBlock)failure{
    

    //拼接完整请求链接
    URLString = [NSString stringWithFormat:@"%@%@", HttpHead , URLString ];
    
    
    //发起请求
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:URLString
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation,
                   id responseObject) {
             
             
             /**
              *  成功回调
              *  @param responseObject 请求的数据结果
              */
             //判断是否有数据
             if(responseObject){
                  success(responseObject);
                 //判断请求状态是否成功
                 if ([[responseObject objectForKey:@"return_message"] isEqualToString:@"OK"]) {
                     success(responseObject);
                 }
                 else
                 {
                     int status_code = [[responseObject objectForKey:@"return_code"] intValue];
                     
//                     //如果返回9 则退出登录
                    if ( (status_code == 9) || (status_code == 1) ) {
                        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [appdelegate logout];
                    
                    }
 
                     NSString *domain = [responseObject objectForKey:@"return_message"];
                  
                     NSError *error = [NSError errorWithDomain:domain code:[[responseObject objectForKey:@"return_code"] intValue] userInfo:nil];
                     //状态失败，返回错误信息和错误代码
                     failure(error);
                 }
                 
             }
             else
             {
                 //无数据返回，返回错误信息
                 NSError *error = [NSError errorWithDomain:@"no data result" code:0 userInfo:nil];
                 failure(error);
             }
             
             
         }
         failure:^(AFHTTPRequestOperation *operation,
                   NSError *error) {
             
             /**
              *  失败回调
              *  @param error 错误代码
              */
             if(failure){
//                 [[ErrorTool sharedTool] addErrorCount];
                 
                 NSLog(@"%@",[error description]);
                 failure(error);
             }
         }];
}


/**
 *  POST 请求
 *
 *  @param URLString  请求地址URL
 *  @param parameters 附带参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(HttpToolSuccessBlock)success
     failure:(HttpToolFailBlock)failure{
    
    NSLog(@"parameters%@", parameters);
//    NSString *str = [[ErrorTool sharedTool]getHttpHead];
    //拼接完整请求链接
    URLString = [NSString stringWithFormat:@"%@%@", HttpHead , URLString ];
    
    //发起请求
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    [manager POST:URLString
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation,
                    id responseObject) {
              
              /**
               *  成功回调
               *  @param responseObject 请求的数据结果
               */
              //判断是否有数据
              if(responseObject){
                  //判断请求状态是否成功
                  if ([[responseObject objectForKey:@"return_message"] isEqualToString:@"OK"]) {
                      success(responseObject);
                  }
                  else
                  {
                      int status_code = [[responseObject objectForKey:@"return_code"] intValue];
                      
                      //如果返回9 则退出登录
                      if ( (status_code == 9) || (status_code == 1) ) {
      
                          AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                          [appdelegate logout];
                      }
                      
                      
                      NSString *domain = [responseObject objectForKey:@"return_message"];
                      
                      NSLog(@"%@", domain);
                      
                      [getWindow makeToast:domain];

                      
                      NSError *error = [NSError errorWithDomain:domain code:[[responseObject objectForKey:@"return_code"] intValue] userInfo:nil];
            
  
                      failure(error);
                  }
                  
              }
              else
              {
                  //无数据返回，返回错误信息
                  NSError *error = [NSError errorWithDomain:@"no data result" code:0 userInfo:nil];
      
                  failure(error);
              }
              
              
          }
          failure:^(AFHTTPRequestOperation *operation,
                    NSError *error) {
              /**
               *  失败回调
               *  @param error 错误代码
               */
              if(failure){
//                  [[ErrorTool sharedTool] addErrorCount];
                  
                  failure(error);
                  
              }
          }];
    
    
}



#pragma mark - ######################################网络状态#########################################



/**
 *  开始监听网络状态
 */
+ (void)startInternetListen{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                objc_setAssociatedObject([UIApplication sharedApplication], &associatedkey, NOTREACHABLE, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_LISTEN_NOTIFICATION object:NOTREACHABLE];
            }
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
            {
                objc_setAssociatedObject([UIApplication sharedApplication], &associatedkey, WIFI, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_LISTEN_NOTIFICATION object:WIFI];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                objc_setAssociatedObject([UIApplication sharedApplication], &associatedkey, WWAN, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_LISTEN_NOTIFICATION object:WWAN];
            }
                break;
                
            default:
                break;
        }
    }];
    
}

/**
 *  获取网络状态
 */
+ (NSString *)internetStatus
{
    NSString  *messageString =objc_getAssociatedObject([UIApplication sharedApplication], &associatedkey);
    NSLog(@"%@", messageString);
    return messageString;
}

@end
