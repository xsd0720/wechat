//
//  WxTableCell.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "WxTableCell.h"
#define Padding  5
@implementation WxTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 5;
        [self addSubview:_headImageView];
        
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_userNameLabel];
        
        
        _xinMsgLabel = [[UILabel alloc] init];
        _xinMsgLabel.textColor = [UIColor grayColor];
        _xinMsgLabel.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_xinMsgLabel];
        
        
    
//        _badgeLabel = [[UILabel alloc] init];
//        _badgeLabel.backgroundColor = [UIColor ];
//        [self addSubview:_badgeLabel];
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
//    NSString *imageUrl = [dic valueForKey:@"head"];
    NSString *userName = [dic valueForKey:@"name"];
    NSString *xinMsg = [dic valueForKey:@"msg"];
    
    
    _headImageView.image = [UIImage imageNamed:@"000"];
    _userNameLabel.text = userName;
    _xinMsgLabel.text = xinMsg;
    
    
    [_headImageView setFrame:CGRectMake(Padding*2, Padding, CELLHEIGHT-Padding*2, CELLHEIGHT-Padding*2)];
    [_userNameLabel setFrame:CGRectMake(getViewWidth(_headImageView)+10, _headImageView.frame.origin.y,SCREEN_WIDTH-getViewWidth(_headImageView),getViewHeight(_headImageView)/2)];
    [_xinMsgLabel setFrame:CGRectMake(_userNameLabel.frame.origin.x, getViewHeight(_userNameLabel), CGRectGetWidth(_userNameLabel.frame), CGRectGetHeight(_userNameLabel.frame))];
    

    

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
