//
//  TimelineBaseCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineBaseCell.h"

@interface TimelineBaseCell()

//时间
@property (nonatomic, strong) UILabel *timeLabel;

//删除按钮
@property (nonatomic, strong) UIButton *delButton;

@end

@implementation TimelineBaseCell

#pragma mark -
#pragma mark -- base config

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)delButton
{
    if (!_delButton) {
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delButton setTitle:@"删除" forState:UIControlStateNormal];
        _delButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_delButton setTitleColor:RGB(128, 130, 146) forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(delButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_delButton];
    }
    return _delButton;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.textColor = RGB(92, 98, 139);
        self.textLabel.font = [UIFont boldSystemFontOfSize:13];
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.font = timeLineDetailTextLabelFont;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


#pragma mark - 
#pragma mark -- cofig cell data
- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    NSString *imageName = datasource[@"image"];
    NSString *username = datasource[@"username"];
    NSString *detailtext = datasource[@"detail"];
    NSString *timestr = datasource[@"time"];
//    NSString *mediaType = datasource[@"mediaType"];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    self.textLabel.text = username;
    self.detailTextLabel.text = detailtext;
    self.timeLabel.text = timestr;
}



#pragma mark - 
#pragma mark -- Event

/**
 *  删除按钮
 */
- (void)delButtonClick
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"删除",@"取消", nil];
    [alertView show];
}


#pragma mark - 
#pragma mark -- layoutsubviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(timeLineImageOrginX, timeLineImageOrginY, timeLineImageSize, timeLineImageSize);
    
    self.textLabel.frame = CGRectMake(timeLineTextLabelOrginX, timeLineTextLabelOrginY, timeLineTextLabelWidth, timeLineTextLabelHeight);
    
    
    CGFloat detailTextLabelHeight = [self.detailTextLabel.text CalculationStringSizeWithWidth:timeLineDetailTextLabelWidth font:self.detailTextLabel.font space:0].height;
    self.detailTextLabel.frame = CGRectMake(timeLineDetailTextLabelOrginX, timeLineDetailTextLabelOrginY, timeLineDetailTextLabelWidth, detailTextLabelHeight);
    
    CGFloat startOrginY = CGRectGetMaxY(self.detailTextLabel.frame);
    
    startOrginY = [self MsgTypeHeight:startOrginY];
    
    CGFloat timeLabelWidth = [self.timeLabel.text sizeWithAttributes:@{NSFontAttributeName: self.timeLabel.font}].width;
    self.timeLabel.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), startOrginY+8, timeLabelWidth+20, timeLineTimeLabelHeight);
    
    self.delButton.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), CGRectGetMinY(self.timeLabel.frame), 50, 15);
    self.delButton.centerY = self.timeLabel.centerY;
}


- (CGFloat)MsgTypeHeight:(CGFloat)startOrginY
{
    return CGRectGetMaxY(self.detailTextLabel.frame);
}

@end
