//
//  SimpleProfileHeaderCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleProfileHeaderCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UIImageView *genderImageView;

@property (nonatomic, strong) UILabel *wechatNumberLabel;

@property (nonatomic, strong) UILabel *nikeNameLabel;

@property (nonatomic, strong) NSDictionary *datasource;

@end
