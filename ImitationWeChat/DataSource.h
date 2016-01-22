//
//  DataSource.h
//  ImitationWeChat
//
//  Created by wany on 15/7/23.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DS        [DataSource getInstance]
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
 ShakeViewController   SetTableViewDataSource
 */
@property (nonatomic,strong) NSArray *shakeSetTableData;


/*
 BottleViewController ChooseTabbar Datasource
 */
@property (nonatomic,strong) NSArray *bottleChooseSubViewData;

/*
 SendTimeLineViewController ChooseTabbar Datasource
 */
@property (nonatomic, strong) NSArray *sendTimeLineTableData;

@property (nonatomic, strong) NSArray *walletData;

/*
 @pragma: Initialize a singleton
 */
+(DataSource *)getInstance;
@end
