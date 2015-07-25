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
-(NSArray *)contactData{
    return @[
             @{
                 @"name":@"安静",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"阿美",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"昂头的向日葵",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"a小任性",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"巴黎之花",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"Balance",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"半疯半傻",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"不小心",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"潮人咖啡",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"成功",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"楚留香",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"拆家公司",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"崔永元",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"陈乔恩",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"邓小平",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"邓丽君",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"倒立的雨",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"doup",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"发愁的鱼",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"冯小胖",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"风筝",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"疯子",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"高先生",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"果冻",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"Hani",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"馄饨",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"家乡",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"亮",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"咖啡",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"麻花",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"迈向",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"Marry",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"nono",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"拿破仑",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"瓶子",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"怕黑",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"气球",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"蛐蛐",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"qloud",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"丘比特的箭",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"人民广场吃炸鸡",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"鲨鱼的泪水",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"sala",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"疼",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"天天快递",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"题目",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"王大力",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"网络",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"小米",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"小麦",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"香水有毒",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"丫头",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"樱花雨",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"阳阳阳",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"一个人",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"准驾",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"指导",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"zap",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"_大头娃娃",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"℡往事随风丶",
                 @"image":@"111.png"
                 },
             @{
                 @"name":@"╰烟消云散、",
                 @"image":@"111.png"
                 },
        
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
