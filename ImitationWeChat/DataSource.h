//
//  DataSource.h
//  ImitationWeChat
//
//  Created by wany on 15/7/23.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *newXinNotificationItemStr = @"newXinNotificationItemStr";
static NSString *newXinNotificationFooterStr = @"newXinNotificationFooterStr";
static NSString *newXinNotificationHeaderStr = @"newXinNotificationHeaderStr";

#define DS        [DataSource getInstance]
static NSString *requestResult = @"requestResult";

typedef NS_ENUM(NSInteger, AccessoryType) {
    AccessoryNone,
    AccessoryNoneLabel,
    AccessoryArrow,
    AccessorySwitch,
};


/**
 微信内容类型
 */
typedef NS_ENUM(NSInteger, WXMessageType){
    WXMessageTypeNone = 0,
    WXMessageTypeText = 1,      //微信消息文本类型
    WXMessageTypeImage = 2,     //微信消息图片类型
    WXMessageTypeApp = 3,       //微信消息应用类型
    WXMessageTypeWeb = 4,       //微信消息网页类型
    WXMessageTypeMusic = 5,     //微信消息音乐类型
    WXMessageTypeVideo = 6,     //微信消息视频类型
    WXMessageTypeEmotion = 7,   //微信消息表情类型
    WXMessageTypeOther = 8      //微信消息其他多媒体类型
};


static NSString *WXMessageTypeStr = @"WXMessageType";

@interface DataSource : NSObject

/*
 MyTabBarViewController
 */
@property (nonatomic,strong) NSArray *tabbarNormalImageArray;
@property (nonatomic,strong) NSArray *tabbarHlImageArray;
@property (nonatomic,strong) NSArray *tabbarTitleArray;

/*
  QRCodeViewController
 */
@property (nonatomic,strong) NSArray *qrCodeChooseSubViewData;
/*
 ShakeViewController ChooseTabbar DataSource
 */

@property (nonatomic,strong) NSArray *shakeChooseSubViewData;


/*
 ContactViewController TableViewDatasource-contactHeaderSectionData
 */
@property (nonatomic,strong) NSDictionary *contactHeaderSectionData;
/*
 ContactViewController TableViewDatasource
 */
@property (nonatomic,strong) NSArray *contactData;
/*
 FoundViewController TableViewDataSource
 */
@property (nonatomic,strong) NSArray *discoverData;
/*
 MyViewController  TableViewDataSource
 */

@property (nonatomic,strong) NSArray *myTableData;

/*
 MyProfileViewController  TableViewDataSource
 */
@property (nonatomic, strong) NSArray *myProfileTableData;

/*
 newxinnotfication tableviewdatasouce
*/
@property (nonatomic, strong) NSArray *newXinNotificationData;

/*
 funXinNotDisturbData tableviewdatasouce
 */
@property (nonatomic, strong) NSArray *funXinNotDisturbData;

@property (nonatomic, strong) NSArray *multiLanguageData;


@property (nonatomic, strong) NSArray *privacyData;

@property (nonatomic, strong) NSArray *currencyData;

@property (nonatomic, strong) NSArray *aboutWechatData;

@property (nonatomic, strong) NSArray *timeLineSmallMovieData;

/*
 ShakeViewController   SetTableViewDataSource
 */
@property (nonatomic, strong) NSArray *shakeSetTableData;

@property (nonatomic, strong) NSArray *addfriendsData;

@property (nonatomic, strong) NSDictionary *addfriendsSearchTestData;

/*
 BottleViewController ChooseTabbar Datasource
 */
@property (nonatomic,strong) NSArray *bottleChooseSubViewData;

/*
 SendTimeLineViewController ChooseTabbar Datasource
 */
@property (nonatomic, strong) NSArray *sendTimeLineTableData;

@property (nonatomic, strong) NSArray *walletData;

@property (nonatomic, strong) NSDictionary *testProfileData;

@property (nonatomic, strong) NSDictionary *timeLineData;

/*
 @pragma: Initialize a singleton
 */
+(DataSource *)getInstance;
@end
