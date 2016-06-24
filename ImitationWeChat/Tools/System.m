//
//  System.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "System.h"

@implementation System

/**
 *  单例
 *
 *  @return 单例
 */
+ (System *)sharedInstance
{
    static System *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)product
{
     NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"country_code.txt" ofType:@"json"]];
    
    
}

- (void)readData {
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"diallingcode" ofType:@"json"]];
    NSError *error = nil;
    
    NSArray *arrayCode = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if ( error ) {
        
        return;
    }
    //    NSLog(@"%@", arrayCode);
    
    
    //读取文件
    NSMutableDictionary *dicCode = [@{} mutableCopy];
    
    for ( NSDictionary *item in arrayCode )
    {
        MMCountry *c = [MMCountry new];
        
        c.code      = item[@"code"];
        c.dial_code = item[@"dial_code"];
        
        [dicCode setObject:c forKey:c.code];
    }
    
    //获取国家名
    NSLocale *locale = [NSLocale currentLocale];
    
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    NSMutableDictionary *dicCountry = [@{} mutableCopy];
    
    for (NSString *countryCode in countryArray) {
        
        if ( dicCode[countryCode] )
        {
            MMCountry *c = dicCode[countryCode];
            
            c.name = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
            if ( [c.name isEqualToString:@"台湾"] )
            {
                c.name = @"中国台湾";
            }
            
            c.latin = [self latinize:c.name];
            
            [dicCountry setObject:c forKey:c.code];
        }
        else
        {
//            NSLog(@"++ %@ %@",[locale displayNameForKey:NSLocaleCountryCode value:countryCode],countryCode);
        }
    }
    
    //取得当前local
    self.mmCountry = dicCode[[locale objectForKey:NSLocaleCountryCode]];
    
    //归类
    NSMutableDictionary *dicSort = [@{} mutableCopy];
    
    for ( MMCountry *c in dicCountry.allValues )
    {
        NSString *indexKey = @"";
        
        if ( c.latin.length > 0 )
        {
            indexKey = [[c.latin substringToIndex:1] uppercaseString];
            
            char c = [indexKey characterAtIndex:0];
            
            if ( ( c < 'A') || ( c > 'Z' ) )
            {
                continue;
            }
        }
        else
        {
            continue;
        }
        
        NSMutableArray *array = dicSort[indexKey];
        
        if ( !array )
        {
            array = [NSMutableArray array];
            
            dicSort[indexKey] = array;
        }
        
        [array addObject:c];
    }
    
    //排序
    
    for ( NSString *key in dicSort.allKeys )
    {
        NSArray *array = dicSort[key];
        
        array = [array sortedArrayUsingComparator:^NSComparisonResult(MMCountry *obj1, MMCountry *obj2) {
            
            return [obj1.name localizedStandardCompare:obj2.name];
        }];
        
        //            array = [array sortedArrayUsingComparator:^NSComparisonResult(CSCountry *obj1, CSCountry *obj2) {
        //
        //                return obj1.sortKey > obj2.sortKey;
        //            }];
        
        dicSort[key] = array;
    }
    
    self.dicCode = dicSort;

    
}


//这里是微信犯的第二个错误 微信的排序是按照latin来排序的(见注释掉的代码) 所以导致了相同汉字的国家排不到一起的情况 正确的方式是用localizedStandardCompare来排序 这也是iOS已为我们提供好了的本地化比较函数
//看看之前的图中 挑三个国家出来 比如:阿尔巴尼亚 爱尔兰 阿鲁巴 他们的拼音是 aerbabiya aierlan aluba 如果按照拼音排序的话 这样的排序就是正确的

- (NSString*)latinize:(NSString*)str
{
    NSMutableString *source = [str mutableCopy];
    
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformToLatin, NO);
    //    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    
    return source;
}

@end
