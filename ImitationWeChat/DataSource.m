//
//  DataSource.m
//  ImitationWeChat
//
//  Created by wany on 15/7/23.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+(DataSource *)getInstance{
    static DataSource *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DataSource alloc]init];
    });
    return _instance;
}

-(NSArray *)tabbarNormalImageArray{
    return @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
}
-(NSArray *)tabbarHlImageArray{
    return @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
}
-(NSArray *)tabbarTitleArray{
    return @[@"微信",@"联系人",@"发现",@"我"];
}



-(NSArray *)qrCodeChooseSubViewData{
    return @[
             
             @{
                 @"imageName":@"ScanQRCode",
                 @"imageName_HL":@"ScanQRCode_HL",
                 @"text":@"扫码"
                 },
             @{
                 @"imageName":@"ScanBook",
                 @"imageName_HL":@"ScanBook_HL",
                 @"text":@"封面"
                 },
             @{
                 @"imageName":@"ScanStreet",
                 @"imageName_HL":@"ScanStreet_HL",
                 @"text":@"街景"
                 },
             @{
                 @"imageName":@"ScanWord",
                 @"imageName_HL":@"ScanWord_HL",
                 @"text":@"翻译"
                 }
             ];
}


-(NSArray *)shakeChooseSubViewData{
    return @[
             
             @{
                 @"imageName":@"Shake_icon_people",
                 @"imageName_HL":@"Shake_icon_peopleHL",
                 @"text":@"人"
                 },
             @{
                 @"imageName":@"Shake_icon_music",
                 @"imageName_HL":@"Shake_icon_musicHL",
                 @"text":@"歌曲"
                 },
             @{
                 @"imageName":@"Shake_icon_tv",
                 @"imageName_HL":@"Shake_icon_tvHL",
                 @"text":@"电视"
                 }
             ];
}

-(NSArray *)discoverData{
    return @[
             @[
                 @{@"image":@"ff_IconShowAlbum",
                   @"text":@"朋友圈"}
                 
                 ],
             @[
                 @{@"image":@"ff_IconQRCode",
                   @"text":@"扫一扫"},
                 @{@"image":@"ff_IconShake",
                   @"text":@"摇一摇"}
                 ],
             
             @[
                 @{@"image":@"ff_IconLocationService",
                   @"text":@"附近的人"},
                 @{@"image":@"ff_IconBottle",
                   @"text":@"漂流瓶"}
                 ]
             
             
             ];
}

-(NSArray *)myTableData{
    return @[
             @[
                 @{@"image":@"000",
                   @"text":@"大头娃娃"}
                 ],
             @[
                 @{@"image":@"MoreMyAlbum",
                   @"text":@"相册"},
                 @{@"image":@"MoreMyFavorites",
                   @"text":@"收藏"},
                 @{@"image":@"MoreMyBankCard",
                   @"text":@"钱包"},
                 @{@"image":@"MyCardPackageIcon",
                   @"text":@"卡包"},
                 
                 ],
             @[
                 @{@"image":@"MoreExpressionShops",
                   @"text":@"表情"}
                 ],
             @[
                 
                 @{@"image":@"MoreSetting",
                   @"text":@"设置"},
                 @{@"image":@"MoreSetting",
                   @"text":@"电视直播"}
                 ]
             
             ];
}


-(NSArray *)shakeSetTableData{
    return @[
             @[
                 @{
                     @"text":@"使用默认背景图片",
                     @"type":@"arrow"
                     },
                 @{
                     @"text":@"换张背景图片",
                     @"type":@"arrow"
                     },
                 @{
                     @"text":@"音效",
                     @"type":@"switch"
                     }
                 ],
             @[
                 @{
                     @"text":@"打招呼的人",
                     @"type":@"arrow"
                     },
                 @{
                     @"text":@"摇到的历史",
                     @"type":@"arrow"
                     },
                 ],
             @[
                 @{
                     @"text":@"摇一摇消息",
                     @"type":@"arrow"
                     }
                 ]
             ];
}
-(NSArray *)bottleChooseSubViewData{
    return @[
             
             @{
                 @"imageName":@"bottleButtonThrow",
                 @"text":@"扔一个"
                 },
             @{
                 @"imageName":@"bottleButtonFish",
                 @"text":@"捡一个"
                 },
             @{
                 @"imageName":@"bottleButtonMine",
                 @"text":@"我的瓶子"
                 }
             ];
}
@end
