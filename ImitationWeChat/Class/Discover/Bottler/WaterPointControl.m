//
//  WaterPointControl.m
//  testapplepay
//
//  Created by xwmedia01 on 16/2/1.
//  Copyright © 2016年 xwmedia01. All rights reserved.
//

#import "WaterPointControl.h"
@interface WaterPointControl()
@property (nonatomic, strong) UIBezierPath    *waterProductPath;
@property (nonatomic, assign) CGRect           rect;
@end
@implementation WaterPointControl


- (instancetype)initOvalInRect:(CGRect)rect
{
    self = [super init];
    if (self) {
        self.rect = rect;
        self.waterProductPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    }
    return self;
    
}

//点是否在范围内
- (BOOL)isContainsPoint:(CGPoint)inPointTouch
{
    return CGPathContainsPoint(self.waterProductPath.CGPath,NULL,inPointTouch,false);
}


- (CGPoint)getRandomPoint
{
    CGFloat orginX = self.rect.origin.x;
    CGFloat orginY = self.rect.origin.y;
    int width = self.rect.size.width;
    int height = self.rect.size.height;
    CGFloat randomX = arc4random()%width;
    CGFloat randomY = arc4random()%height;
    CGPoint point = CGPointMake(randomX, randomY);
    if ([self isContainsPoint:point]) {
        if (point.x<WATERIMAGEVIEWWIDTH/2) {
            point.x = WATERIMAGEVIEWWIDTH/2;
        }
        if (point.x>(width-WATERIMAGEVIEWWIDTH/2)) {
            point.x = width-WATERIMAGEVIEWWIDTH/2;
        }
        if (point.y<WATERIMAGEVIEWHEIGHT/2) {
            point.y = WATERIMAGEVIEWHEIGHT/2;
        }
        if (point.y>(height-WATERIMAGEVIEWHEIGHT/2)) {
            point.y = height-WATERIMAGEVIEWHEIGHT/2;
        }
        
        return CGPointMake(point.x+self.rect.origin.x, point.y+self.rect.origin.y);
    }else
    {
        return [self getRandomPoint];
    }
}
@end
