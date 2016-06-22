//
//  WalletHeaderView.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WalletHeaderView.h"

@implementation WalletHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(240, 239, 245);
        
        _wtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, frame.size.width-20, frame.size.height)];
        _wtitleLabel.text = @"hello";
        _wtitleLabel.font = [UIFont systemFontOfSize:14];
        _wtitleLabel.textColor = RGBCOLOR(128, 126, 123);
        [self addSubview:_wtitleLabel];
    }
    return self;
}
@end
