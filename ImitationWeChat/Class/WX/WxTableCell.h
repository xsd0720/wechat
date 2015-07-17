//
//  WxTableCell.h
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELLHEIGHT      50
@interface WxTableCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *xinMsgLabel;


@property (nonatomic,strong) UILabel *badgeLabel;
@end
