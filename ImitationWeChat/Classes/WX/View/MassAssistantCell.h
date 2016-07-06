//
//  MassAssistantCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/1.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Category.h"
@interface MassAssistantCell : UITableViewCell

@property (nonatomic, strong) UIButton *bgButtonView;

@property (nonatomic, strong) UIImageView *mailapp_arrow;

@property (nonatomic, strong) UIView *receiveTitleView;

@property (nonatomic, strong) UILabel *receivePeoplesLabel;

@property (nonatomic, strong) NSDictionary *datasource;

@property (nonatomic, strong) UIView *sendContentView;

@property (nonatomic, strong) UIImageView *sendContentImageView;

@property (nonatomic, strong) UIImage *sendContentImage;

@property (nonatomic, strong) UIButton *reSendButton;

@property (nonatomic, assign) BOOL isopen;

@end
