//
//  NSString+Category.h
//  lilworld
//
//  Created by xwmedia01 on 16/6/16.
//  Copyright © 2016年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+EmptyOrNull.h"

@interface NSString (Category)
//获取重复字符串位置
- (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;
- (void)findSameStringPostion:(NSString *)contentString AttributedString:(NSMutableAttributedString *)attributedString;


- (CGSize)CalculationStringSizeInView:(UIView *)showView;

- (CGSize)CalculationStringSizeWithWidth:(CGFloat)showWidth font:(UIFont *)showFont;

@end
