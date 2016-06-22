//
//  PublicNetwork.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 15/7/29.
//  Copyright (c) 2015年 zp. All rights reserved.
//

#ifndef ImitationWeChat_PublicNetwork_h
#define ImitationWeChat_PublicNetwork_h


/**
 *  请求头(测试)
 */

#ifdef DEBUG

#define LWHttpHead            @"123.57.207.48"

//#define LWHttpHead             @"182.92.23.2"

#define LWShareHttpHead        @"http://lilslb.com"

#else

//#define LWHttpHead             @"182.92.23.2"
#define LWHttpHead            @"123.57.207.48"

#define LWShareHttpHead        @"http://lilslb.com"

#endif


#pragma mark -  account(账号) -
/**
 *  注册
 */
#define LWRegisURL              @"/account/register"

/**
 *  登录
 */
#define LWLoginURL              @"/account/login"

/**
 *  登出
 */
#define LWLogoutURL             @"/account/logout"

/**
 *  忘记密码
 */
#define LWForgetURL             @"/account/forget"

/**
 *  个人简介
 */
#define LWProfileURL            @"/account/profile"

/**
 *  个人简介更新
 */
#define LWUpdateURL             @"/account/update"

/**
 *  手机号码修改
 */
#define LWUpdatemobileURL       @"/account/updatemobile"

/**
 *  用户名修改
 */
#define LWUpdateusernameURL     @"/account/updateusername"


/**
 *  七牛上传图片token
 */
#define LWQiniutokenURL         @"/account/qiniutoken"

/**
 *  发送验证码
 */
#define LWRequestsnsURL         @"/account/requestsns"

/**
 *  验证验证码
 */
#define LWCheckvcodeURL         @"/account/checkvcode"

/**
 *  三方登录
 */
#define LWLoginFromThirdURL     @"/account/loginfromthird"

/**
 *  绑定第三方账号
 */
#define LWBindThirdAccountURL   @"/account/bindthirdaccount"

/**
 *  忘记密码修改密码
 */
#define LWUpdateuserpsdURL     @"/account/updateuserpsd"

/**
 *  修改头像
 */
#define LWChangeheadpic         @"/account/changeheadpic"

/*
 *  获取我的QA评论
 */
#define LWGetqalist            @"/account/getqalist"


/**
 *  更改各个通知的状态
 */
#define LWChangenotif            @"/account/changenotif"


#pragma mark -  video(视频) -

/**
 *  视频列表
 */
#define LWGetVideoListURL       @"/video/v2/getlist"


/**
 *  关注的自媒体人视频列表
 */
#define LWGetFollowListURL       @"/video/getfollowlist"

/**
 *  视频详情
 */
#define LWGetVideoDetailURL     @"/video/getdetail"


#pragma mark -  comment(评论) -

/**
 *  评论列表
 */
#define LWGetCommentListURL     @"/comment/getlist"

/**
 *  回答的回复列表
 */
#define LWGetQAreplylist        @"/comment/getqareplylist"

/**
 *  发表评论
 */
#define LWCommentPostURL        @"/comment/post"




/**
 *  评论投票
 */
#define LWCommentVoteURL        @"/comment/vote"
/**
 *  踩投票
 */
#define LWCommentUnVoteURL      @"/comment/unvote"
/**
 *  获取热门评论
 */
#define LWGethotlistURL         @"/comment/gethotlist"

/**
 *  通过评论ids获取评论详情
 */
#define LWGetCommentByIdsURL       @"/comment/getcommentbyids"

/**
 *  获取评论总分
 */
#define LWGetCommentGetscoreURL       @"/comment/getscore"

/**
 *  回复评论
 */
#define LWReplyCommentURL             @"/comment/reply"

/*
 *  通过用户获取评论/回复列表
 */
#define LWGetcommentGetlistbyuserURL       @"/comment/getlistbyuser"

/**
 *  关注
 */
#define LWFollowURL             @"/followship/follow"


/**
 *  取消关注
 */
#define LWUnFollowURL           @"/followship/unfollow"


/**
 *  关注的自媒体人列表
 */
#define LWFolloweesURL          @"/followship/getfollowees"


/**
 *  搜索
 */
#define LWSearchURL             @"/search/search"


/**
 *  热搜列表
 */
#define LWSearchSuggestionURL   @"/search/suggest"


/**
 *  自媒体人个人信息
 */
#define LWJournalistsGetprofileURL     @"/journalists/getprofile"


/**
 *  自媒体人videolist
 */
#define LWJournalistsGetVideosURL      @"/journalists/getvideos"


/**
 *  获取自媒体人评论列表
 */
#define LWJournalistsGetcommentsURL    @"/journalists/getcomments"

/**
 *  获取物流信息
 */
#define LWJuheURL                      @"http://v.juhe.cn/exp/index"

/**
 *  获取自媒体人商品列表
 */
#define LWShopGetItemsURL              @"/shop/getitems"

/**
 *  通过id列表 获取item
 */
#define LWShopGetItemsByIdsUrl         @"/shop/getitemsbyids"

/**
 *  获取商品详情
 */
#define LWShopGetItemDetailURL         @"/shop/getitemdetail"


/**
 *  获取预支付对象
 */
#define LWShopAddTradeURL               @"/shop/addtrade"


/**
 *  获取订单列表
 */
#define LWShopGettradestatusURL         @"/shop/gettradestatus"

/**
 *  获取支付结果
 */
#define LWShopGetpaymentinfoURL         @"/shop/getpaymentinfo"


/**
 *  获取收货地址列表
 */
#define LWShopGetAddressURL         @"/shop/getaddress"


/**
 *  增加收货地址
 */
#define LWShopAddAddressURL         @"/shop/addaddress"


/**
 *  修改收货地址
 */
#define LWShopUpAddressURL         @"/shop/upaddress"


/**
 *  删除收货地址
 */
#define LWShopDelAddressURL         @"/shop/deladdress"

/**
 *  分页获取店铺
 */
#define LWShopGetShopsURL           @"/shop/getshops"

/**
 *  获取店铺信息
 */
#define LWShopGetInfoURL               @"/shop/getinfo"

/**
 *  分页获取店铺商品
 */
#define LWShopGetitemsbyshopURL        @"/shop/getitemsbyshop"

/**
 *  检查版本
 */
#define LWCheckVersionURL                   @"/checkversion"

#define LWGetTabTextURL                     @"/gettabtext"

//tags url
#define LWGettagsURL                        @"/getclassifies"

/**
 *  banner list
 */

#define LWBannerGetListURL                  @"/barner/getlist"

/**
 *  banner detial
 */
#define LWBannerGetDetailURL                @"/barner/getdetail"


/**
 *  request_dispatch
 */
#define LWRequest_DisPathURL                @"/request_dispatch"

/**
 *  我的收藏列表
 */
#define LWVideoGetcollectlistURL            @"/video/getcollectlist"

/**
 *  获取系列url
 */
#define LWGetSeriesURL                      @"/video/videobrief/getlist"

/**
 *  获取qaurl
 */
#define LWGetQaURL                          @"/qa/questions"

/**
 *  获取qa详情url
 */
#define LWGetQaDetailURL                    @"/qa/refresh"

/**
 *  获取qa历史url
 */
#define LWGetQaHisURL                       @"/qa/history"

/**
 *  通过qaid获取评论
 */
#define LWGetQaCommentURL                     @"/qa/getcomments"

/**
 *  对答案进行评论
 */
#define LWVoteChoiceURL                     @"/qa/votechoice"


#pragma mark ---   notificaiton -----
/**
 * 获取通知未读数
 */
#define  LWNotificationUnReadCountURL        @"/notification/unreadcnt"


/**
 *  获取回应 赞 @ 列表
 */
#define LWNotificationGetListURL            @"/notification/getlist"


#endif
