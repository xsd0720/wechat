//
//  AddFriendsSearchPublicNCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "AddFriendsSearchPublicNCell.h"

@implementation AddFriendsSearchPublicNCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView.layer.cornerRadius = 45/2;
    }
    return self;
}

@end
