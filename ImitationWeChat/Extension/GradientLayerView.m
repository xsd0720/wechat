//
//  GradientLayer.m
//  Test
//
//  Created by xwmedia01 on 15/9/14.
//  Copyright (c) 2015年 xwmedia01. All rights reserved.
//

#import "GradientLayerView.h"


@interface GradientLayerView()

//渐变图层
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UIColor *mostColor;

@end

@implementation GradientLayerView

- (instancetype)initWithFrame:(CGRect)frame mostColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.mostColor = color;
        
        //透明背景
        self.backgroundColor = [UIColor clearColor];
        
        //渐变图层
        _gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
        
        //默认渐变方向
        self.direction = DirectionUP;
        
        //添加渐变图层
        [self.layer addSublayer:_gradientLayer];
        
    }
    return self;
}

/**
 *  设置渐变方向
 *
 *  @param direction 方向
 */
- (void)setDirection:(Direction)direction
{
    _direction = direction;
    
    if (direction == DirectionDown) {
        _gradientLayer.colors = [NSArray arrayWithObjects:
                                 (id)[[self.mostColor colorWithAlphaComponent:0.0f] CGColor],
                                 (id)[self.mostColor CGColor], nil];
        
    }
    else if(direction == DirectionUP)
    {
        _gradientLayer.colors = [NSArray arrayWithObjects:
                                 (id)[self.mostColor CGColor],
                                 (id)[[self.mostColor colorWithAlphaComponent:0.0f] CGColor], nil];
    }
}

/**
 *  自动布局子视图
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    _gradientLayer.frame = self.bounds;
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(0, 1.0);
}

@end
