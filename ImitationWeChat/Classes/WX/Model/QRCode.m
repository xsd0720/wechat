//
//  QRCode.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/13.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "QRCode.h"

@implementation QRCode

#pragma mark - Private Methods
void ProviderReleaseData (void *info, const void *data, size_t size){
         free((void*)data);
}

#pragma mark - Public Methods
+ (CIImage *)createQRCodeImage:(NSString *)source {
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"]; //设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
    return filter.outputImage;
}

+ (UIImage *)createQRCodeImage:(NSString *)source size:(CGFloat)size {
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"]; //设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
    UIImage *im = [self resizeQRCodeImage:filter.outputImage withSize:size];
    
    return im;
}

+ (UIImage *)createQRCodeImage:(NSString *)source size:(CGFloat)size icon:(NSString *)iconName{
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"]; //设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
    UIImage *imgAdaptiveQRCode = [self resizeQRCodeImage:filter.outputImage withSize:size];
    UIImage *imgIcon = [UIImage createRoundedRectImage:[UIImage imageNamed:@"000"]
                                              withSize:CGSizeMake(44, 44)
                                            withRadius:2];
    imgAdaptiveQRCode = [QRCode addIconToQRCodeImage:imgAdaptiveQRCode
                                            withIcon:imgIcon
                                        withIconSize:imgIcon.size];
    return imgAdaptiveQRCode;
}

+ (UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();

    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, imageRef);

    CGImageRef imageRefResized = CGBitmapContextCreateImage(contextRef);

    //Release
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRefResized];
}

+ (UIImage *)specialColorImage:(UIImage*)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);

    //Create context
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

    //Traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
         if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
                 //Change color
                 uint8_t* ptr = (uint8_t*)pCurPtr;
                 ptr[3] = red; //0~255
                 ptr[2] = green;
                 ptr[1] = blue;
             }else{
                     uint8_t* ptr = (uint8_t*)pCurPtr;
                     ptr[0] = 0;
                 }
     }

    //Convert to image
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                                                                kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProviderRef,
                                                                                NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProviderRef);
    UIImage* img = [UIImage imageWithCGImage:imageRef];

    //Release
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    return img;
}

+(UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
    CGFloat widthOfImage = image.size.width;
    CGFloat heightOfImage = image.size.height;
    CGFloat widthOfIcon = iconSize.width;
    CGFloat heightOfIcon = iconSize.height;

    [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
    [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,
                                                                widthOfIcon, heightOfIcon)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);

    //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
    CGFloat widthOfImage = image.size.width;
    CGFloat heightOfImage = image.size.height;
    CGFloat widthOfIcon = widthOfImage/scale;
    CGFloat heightOfIcon = heightOfImage/scale;

    [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
    [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,
                                                                 widthOfIcon, heightOfIcon)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return img;
}


+ (void)recognizeImage:(UIImage*)image block:(void(^)(ZXBarcodeFormat barcodeFormat,NSString *str))block;
{
    ZXCGImageLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:image.CGImage];
    
    ZXHybridBinarizer *binarizer = [[ZXHybridBinarizer alloc] initWithSource: source];
    
    ZXBinaryBitmap *bitmap = [[ZXBinaryBitmap alloc] initWithBinarizer:binarizer];
    
    NSError *error;
    
    id<ZXReader> reader;
    
    if (NSClassFromString(@"ZXMultiFormatReader")) {
        reader = [NSClassFromString(@"ZXMultiFormatReader") performSelector:@selector(reader)];
    }
    
    ZXDecodeHints *_hints = [ZXDecodeHints hints];
    ZXResult *result = [reader decode:bitmap hints:_hints error:&error];
    
    if (result == nil) {
        
        block(kBarcodeFormatQRCode,nil);
        return;
    }
    
    block(result.barcodeFormat,result.text);
}



@end
