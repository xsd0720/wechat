
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

- (NSDictionary *)contactHeaderSectionData
{
    return @{
             @"capIndex":@"search",
             @"contacts":@[
                @{
                    @"name":@"新的朋友",
                    @"image":@"plugins_FriendNotify"
                     },
                @{
                    @"name":@"群聊",
                    @"image":@"add_friend_icon_addgroup"
                    },
                @{
                    @"name":@"标签",
                    @"image":@"Contact_icon_ContactTag"
                    },
                @{
                    @"name":@"公众号",
                    @"image":@"add_friend_icon_offical"
                    }
                 ]
             };
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
                   @"text":@"设置"}
//                 ,
//                 @{@"image":@"MoreSetting",
//                   @"text":@"电视直播"}
                 ]
             
             ];
}


- (NSArray *)myProfileTableData
{
    return @[
             @[
                 @{@"obj":@"000",
                   @"type":@"1",
                   @"text":@"头像"},
                 @{@"obj":@"王辉",
                   @"type":@"0",
                   @"text":@"名字"},
                 @{@"obj":@"aywanghui",
                   @"type":@"0",
                   @"text":@"微信号"},
                 @{@"obj":@"setting_myQR",
                   @"type":@"1",
                   @"text":@"我的二维码"},
                 @{@"obj":@"",
                   @"type":@"0",
                   @"text":@"我的地址"}
                 ],
             @[
                 @{@"obj":@"男",
                   @"type":@"0",
                   @"text":@"性别"},
                 @{@"obj":@"北京",
                   @"type":@"0",
                   @"text":@"地区"},
                 @{@"obj":@"五年。。。",
                   @"type":@"0",
                   @"text":@"个性签名"}
                 ],
             @[
                 @{@"obj":@"未设置",
                   @"type":@"0",
                   @"text":@"LinkedLn账号"}
                 ],
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

- (NSArray *)newXinNotificationData
{
    return @[
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"接收新消息通知",
                             @"type":@"label",
                             }
                         
                         ],
                 newXinNotificationFooterStr:@"如果你要关闭或开启微信的新消息通知，请在iPhone的”设置“ - ”通知“功能中，找到应用程序”微信“更改。"
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"通知显示消息详情",
                             @"type":@"switch",
                             }
                         
                         ],
                 newXinNotificationFooterStr:@"关闭后，当收到微信消息时，通知提示将不显示发信人和内容摘要。"
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"功能消息免打扰",
                             @"type":@"system",
                             }
                         
                         ],
                 newXinNotificationFooterStr:@"设置系统功能消息提示声音和振动的时段。"
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"声音",
                             @"type":@"switch",
                             },
                         @{
                             @"text":@"振动",
                             @"type":@"switch",
                             },
                         ],
                 newXinNotificationFooterStr:@"当微信运行时，你可以设置是否需要声音或者振动。"
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"朋友圈照片更新",
                             @"type":@"switch",
                             }
                         
                         ],
                 newXinNotificationFooterStr:@"关闭后，有朋友更新照片时，界面下面的“发现”切换按钮上不再显示红点提示。"
                 },
             ];
}

- (NSArray *)multiLanguageData
{
    return @[
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"简体中文",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"繁體中文(台灣)",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"繁體中文(香港)",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Bahasa Indonesia",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Bahasa Melayu",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Español",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"한국어",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"にほんご",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Polski",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Português",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Русский",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"తెలుగు",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Tiếng Việt",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"ગુજરાતી",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"ქართული",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Български",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Türkçe",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Deutsch",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"Français",
                             @"type":@"right",
                             },
                         ],
                 },
             ];
}


- (NSArray *)funXinNotDisturbData
{
    return @[
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"开启",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"只在夜间开启",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"关闭",
                             @"type":@"right",
                             }
                         ],
                 newXinNotificationFooterStr:@"开启后，“QQ邮箱提醒”在收到邮件后，手机不会震动于发出提示音。如果设置为“只在夜间开启”，则只在22:00到8:00生效。"
                 },
             ];
}


- (NSArray *)addfriendsData
{
    return @[
             @{
                 @"text":@"雷达加朋友",
                 @"dText":@"添加身边的朋友",
                 @"image":@"add_friend_icon_reda"
                 },
             @{
                 @"text":@"面对面建群",
                 @"dText":@"与身边的朋友进入同一个群聊",
                 @"image":@"add_friend_icon_addgroup"
                 },
             @{
                 @"text":@"扫一扫",
                 @"dText":@"扫描二维码名片",
                 @"image":@"add_friend_icon_scanqr"
                 },
             @{
                 @"text":@"手机联系人",
                 @"dText":@"添加通讯录中的朋友",
                 @"image":@"add_friend_icon_contacts"
                 },
             @{
                 @"text":@"公众号",
                 @"dText":@"获取更多资讯和服务",
                 @"image":@"add_friend_icon_offical"
                 },
             ];
}


- (NSDictionary *)addfriendsSearchTestData
{
    
    
    return @{
             
             @"status":@"OK",
             @"status_code":@"200",
             requestResult:@{
                     @"person": @[
                             @{
                                 @"text":@"赵丽颖",
                                 @"dText":@"《花千骨》主演，1987年10月16日，赵丽颖出生于河北廊坊市一个普通的农民家庭",
                                 @"image":@"zhaoliying.jpg",
                                 },
                             @{
                                 @"text":@"刘诗诗",
                                 @"dText":@"中国内地影视女演员，毕业于北京舞蹈学院芭蕾舞专业2006届本科班。",
                                 @"image":@"liushishi.jpg",
                                 },
                             ],
                     @"public":@[
                             
                             @{
                                 @"text":@"公众号1",
                                 @"dText":@"谁动了出租车的奶酪？打车软件上的“专车”服务突然成为众矢之的。围绕着“专车”、黑车、出租车，引发了关于中国出租车行业的一场大讨论",
                                 @"image":@"head1.jpg",
                                 },
                             @{
                                 @"text":@"公众号2",
                                 @"dText":@"更好2015：16家权威智库预测中国16大领域",
                                 @"image":@"head2.jpg",
                                 },
                             @{
                                 @"text":@"公众号3",
                                 @"dText":@"在今年率先进行的10+8会议上，李克强开宗明义谈起了政治安全。并且明确了处理南海问题“双轨思路”",
                                 @"image":@"head3.jpg",
                                 },
                             @{
                                 @"text":@"公众号4",
                                 @"dText":@"中国新闻周刊由中国新闻社主办，创办于1999年9月，2000年1月1日正式出版发行。",
                                 @"image":@"head4.jpg",
                                 },
                             @{
                                 @"text":@"公众号5",
                                 @"dText":@"新浪网新闻中心是新浪网最重要的频道之一,24小时滚动报道国内、国际及社会新闻。每日编发新闻数以万计。",
                                 @"image":@"head5.jpg",
                                 },
                             @{
                                 @"text":@"公众号6",
                                 @"dText":@"百度新闻是包含海量资讯的新闻服务平台,真实反映每时每刻的新闻热点。您可以搜索新闻事件、热点话题、人物动态、产品资讯等,快速了解它们的最新进展。",
                                 @"image":@"head6.jpg",
                                 },
                             @{
                                 @"text":@"公众号7",
                                 @"dText":@"搜狐视频新闻频道是中文互联网成立最早,最权威的视频新闻门户,为用户提供最新最全面的时事、财经、社会、法制、娱乐、体育等视频资讯,看动感新闻,洞悉世间天下事。",
                                 @"image":@"head7.jpg",
                                 },
                             ],
                     }
             
             };
}

- (NSArray *)timeLineSmallMovieData
{
    return @[
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"3G/4G 和 WIFI",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"仅WIFI",
                             @"type":@"right",
                             },
                         @{
                             @"text":@"关闭",
                             @"type":@"right",
                             }
                         ],
                 newXinNotificationHeaderStr:@"朋友圈自动播放小视频"
                 },
             ];

}

- (NSArray *)privacyData
{
    return @[
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"加我为朋友时需要验证",
                             @"type":@"switch",
                             }
                         ],
                 newXinNotificationHeaderStr:@"通讯录",
                 newXinNotificationFooterStr:@"",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"通过QQ号搜索到我",
                             @"type":@"switch",
                             }
                         ],
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"可通过手机号搜索到我",
                             @"type":@"switch",
                             },
                         @{
                             @"text":@"向我推荐通讯录好友",
                             @"type":@"switch",
                             }
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"开启后，为你推荐已经开通微信的手机联系人",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"通过微信号搜索到我",
                             @"type":@"switch",
                             }
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"关闭后，其他用户将不能通过微信号搜索到你",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"通讯录黑名单",
                             @"type":@"system",
                             }
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"",
                 },
             
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"不让他(她)看我的朋友圈",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"不看他(她)的朋友圈",
                             @"type":@"system",
                             },
                         ],
                 newXinNotificationHeaderStr:@"朋友圈",
                 newXinNotificationFooterStr:@"",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"允许陌生人查看十张照片",
                             @"type":@"switch",
                             }
                         ],
                 newXinNotificationFooterStr:@"",
                 newXinNotificationHeaderStr:@"",
                 },

             
             ];
}


- (NSArray *)currencyData
{
    return @[
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"多语言",
                             @"type":@"system",
                             }
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"字体大小",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"聊天背景",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"我的表情",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"朋友圈小视频",
                             @"type":@"system",
                             },
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"听筒模式",
                             @"type":@"switch",
                             },
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"功能",
                             @"type":@"system",
                             }
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"",
                 },
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"聊天记录迁移",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"清理微信存储空间",
                             @"type":@"system",
                             },
                         ],
                 newXinNotificationHeaderStr:@"",
                 newXinNotificationFooterStr:@"",
                 },
             
             
             ];

}

- (NSArray *)aboutWechatData
{
    return @[
             @{
                 newXinNotificationItemStr:@[
                         @{
                             @"text":@"去评分",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"功能介绍",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"系统通知",
                             @"type":@"system",
                             },
                         @{
                             @"text":@"投诉",
                             @"type":@"system",
                             },
                         ],
                 },
             ];
}

- (NSArray *)walletData
{
    return @[
             @[
                 @{
                     @"text":@"付款",
                     @"image":@"arrow"
                     },
                 @{
                     @"text":@"零钱",
                     @"image":@"arrow"
                     },
                 @{
                     @"text":@"银行卡",
                     @"image":@"switch"
                     }
                 ],
             @[
                 @{
                     @"text":@"转账",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"手机充值",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"理财通",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"Q币充值",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"生活缴费",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"城市服务",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"信用卡还款",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"微信红包",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"AA收款",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"腾讯公益",
                     @"image":@"wallet"
                     },
                 ],
             @[
                 @{
                     @"text":@"滴滴出行",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"火车票机票",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"美丽说",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"京东精选",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"电影票",
                     @"image":@"wallet"
                     },
                 @{
                     @"text":@"吃喝玩乐",
                     @"image":@"wallet"
                     },
                 ]
             ];

}

- (NSArray *)sendTimeLineTableData
{
    return @[
             @[
                 @{
                     @"text":@"所在位置",
                     @"image":@"AlbumLocationIcon"
                     }
                 ],
             @[
                 @{
                     @"text":@"谁可以看",
                     @"image":@"AlbumGroupIcon"
                     },
                 @{
                     @"text":@"提醒谁看",
                     @"image":@"AlbumMentionIcon"
                     }
                 ]
             ];

}


- (NSDictionary *)testProfileData
{
    return @{
             @"status":@"OK",
             @"status_code":@"200",
             @"profile":@{
                     @"image":@"anglebady.jpg",
                     @"username":@"杨颖",
                     @"wechatnumber":@"anglebady_1989",
                     @"nikename":@"Molly",
                     @"area":@"上海 福东新区",
                     },
             
             @"alb":@[
                     
                     @{
                         @"text":@"地区",
                         @"type":@"text",
                         @"data":@"北京 朝阳",
                         },
                     @{
                         @"text":@"个人相册",
                         @"type":@"album",
                         @"data":@[
                                 @"anglebady1.jpg",
                                 @"anglebady2.jpg",
                                 @"anglebady3.jpg",
                                 ],
                         },
                     
                     @{
                         @"text":@"更多",
                         @"type":@"more",
                         @"data":@[
                                 
                                 @{
                                     @"text":@"个性签名",
                                     @"qianming":@"秋天，秋天，你来了？",
                                     },
                                 @{
                                     @"text":@"来源",
                                     @"from":@"通过扫一扫添加",
                                     },
                                 ]
                         }
                     ],
             };
}


- (NSDictionary *)timeLineData
{
    return @{
             @"status":@"OK",
             @"status_code":@"200",
             requestResult:@[
                     @{
                         @"image":@"haoyou2.jpg",
                         @"username":@"好友1",
                         @"detail":@"宝宝这会多想有条船",
                         @"time":@"1分钟前",
                         },
                     
                     @{
                         @"image":@"haoyou3.jpg",
                         @"username":@"好友2",
                         @"detail":@"今天者大雨天有着凉了，闹肚子闹一天，转被窝还直打喷嚏，晚上吃什么呢😄",
                         @"time":@"2分钟前",
                         },
                     ],
             };
}

@end
