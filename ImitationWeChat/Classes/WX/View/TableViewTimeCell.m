//
//  TableViewTimeCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/1.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TableViewTimeCell.h"
#import "NSString+Time.h"
@implementation TableViewTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 42, 20)];
//        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.text = [NSString getTimeWithFormat:nil date:[NSDate date]];
        _timeLabel.textAlignment = 1;
        _timeLabel.layer.cornerRadius = 5;
        _timeLabel.clipsToBounds = YES;

        
        
        
        _timeLabelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 42, 22)];
        _timeLabelView.backgroundColor = [RGB(210, 210, 215) colorWithAlphaComponent:0.7];
        _timeLabelView.layer.cornerRadius = 5;
        _timeLabelView.clipsToBounds = YES;
        [self addSubview:_timeLabelView];
        [_timeLabelView addSubview:_timeLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _timeLabelView.centerY = self.bounds.size.height/2;
    _timeLabelView.centerX = self.bounds.size.width/2;
    
    _timeLabel.centerY = _timeLabelView.bounds.size.height/2;
    _timeLabel.centerX = _timeLabelView.bounds.size.width/2;
}

@end
