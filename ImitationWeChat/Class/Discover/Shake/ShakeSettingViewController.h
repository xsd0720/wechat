//
//  ShakeSettingViewController.h
//  ImitationWeChat
//
//  Created by wany on 15/7/23.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangeBgImageBlock)(UIImage *bgImage);
typedef void(^ChangeBgImageDefaultBlock)(UIImage *bgImage);
@interface ShakeSettingViewController : UIViewController
@property (nonatomic,strong) ChangeBgImageBlock changeBgImageBlock;
@property (nonatomic,strong) ChangeBgImageDefaultBlock changeBgImageDefaultBlock;
@end
