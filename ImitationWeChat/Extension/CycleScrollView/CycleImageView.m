//
//  CycleImageView.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/26.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "CycleImageView.h"

@interface CycleImageView()

@end

@implementation CycleImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        //背景图
        _bgPicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CYCLEIMAGEPADDING, 0, frame.size.width-CYCLEIMAGEPADDING*2, frame.size.height)];
        _bgPicImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgPicImageView.clipsToBounds = YES;
        _bgPicImageView.backgroundColor = [UIColor getColor:@"E8E8E8"];
        [self addSubview:_bgPicImageView];
        
        //        //logo 图
        //        _logoImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        //        [self addSubview:_logoImageView];
        
    }
    return self;
}
@end
