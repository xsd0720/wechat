//
//  SimpleProfileHeaderCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SimpleProfileHeaderCell.h"

@implementation SimpleProfileHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 65, 65)];
        _headerImageView.layer.cornerRadius = 5;
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 15, CGRectGetMinX(self.headerImageView.bounds)+15, 50, 30)];
        _userNameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_userNameLabel];
        
    }
    return _userNameLabel;
}

- (UIImageView *)genderImageView
{
    if (!_genderImageView) {
        _genderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameLabel.frame) + 5, CGRectGetMinY(self.userNameLabel.bounds), 15, 15)];
        _genderImageView.image = [UIImage imageNamed:@"Contact_Male"];
        [self addSubview:_genderImageView];
    }
    return _genderImageView;
}

- (UILabel *)wechatNumberLabel
{
    if (!_wechatNumberLabel) {
        _wechatNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLabel.frame), CGRectGetMaxY(self.userNameLabel.frame) + 10, SCREEN_WIDTH - CGRectGetMinX(self.userNameLabel.frame), 15)];
        _wechatNumberLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_wechatNumberLabel];
    }
    return _wechatNumberLabel;
}


- (UILabel *)nikeNameLabel
{
    if (!_nikeNameLabel) {
        _nikeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLabel.frame), CGRectGetMaxY(self.wechatNumberLabel.frame) + 10, SCREEN_WIDTH - CGRectGetMinX(self.userNameLabel.frame), 15)];
        _nikeNameLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_nikeNameLabel];
    }
    return _nikeNameLabel;
}



- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
}

@end