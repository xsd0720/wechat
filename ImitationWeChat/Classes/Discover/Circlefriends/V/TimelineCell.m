//
//  TimelineCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/20.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineCell.h"

@implementation TimelineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.numberOfLines = 0;
    }
    return self;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.text = @"1分钟前";
    }
    return _timeLabel;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    NSString *imageName = datasource[@"image"];
    NSString *username = datasource[@"username"];
    NSString *detailtext = datasource[@"detail"];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    self.textLabel.text = username;
    self.detailTextLabel.text = detailtext;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(9, 15, 45, 45);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+10, CGRectGetMinY(self.imageView.frame)+3, SCREEN_WIDTH-(CGRectGetMaxX(self.imageView.frame)+10), 15);
    self.detailTextLabel.originY = CGRectGetMaxY(self.textLabel.frame)+10;
    self.detailTextLabel.originX = CGRectGetMinX(self.textLabel.frame);
}

@end
