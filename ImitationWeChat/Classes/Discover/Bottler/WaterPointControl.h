//
//  WaterPointControl.h
//  testapplepay
//
//  Created by xwmedia01 on 16/2/1.
//  Copyright © 2016年 xwmedia01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define WATERIMAGEVIEWWIDTH     68
#define WATERIMAGEVIEWHEIGHT    48
@interface WaterPointControl : NSObject

//初始化椭圆路径
- (instancetype)initOvalInRect:(CGRect)rect;

//获取随机点坐标
- (CGPoint)getRandomPoint;

@end
