//
//  NSString+Category.h
//  lilworld
//
//  Created by xwmedia01 on 16/6/16.
//  Copyright © 2016年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
//获取重复字符串位置
- (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;
@end