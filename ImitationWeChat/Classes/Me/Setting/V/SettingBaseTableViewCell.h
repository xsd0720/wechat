//
//  SettingBaseTableViewCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *systemNotifiStatusLabel;

@property (nonatomic, strong) UISwitch *statusSwitch;

@property (nonatomic, strong) NSDictionary *datasource;

@end
