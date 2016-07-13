//
//  PresentAnimator.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/13.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect startRect;

@property (nonatomic, assign) CGSize startSize;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, strong) UIColor *startViewColor;

@end
