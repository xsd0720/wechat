//
//  TimelineCellHeight.h
//  ImitationWeChat
//
//  Created by wany on 16/7/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"

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

#define onlyImageViewMaxSize            150.0f
#define timeLineCollectionItemSize      75.0f
#define timeLineCollectionItemPadding   5.0f

#define MsgTypeMarginTop        8

#define timeLineTimeLabelHeight     15.0f

@interface TimelineCellHeight : NSObject

+ (CGFloat)height:(NSDictionary *)datasource;

+ (CGFloat)imagesHeight:(NSDictionary *)datasource;

@end
