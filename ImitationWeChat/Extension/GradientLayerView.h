//
//  GradientLayer.h
//  Test
//
//  Created by xwmedia01 on 15/9/14.
//  Copyright (c) 2015年 xwmedia01. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  方向枚举
 */
typedef NS_ENUM(NSUInteger, Direction){
    /**
     *  上
     */
    DirectionUP,
    /**
     *  下
     */
    DirectionDown,
};

@interface GradientLayerView : UIView

//渐变view 的位置（上 or 下）
@property (nonatomic, assign) Direction direction;

- (instancetype)initWithFrame:(CGRect)frame mostColor:(UIColor *)color;

@end
