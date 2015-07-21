//
//  ShakeHalfView.m
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "ShakeHalfView.h"

@implementation ShakeHalfView

-(instancetype)initWithFrame:(CGRect)frame direction:(ShakeDirection)direction shakeLogoIVName:(NSString *)logoName shakeLineIVName:(NSString *)lineName{
    self = [super initWithFrame:frame];
    if (self) {
        
//        CGFloat shakeLineHeight = (SCREEN_WIDTH/320.f)*20;
        self.backgroundColor = RGBCOLOR(47, 50, 50);
        
        //摇动的一半小手
        UIImage *shakelogoImage = [UIImage imageNamed:logoName];
        CGFloat shakelogoImageW = shakelogoImage.size.width;
        CGFloat shakelogoImageH = shakelogoImage.size.height;
        //判断是上部分还是下部分
        CGFloat shakeLogoIVOriginY = direction==ShakeDirectionUp?(frame.size.height-shakelogoImageH):0;
        
        
        _shakeLogoIV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-shakelogoImageW)/2, shakeLogoIVOriginY, shakelogoImageW, shakelogoImageH)];
        _shakeLogoIV.image = shakelogoImage;
        [self addSubview:_shakeLogoIV];
        
        
        //黑条
        UIImage *shakelineImage = [UIImage imageNamed:lineName];
        CGFloat shakelineImageW = shakelineImage.size.width;
        CGFloat shakelineImageH = shakelineImage.size.height;
        //判断是上部分还是下部分
        CGFloat shakelineIVOriginY = direction==ShakeDirectionUp?(frame.size.height):-shakelineImageH;
        shakelineImage = [shakelineImage stretchableImageWithLeftCapWidth:shakelineImageW/2 topCapHeight:shakelineImageH/2];
        _shakeLineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, shakelineIVOriginY, frame.size.width, shakelineImageH)];
        _shakeLineIV.image = shakelineImage;
        [self addSubview:_shakeLineIV];
    }
    return self;
}

@end
