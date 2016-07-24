//
//  TimelineBaseCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineCellHeight.h"

@interface TimelineBaseCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *datasource;

- (CGFloat)MsgTypeHeight:(CGFloat)startOrginY;

- (void)willDisplayCell;

- (void)didEndDisplayingCell;

@end
