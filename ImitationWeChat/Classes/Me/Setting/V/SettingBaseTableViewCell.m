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

    }
    return self;
}

- (UILabel *)systemNotifiStatusLabel
{
    if (!_systemNotifiStatusLabel) {
        _systemNotifiStatusLabel = [[UILabel alloc] init];
        _systemNotifiStatusLabel.text = [SystemManager getRemoteStatus]?@"已开启":@"已关闭";
        _systemNotifiStatusLabel.textColor = RGB(145, 145, 145);
        _systemNotifiStatusLabel.frame = CGRectMake(0, 0, 44, 120);
        _systemNotifiStatusLabel.font = [UIFont systemFontOfSize:14];
    }
    return _systemNotifiStatusLabel;
}


- (UISwitch *)statusSwitch
{
    if (!_statusSwitch) {
        _statusSwitch = [[UISwitch alloc] init];
        _statusSwitch.frame = CGRectMake(0, 0, 100, 44);
    }
    return _statusSwitch;
}

- (UIImageView *)accessViewImageView
{
    if (!_accessViewImageView) {
        UIImage *im = [UIImage imageNamed:@"PaySuccess"];
        _accessViewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, im.size.width, im.size.height)];
        _accessViewImageView.image = im;
    }
    return _accessViewImageView;
}

-(void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    self.textLabel.text = datasource[@"text"];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    NSString *type = datasource[@"type"];
    if ([type isEqualToString:@"label"])
    {
        self.accessoryView = self.systemNotifiStatusLabel;
    }
    
    else if ([type isEqualToString:@"switch"])
    {
        self.accessoryView = self.statusSwitch;
    }
    
    else if ([type isEqualToString:@"system"])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else if ([type isEqualToString:@"right"])
    {
        self.accessoryView = self.accessViewImageView;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryView.hidden = YES;
    }
    
    
    
}

@end
