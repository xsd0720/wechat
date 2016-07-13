//
//  UIImage+Category.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "UIImage+Category.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation UIImage (Category)
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

/**
 *  根据颜色和大小获取Image
 *
 *  @param color 颜色
 *  @param size  大小
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  根据图片和颜色返回一张加深颜色以后的图片
 */
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    
    UIGraphicsBeginImageContext(CGSizeMake(baseImage.size.width*2, baseImage.size.height*2));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width * 2, baseImage.size.height * 2);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
///**
// *  根据图片返回一张高斯模糊的图片
// *
// *  @param blur 模糊系数
// *
// *  @return 新的图片
// */
//- (UIImage *)boxblurImageWithBlur:(CGFloat)blur {
//    
//    NSData *imageData = UIImageJPEGRepresentation(self, 1); // convert to jpeg
//    UIImage* destImage = [UIImage imageWithData:imageData];
//    
//    
//    if (blur < 0.f || blur > 1.f) {
//        blur = 0.5f;
//    }
//    int boxSize = (int)(blur * 40);
//    boxSize = boxSize - (boxSize % 2) + 1;
//    
//    CGImageRef img = destImage.CGImage;
//    
//    vImage_Buffer inBuffer, outBuffer;
//    
//    vImage_Error error;
//    
//    void *pixelBuffer;
//    
//    
//    //create vImage_Buffer with data from CGImageRef
//    
//    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
//    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
//    
//    
//    inBuffer.width = CGImageGetWidth(img);
//    inBuffer.height = CGImageGetHeight(img);
//    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
//    
//    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
//    
//    //create vImage_Buffer for output
//    
//    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
//    
//    if(pixelBuffer == NULL)
//        NSLog(@"No pixelbuffer");
//    
//    outBuffer.data = pixelBuffer;
//    outBuffer.width = CGImageGetWidth(img);
//    outBuffer.height = CGImageGetHeight(img);
//    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
//    
//    // Create a third buffer for intermediate processing
//    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
//    vImage_Buffer outBuffer2;
//    outBuffer2.data = pixelBuffer2;
//    outBuffer2.width = CGImageGetWidth(img);
//    outBuffer2.height = CGImageGetHeight(img);
//    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
//    
//    //perform convolution
//    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    if (error) {
//        NSLog(@"error from convolution %ld", error);
//    }
//    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    if (error) {
//        NSLog(@"error from convolution %ld", error);
//    }
//    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    if (error) {
//        NSLog(@"error from convolution %ld", error);
//    }
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
//                                             outBuffer.width,
//                                             outBuffer.height,
//                                             8,
//                                             outBuffer.rowBytes,
//                                             colorSpace,
//                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
//    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
//    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
//    
//    //clean up
//    CGContextRelease(ctx);
//    CGColorSpaceRelease(colorSpace);
//    
//    free(pixelBuffer);
//    free(pixelBuffer2);
//    CFRelease(inBitmapData);
//    
//    CGImageRelease(imageRef);
//    
//    return returnImage;
//}
/**
 *  自由改变Image的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)cropImageWithSize:(CGSize)size {
    
    float scale = self.size.width/self.size.height;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if (scale > size.width/size.height) {
        
        rect.origin.x = (self.size.width - self.size.height * size.width/size.height)/2;
        rect.size.width  = self.size.height * size.width/size.height;
        rect.size.height = self.size.height;
        
    }else {
        
        rect.origin.y = (self.size.height - self.size.width/size.width * size.height)/2;
        rect.size.width  = self.size.width;
        rect.size.height = self.size.width/size.width * size.height;
        
    }
    
    CGImageRef imageRef   = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}


- (CGSize)limitMaxWidthHeight
{
    CGFloat maxW = SCREEN_WIDTH-120;
    CGFloat maxH = SCREEN_WIDTH-120;
    
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    
    //宽大于高
    if (w > h) {
        float scale = w/h;
        CGFloat resultW = MIN(maxW, w);
        CGFloat resultH = resultW/scale;
        return CGSizeMake(resultW, resultH);
    }
    //宽高相等
    else if(w == h)
    {
        float scale = 1;
        CGFloat resultW = MIN(maxW, w);
        CGFloat restultH = resultW/scale;
        return CGSizeMake(resultW, restultH);
    }
    //高大于宽
    else
    {
        float scale = h/w;
        CGFloat resultH = MIN(maxH, h);
        CGFloat resultW = resultH/scale;
        return  CGSizeMake(resultW, resultH);
    }

}

+ (UIImage *)drawDashLineRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);   //开始画线
    CGFloat lengths[] = {5,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGContextSetStrokeColorWithColor(line, RGBCOLOR(208, 208, 208).CGColor);
    CGContextSetLineWidth(line, 3);
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, rect.size.width, 0.0);
    CGContextStrokePath(line);
    UIImage *dashImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return dashImage;
}


#pragma mark - Private Methods
static void addRoundedRectToPath(CGContextRef contextRef, CGRect rect, float widthOfRadius, float heightOfRadius) {
     float fw, fh;
     if (widthOfRadius == 0 || heightOfRadius == 0)
        {
                CGContextAddRect(contextRef, rect);
                 return;
             }

     CGContextSaveGState(contextRef);
     CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
     CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
     fw = CGRectGetWidth(rect) / widthOfRadius;
     fh = CGRectGetHeight(rect) / heightOfRadius;

     CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
     CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
     CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
     CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
     CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right

     CGContextClosePath(contextRef);
     CGContextRestoreGState(contextRef);
}

 #pragma mark - Public Methods
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius {
     int w = size.width;
     int h = size.height;

     CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
     CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
     CGRect rect = CGRectMake(0, 0, w, h);

     CGContextBeginPath(contextRef);
     addRoundedRectToPath(contextRef, rect, radius, radius);
     CGContextClosePath(contextRef);
     CGContextClip(contextRef);
     CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
     CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
     UIImage *img = [UIImage imageWithCGImage:imageMasked];
 
     CGContextRelease(contextRef);
     CGColorSpaceRelease(colorSpaceRef);
     CGImageRelease(imageMasked);
     return img;
}

@end
