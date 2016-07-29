//
//  TimelineMsgTypeVideoCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineMsgTypeVideoCell.h"

@implementation TimelineMsgTypeVideoCell


- (WXAVPlayer *)wxAVPlayer
{
    if (!_wxAVPlayer) {
        _wxAVPlayer = [[WXAVPlayer alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        [self addSubview:_wxAVPlayer];
    }
    return _wxAVPlayer;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    [super setDatasource:datasource];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"782" ofType:@"mp4"];
    self.wxAVPlayer.contentURL = [NSURL fileURLWithPath:file];
   
}

- (CGFloat)MsgTypeHeight:(CGFloat)startOrginY
{
    self.wxAVPlayer.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), startOrginY+MsgTypeMarginTop, self.wxAVPlayer.width, self.wxAVPlayer.height);
    return CGRectGetMaxY(self.wxAVPlayer.frame);
}

- (void)didEndDisplayingCell
{
    [self.wxAVPlayer pause];
}
@end
