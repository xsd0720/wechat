//
//  TimelineBaseCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

#define timeLineImageOrginX         9.0f
#define timeLineImageOrginY         15.0f
#define timeLineImageSize           45.0f

#define timeLineTextLabelOrginX  (timeLineImageOrginX+timeLineImageSize+10)
#define timeLineTextLabelOrginY  (timeLineImageOrginY)
#define timeLineTextLabelWidth   (SCREEN_WIDTH-timeLineTextLabelOrginX-20)
#define timeLineTextLabelHeight     15.0f

#define timeLineDetailTextLabelFont     [UIFont systemFontOfSize:13]
#define timeLineDetailTextLabelOrginX   timeLineTextLabelOrginX
#define timeLineDetailTextLabelOrginY   (timeLineTextLabelOrginY+timeLineTextLabelHeight+7)
#define timeLineDetailTextLabelWidth    timeLineTextLabelWidth
#define timeLineDetailTextLabelMaxHeight    105.0f

#define timeLineTimeLabelHeight     15.0f

@interface TimelineBaseCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *datasource;

- (CGFloat)MsgTypeHeight:(CGFloat)startOrginY;

- (void)willDisplayCell;

- (void)didEndDisplayingCell;

@end
