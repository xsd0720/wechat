//
//  ShakeHalfView.h
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShakeDirection) {
    ShakeDirectionUp,
    ShakeDirectionDown
};

@interface ShakeHalfView : UIView

@property (nonatomic,strong) UIImageView *shakeLogoIV;
@property (nonatomic,strong) UIImageView *shakeLineIV;


-(instancetype)initWithFrame:(CGRect)frame direction:(ShakeDirection)direction shakeLogoIVName:(NSString *)logoName shakeLineIVName:(NSString *)lineName;
@end
