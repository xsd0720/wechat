//
//  WalletCollectionViewCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELLSIZEWIDTH  ((SCREEN_WIDTH-(fmod(SCREEN_WIDTH, 3) == 0? 3:fmod(SCREEN_WIDTH, 3)))/3)
#define CELLSIZEHEIGHT  (195.0/2)

@interface WalletCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton *iconImageView;

@property (nonatomic, strong) UILabel *iconTextLabel;

@property (nonatomic, strong) NSDictionary *datasource;


@end
