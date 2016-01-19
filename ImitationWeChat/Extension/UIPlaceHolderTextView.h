//
//  UIPlaceHolderTextView.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView
@property(nonatomic, strong) UILabel *placeHolderLabel;

@property(nonatomic, strong) NSString *placeholder;

@property(nonatomic, strong) UIColor *placeholderColor;

@end
