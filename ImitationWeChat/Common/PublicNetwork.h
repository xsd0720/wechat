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

#define HttpHead            @"http://192.168.20.247:8000"

//#define HttpHead             @"182.92.23.2"

#define ShareHttpHead        @"http://lilslb.com"

#else

//#define HttpHead             @"182.92.23.2"
#define HttpHead            @"123.57.207.48"

#define ShareHttpHead        @"http://lilslb.com"

#endif


#pragma mark -  account(账号) -
/**
 *  注册
 */
#define RegisURL              @"/account/register"

/**
 *  登录
 */
#define LoginURL              @"/account/login"

/**
 *  登出
 */
#define LogoutURL             @"/account/logout"

/**
 *  忘记密码
 */
#define ForgetURL             @"/account/forget"

/**
 *  个人简介
 */
#define ProfileURL            @"/account/profile"

/**
 *  个人简介更新
 */
#define UpdateURL             @"/account/update"

/**
 *  手机号码修改
 */
#define UpdatemobileURL       @"/account/updatemobile"

/**
 *  用户名修改
 */
#define UpdateusernameURL     @"/account/updateusername"


/**
 *  七牛上传图片token
 */
#define QiniutokenURL         @"/account/qiniutoken"

/**
 *  发送验证码
 */
#define RequestsnsURL         @"/account/requestsns"

/**
 *  验证验证码
 */
#define CheckvcodeURL         @"/account/checkvcode"

/**
 *  三方登录
 */
#define LoginFromThirdURL     @"/account/loginfromthird"

/**
 *  绑定第三方账号
 */
#define BindThirdAccountURL   @"/account/bindthirdaccount"

/**
 *  忘记密码修改密码
 */
#define UpdateuserpsdURL     @"/account/updateuserpsd"

/**
 *  修改头像
 */
#define Changeheadpic         @"/account/changeheadpic"

/*
 *  获取我的QA评论
 */
#define Getqalist            @"/account/getqalist"


/**
 *  更改各个通知的状态
 */
#define Changenotif            @"/account/changenotif"


#pragma mark -  video(视频) -

/**
 *  视频列表
 */
#define GetVideoListURL       @"/video/v2/getlist"


/**
 *  关注的自媒体人视频列表
 */
#define GetFollowListURL       @"/video/getfollowlist"

/**
 *  视频详情
 */
#define GetVideoDetailURL     @"/video/getdetail"


#pragma mark -  comment(评论) -

/**
 *  评论列表
 */
#define GetCommentListURL     @"/comment/getlist"

/**
 *  回答的回复列表
 */
#define GetQAreplylist        @"/comment/getqareplylist"

/**
 *  发表评论
 */
#define CommentPostURL        @"/comment/post"




/**
 *  评论投票
 */
#define CommentVoteURL        @"/comment/vote"
/**
 *  踩投票
 */
#define CommentUnVoteURL      @"/comment/unvote"
/**
 *  获取热门评论
 */
#define GethotlistURL         @"/comment/gethotlist"

/**
 *  通过评论ids获取评论详情
 */
#define GetCommentByIdsURL       @"/comment/getcommentbyids"

/**
 *  获取评论总分
 */
#define GetCommentGetscoreURL       @"/comment/getscore"

/**
 *  回复评论
 */
#define ReplyCommentURL             @"/comment/reply"

/*
 *  通过用户获取评论/回复列表
 */
#define GetcommentGetlistbyuserURL       @"/comment/getlistbyuser"

/**
 *  关注
 */
#define FollowURL             @"/followship/follow"


/**
 *  取消关注
 */
#define UnFollowURL           @"/followship/unfollow"


/**
 *  关注的自媒体人列表
 */
#define FolloweesURL          @"/followship/getfollowees"


/**
 *  搜索
 */
#define SearchURL             @"/search/search"


/**
 *  热搜列表
 */
#define SearchSuggestionURL   @"/search/suggest"


/**
 *  自媒体人个人信息
 */
#define JournalistsGetprofileURL     @"/journalists/getprofile"


/**
 *  自媒体人videolist
 */
#define JournalistsGetVideosURL      @"/journalists/getvideos"


/**
 *  获取自媒体人评论列表
 */
#define JournalistsGetcommentsURL    @"/journalists/getcomments"

/**
 *  获取物流信息
 */
#define JuheURL                      @"http://v.juhe.cn/exp/index"

/**
 *  获取自媒体人商品列表
 */
#define ShopGetItemsURL              @"/shop/getitems"

/**
 *  通过id列表 获取item
 */
#define ShopGetItemsByIdsUrl         @"/shop/getitemsbyids"

/**
 *  获取商品详情
 */
#define ShopGetItemDetailURL         @"/shop/getitemdetail"


/**
 *  获取预支付对象
 */
#define ShopAddTradeURL               @"/shop/addtrade"


/**
 *  获取订单列表
 */
#define ShopGettradestatusURL         @"/shop/gettradestatus"

/**
 *  获取支付结果
 */
#define ShopGetpaymentinfoURL         @"/shop/getpaymentinfo"


/**
 *  获取收货地址列表
 */
#define ShopGetAddressURL         @"/shop/getaddress"


/**
 *  增加收货地址
 */
#define ShopAddAddressURL         @"/shop/addaddress"


/**
 *  修改收货地址
 */
#define ShopUpAddressURL         @"/shop/upaddress"


/**
 *  删除收货地址
 */
#define ShopDelAddressURL         @"/shop/deladdress"

/**
 *  分页获取店铺
 */
#define ShopGetShopsURL           @"/shop/getshops"

/**
 *  获取店铺信息
 */
#define ShopGetInfoURL               @"/shop/getinfo"

/**
 *  分页获取店铺商品
 */
#define ShopGetitemsbyshopURL        @"/shop/getitemsbyshop"

/**
 *  检查版本
 */
#define CheckVersionURL                   @"/checkversion"

#define GetTabTextURL                     @"/gettabtext"

//tags url
#define GettagsURL                        @"/getclassifies"

/**
 *  banner list
 */

#define BannerGetListURL                  @"/barner/getlist"

/**
 *  banner detial
 */
#define BannerGetDetailURL                @"/barner/getdetail"


/**
 *  request_dispatch
 */
#define Request_DisPathURL                @"/request_dispatch"

/**
 *  我的收藏列表
 */
#define VideoGetcollectlistURL            @"/video/getcollectlist"

/**
 *  获取系列url
 */
#define GetSeriesURL                      @"/video/videobrief/getlist"

/**
 *  获取qaurl
 */
#define GetQaURL                          @"/qa/questions"

/**
 *  获取qa详情url
 */
#define GetQaDetailURL                    @"/qa/refresh"

/**
 *  获取qa历史url
 */
#define GetQaHisURL                       @"/qa/history"

/**
 *  通过qaid获取评论
 */
#define GetQaCommentURL                     @"/qa/getcomments"

/**
 *  对答案进行评论
 */
#define VoteChoiceURL                     @"/qa/votechoice"


#pragma mark ---   notificaiton -----
/**
 * 获取通知未读数
 */
#define  NotificationUnReadCountURL        @"/notification/unreadcnt"


/**
 *  获取回应 赞 @ 列表
 */
#define NotificationGetListURL            @"/notification/getlist"


#endif
