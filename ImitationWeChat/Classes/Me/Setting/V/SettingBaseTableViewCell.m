//
//  SettingBaseTableViewCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SettingBaseTableViewCell.h"

@implementation SettingBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _systemNotifiStatusLabel = [[UILabel alloc] init];
        _systemNotifiStatusLabel.text = [SystemManager getRemoteStatus]?@"已开启":@"已关闭";
        _systemNotifiStatusLabel.textColor = RGB(145, 145, 145);
        _systemNotifiStatusLabel.frame = CGRectMake(0, 0, 44, 120);
        _systemNotifiStatusLabel.font = [UIFont systemFontOfSize:14];
        
        _statusSwitch = [[UISwitch alloc] init];
        _statusSwitch.frame = CGRectMake(0, 0, 100, 44);
        
        _statusSwitch.hidden = YES;
        _systemNotifiStatusLabel.hidden = YES;
    }
    return self;
}


-(void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    self.textLabel.text = datasource[@"text"];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    NSString *type = datasource[@"type"];
    if ([type isEqualToString:@"label"])
    {
        self.accessoryView = _systemNotifiStatusLabel;
    }
    
    else if ([type isEqualToString:@"switch"])
    {
        self.accessoryView = _statusSwitch;
    }
    
    else if ([type isEqualToString:@"system"])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    self.accessoryView.hidden = NO;
    
}

@end
