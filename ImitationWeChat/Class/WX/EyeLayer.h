//
//  EyeLayer.h
//  TBPlayer
//
//  Created by xwmedia01 on 16/2/20.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>


static CGFloat EyeLayerWidth = 50;
static CGFloat EyeLayerHeight = 35;

@interface EyeLayer : UIView
@property (strong, nonatomic) CAShapeLayer *eyeFirstLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeSecondLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeballLayer;
@property (strong, nonatomic) CAShapeLayer *topEyesocketLayer;
@property (strong, nonatomic) CAShapeLayer *bottomEyesocketLayer;


- (void)animationWith:(CGFloat)y;
@end
