//
//  QrCodeHollowView.m
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "QrCodeHollowView.h"

@implementation QrCodeHollowView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.2;
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(con, [UIColor blackColor].CGColor);
    
    CGContextFillRect(con, rect);
    CGFloat b = 4;
    CGContextClearRect(con, CGRectMake(_hollowRect.origin.x+b, _hollowRect.origin.y+b, _hollowRect.size.width-2*b, _hollowRect.size.height-2*b));
}

@end
