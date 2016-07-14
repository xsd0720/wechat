//
//  UIImage+Category.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

- (CGSize)limitMaxWidthHeight;

+ (UIImage *)drawDashLineRect:(CGRect)rect;

+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;

+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size;

+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
