//
//  WXAVPlayerControlTopBar.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/8/2.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WXAVPlayerControlTopBar.h"

@implementation WXAVPlayerControlTopBar
/*
 *  init
 */
- (id)init
{
    self = [super init];
    if (self) {
        
        
        //加载子视图
        //加载渐变
//        [self addSubview:self.gradientLayerView];
        
        //返回按钮
        [self addSubview:self.backButton];
        
        //视频标题
        //        [self addSubview:self.movieTitleLabel];
        
        //分享按钮
        [self addSubview:self.shareButton];
        
        //回首页按钮
        [self addSubview:self.backHomeButton];
        
        
        
    }
    return self;
}

///**
// *  渐变view
// */
//- (GradientLayerView *)gradientLayerView
//{
//    if (!_gradientLayerView) {
//        _gradientLayerView = [[GradientLayerView alloc] init];
//        _gradientLayerView.direction = DirectionUP;
//    }
//    return _gradientLayerView;
//}

/*
 *   返回按钮
 */
- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        //        _backButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _backButton;
}


/*
 *   回首页
 */
- (UIButton *)backHomeButton
{
    if (!_backHomeButton) {
        _backHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backHomeButton setImage:[UIImage imageNamed:@"backHome"] forState:UIControlStateNormal];
        _backHomeButton.imageEdgeInsets = UIEdgeInsetsMake(0.5, 17, 0, 0);
    }
    return _backHomeButton;
}


/*
 *   视频标题
 */
- (UILabel *)movieTitleLabel
{
    if (!_movieTitleLabel) {
        _movieTitleLabel = [[UILabel alloc] init];
        _movieTitleLabel.textColor = [UIColor whiteColor];
//        _movieTitleLabel.font = [UIFont systemFontOfSize:movieTitleLabelFontSize];
    }
    return _movieTitleLabel;
}


/**
 *  分享按钮
 */
- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    }
    return _shareButton;
}


/*
 *   布局子视图
 */
- (void)layoutSubviews
{
    
    [super layoutSubviews];
//    self.gradientLayerView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetMaxX(self.bounds), kVideoPlayerControlTopBarHeight);

    //返回按钮
    self.backButton.frame = WXAVPlayerControlTopBarBackButtonRect;
//    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -55, 0, 0);
//    
//    //    //视频标题
//    //    self.movieTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.backButton.frame)+backButtonMarginLeft, CGRectGetMinY(self.bounds), CGRectGetMaxX(self.bounds) - backButtonWidth-backButtonMarginLeft-shareButtonMarginRight*2-shareButtonWidth, videoPlayerControlTopBarHeight);
//    //    self.movieTitleLabel.font = [UIFont systemFontOfSize:MIN(movieTitleLabelFontSize, 15.0f)];
//    
//    
//    //分享按钮
//    self.shareButton.frame = CGRectMake(CGRectGetMaxX(self.bounds)-shareButtonMarginRight*2-shareButtonWidth, 0, shareButtonWidth+shareButtonMarginRight*2, shareButtonHeight);
//    self.shareButton.center = CGPointMake(self.shareButton.center.x, self.center.y);
//    
//    self.backHomeButton.frame = CGRectMake(CGRectGetMaxX(self.bounds)-shareButtonMarginRight*2-shareButtonWidth, 0, shareButtonWidth+shareButtonMarginRight*2, backButtonHeight);
    //    self.backButton.center = CGPointMake(self.backButton.center.x, self.movieTitleLabel.center.y);
}


@end
