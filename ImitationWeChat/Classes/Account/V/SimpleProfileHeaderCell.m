//
//  SimpleProfileHeaderCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SimpleProfileHeaderCell.h"

static CGFloat HeaderDetailLabelLineSpacing = 7;

@implementation SimpleProfileHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.layer.cornerRadius = 5;
        self.imageView.clipsToBounds = YES;
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        self.detailTextLabel.textColor = RGB(120, 121, 122);
        self.detailTextLabel.numberOfLines = 0;
        
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
        _genderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameLabel.frame) + 5, CGRectGetMinY(self.userNameLabel.bounds), 16, 16)];
        _genderImageView.image = [UIImage imageNamed:@"Contact_Female"];
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
    
    NSString *imageName = datasource[@"image"];
    NSString *userName = datasource[@"username"];
    NSString *wechatnumber = datasource[@"wechatnumber"];
    NSString *nikename = datasource[@"nikename"];
    
    NSString *detailStr = [NSString stringWithFormat:@"微信号：%@\n昵称：%@", wechatnumber, nikename];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    self.textLabel.text = userName;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:detailStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:HeaderDetailLabelLineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detailStr length])];
    [self.detailTextLabel setAttributedText:attributedString];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(15, 10, 65, 65);
    NSDictionary *textlabelAttribute = @{NSFontAttributeName: self.textLabel.font};
    CGSize textLabelSize = [self.textLabel.text sizeWithAttributes:textlabelAttribute];
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 15, CGRectGetMinY(self.imageView.frame), textLabelSize.width, 18);
    self.genderImageView.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame), CGRectGetMinY(self.textLabel.frame), 16, 16);
    self.genderImageView.centerY = self.textLabel.centerY;
    
    
    
    CGFloat detailLabelWidth = SCREEN_WIDTH-CGRectGetMinX(self.textLabel.frame);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:HeaderDetailLabelLineSpacing];
    NSDictionary *attributes = @{NSFontAttributeName:self.detailTextLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGFloat detailTextLabelHeight = [self.detailTextLabel.text  boundingRectWithSize:CGSizeMake(detailLabelWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    
//    CGFloat detailTextLabelHeight = [self.detailTextLabel.text CalculationStringSizeWithWidth:detailLabelWidth font:self.detailTextLabel.font space:0].height;
    self.detailTextLabel.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), CGRectGetMaxY(self.textLabel.frame) + 10, SCREEN_WIDTH - CGRectGetMinX(self.userNameLabel.frame), MIN(detailTextLabelHeight, 40));
    
}

@end