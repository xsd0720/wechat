//
//  WXAVPlayerControlTopBar.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/8/2.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXAVPlayerControlTopBar : UIView
//返回button
@property (nonatomic, strong) UIButton  *backButton;

//视频标题
@property (nonatomic, strong) UILabel   *movieTitleLabel;

//分享
@property (nonatomic, strong) UIButton  *shareButton;

//回首页
@property (nonatomic, strong) UIButton  *backHomeButton;

//渐变view
//@property (nonatomic, strong) GradientLayerView *gradientLayerView;
@end
