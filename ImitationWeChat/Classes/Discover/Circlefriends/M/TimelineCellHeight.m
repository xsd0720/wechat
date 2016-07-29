//
//  TimelineCellHeight.m
//  ImitationWeChat
//
//  Created by wany on 16/7/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineCellHeight.h"
#import "math.h"
@implementation TimelineCellHeight

+ (CGFloat)height:(NSDictionary *)datasource
{
    
    NSString *detailtext = datasource[@"detail"];
    CGFloat detailTextLabelHeight = [detailtext CalculationStringSizeWithWidth:timeLineDetailTextLabelWidth font:timeLineDetailTextLabelFont space:0].height;
    NSString *messageType = datasource[WXMessageTypeKey];
    
    CGFloat messageTypeHeight = 0.0;
    CGFloat padding = 8;
    switch (messageType.intValue) {
        case WXMessageTypeText:
        {
            
        }
            break;
        case WXMessageTypeImage:
        {
            messageTypeHeight = [self imagesHeight:datasource].height;
            
        }
            break;
        case WXMessageTypeApp:
        {
            messageTypeHeight = 50;
        }
            break;
        case WXMessageTypeWeb:
        {
            messageTypeHeight = 50;
        }
            break;
        case WXMessageTypeMusic:
        {
            messageTypeHeight = 50;
        }
            break;
        case WXMessageTypeVideo:
        {
            messageTypeHeight = 150;
        }
            break;
        case WXMessageTypeEmotion:
        {
            
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    
    if (messageTypeHeight > 0) {
        messageTypeHeight += padding;
    }
    
    return timeLineDetailTextLabelOrginY+detailTextLabelHeight+8+messageTypeHeight+timeLineTimeLabelHeight+15;
}

+ (CGSize)imagesHeight:(NSDictionary *)datasource
{
    NSArray *images = datasource[WXMessageTypeDataKey];
    if (images.count > 0) {
        if (images.count > 1) {
            CGFloat totalRowCount = images.count>3?images.count/3+fmod(images.count, 3):1;
            return CGSizeMake(235, totalRowCount*timeLineCollectionItemSize+((totalRowCount-1)*timeLineCollectionItemPadding));
        }else
        {
            UIImage *image = [UIImage imageNamed:[images firstObject]];
            CGSize oneSize = [image limitMaxWidthHeight:150 maxH:150];
            return oneSize;
        }
    }
    return CGSizeZero;
}

@end
