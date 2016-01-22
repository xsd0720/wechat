//
//  UIColor+Category.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "UIColor+Category.h"
/* Return the color components (including alpha) associated with `color'. */
CG_EXTERN const CGFloat *CGColorGetComponents(CGColorRef color);
@implementation UIColor (Category)

- (CGFloat) alphaForColor:(UIColor*)color {
    CGFloat r, g, b, a, w, h, s, l;
    BOOL compatible = [color getWhite:&w alpha:&a];
    if (compatible) {
        return a;
    } else {
        compatible = [color getRed:&r green:&g blue:&b alpha:&a];
        if (compatible) {
            return a;
        } else {
            [color getHue:&h saturation:&s brightness:&l alpha:&a];
            return a;
        }
    }
}

-(BOOL)isDarkColor:(UIColor *)newColor{
    if ([self alphaForColor: newColor]<10e-5) {
        return YES;
    }
    const CGFloat *componentColors = CGColorGetComponents(newColor.CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    if (colorBrightness < 0.5){
        NSLog(@"Color is dark");
        return YES;
    }
    else{
        NSLog(@"Color is light");
        return NO;
    }
}
@end
