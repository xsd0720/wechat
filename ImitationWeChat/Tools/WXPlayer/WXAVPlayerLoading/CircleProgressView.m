//
//  CircleProgressView.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/26.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "CircleProgressView.h"

@implementation CircleProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // Initialization code
        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = [[UIColor clearColor] CGColor];
        _trackLayer.frame = self.bounds;
        
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.7] CGColor];
        _progressLayer.lineWidth = 0;
        _progressLayer.frame = self.bounds;
        
    }
    return self;
}

- (void)setTrack
{
    CGFloat radius = CGRectGetMaxX(self.bounds)/2;
    _trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius-1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress
{
    
 
}


- (void)setProgressWidth:(float)progressWidth
{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = 1;
    
    [self setTrack];
    [self setProgress];
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = [[UIColor whiteColor] CGColor];
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = [[UIColor whiteColor] CGColor];
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    
    CGFloat radius = CGRectGetMaxX(self.bounds)/2;
    
    _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius-4 startAngle:-DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(360) * progress - M_PI_2  clockwise:YES];
    [_progressPath addLineToPoint:CGPointMake(radius, radius)];
    [_progressPath closePath];
    _progressLayer.path = _progressPath.CGPath;
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    
}


@end
