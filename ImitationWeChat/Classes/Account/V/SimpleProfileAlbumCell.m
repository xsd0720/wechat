//
//  SimpleProfileAlbumCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SimpleProfileAlbumCell.h"

@implementation SimpleProfileAlbumCell

- (UIView *)someAlbumView
{
    if (!_someAlbumView) {
        _someAlbumView = [[UIView alloc] initWithFrame:CGRectMake(95, 15, 365/2, 110/2)];
        _someAlbumView.backgroundColor = [UIColor redColor];
    }
    return _someAlbumView;
}

@end
