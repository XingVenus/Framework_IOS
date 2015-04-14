//
//  ConstantMacro.h
//  Sanbao
//
//  Created by WmVenusMac on 14-6-23.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#ifndef Sanbao_ConstantMacro_h
#define Sanbao_ConstantMacro_h

//========基本必要常量定义
//require macro define
#define APP_ITUNES_ID  @"985035633" //@"956085496"//@"458318329"
#define APP_ITUNES_URL  [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",APP_ITUNES_ID]
//应用在itunes的信息地址,用于版本检测
#define APP_ITUNES_LOOKUP_URL     [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APP_ITUNES_ID] //http://itunes.apple.com/lookup?id=你的应用程序的ID

#ifdef DEBUG
#   define REQUEST_BASE_URL    @"http://szapp.xici.net" //@"http://api.huwai.com"//api.huwai.ixici.info
#else
#   define REQUEST_BASE_URL    @"http://szapp.xici.net" //@"http://api.huwai.com"//api.huwai.ixici.info
#endif

//用于活动详情、支付成功判断
#define APP_MINI_PUBLISH_HTTP_URL    @"http://wan.xici.net"
//#define HTTP_BASE_PATH      @"http://api.huwai.com/"
//#define HTTP_BASE_PATH      @"http://api.huwai.com/"

//用户协议地址
#define AGREEMENT_URL   @"http://wan.xici.net/agreement/mobile_regist.html"//@"http://xx.huwai.ixici.info/agreement/mobile_regist.html"
//关于我们地址
#define ABOUT_US_URL    @"http://wan.xici.net/about/us.html"//@"http://xx.huwai.ixici.info/about/us.html"

#define LOAD_PROMPT_MESSAGE  @"正在加载"
#define NO_MORE_DATA_MESSAGE    @"亲，已到最后一页"

//==================应用沙盒的缓存key定义==============
#define HOT_CITY_LIST_CACHE @"HOT_CITY_LIST_CACHE"   //热门城市

//----服务器注册通知缓存key(注册成功有 否则不存在)----------
#define REGISTRATION_DEVICE_CACHE   @"REGISTRATION_DEVICE_CACHE"
//----定位城市
#define LOCATION_CITY_NAME  @"LOCATION_CITY_NAME"  //选择的定位城市

//----用户属性字段
#define CACHE_USER_PHONE    @"CACHE_USER_PHONE"
#define CACHE_USER_PASSWORD @"CACHE_USER_PASSWORD"
#define CACHE_TOKEN         @"CACHE_TOKEN"
#define CACHE_USER_INFO     @"CACHE_USER_INFO"

//----用户信息缓存字段
#define USER_AVATAR         @"USER_AVATAR"
#define USERNAME_CACHE      @"USERNAME_CACHE"
#define EMAIL_CACHE         @"EMAIL_CACHE"
#define CREATETIME_CACHE    @"CREATETIME_CACHE"
#define TEL_CACHE           @"TEL_CACHE"
#define UID_CACHE           @"UID_CACHE"
#define STAR_CACHE          @"STAR_CACHE"
#define ROLEID_CACHE        @"ROLEID_CACHE"
#define STATUS_CACHE        @"STATUS_CACHE"
//------名称常量定义
//密码加密密钥
#define SECRET_KEY @"luobodi_haokelai"
//数据库名称
#define DATABASE_NAME   @"huwai.sqlite"
//---数据库表名称
#define COMMON_PERSON_TABLE   @"commonperson"
#define APP_MESSAGE_TABLE     @"appmessage"

//----用于引导页面显示判断的应用build版本
#define LAUNCH_BUILD_VERSION    @"LAUNCH_BUILD_VERSION"

//----用于推动记录新消息提示
#define MESSAGE_PUSH    @"MESSAGE_PUSH" //系统群发、留言被回复
#define SUBSCRIBE_PUSH  @"SUBSCRIBE_PUSH" //订阅领队有新活动
#define SCORE_PUSH      @"SCORE_PUSH" //活动打分提醒

//-----消息提醒设置--------
#define OPEN_MESSAGE_ALERT  @"OPEN_MESSAGE_ALERT"

//======================通知常量的定义==================
static NSString *UserRegistrationNotification = @"user_registration_notification";//用户推送通知注册
static NSString *PageRefreshNotification    = @"page_refresh_notification"; //用户登录后的页面刷新 unused
static NSString *MyOrderListLoadNotification = @"MyOrderListLoadNotification";
//=======================xmpp配置=================
#define XMPP_SERVER     @"112.21.190.46"
#define XMPP_PORT       5322
#define XMPP_PASSWORD   @"123456"
//====================推送设置====================
#define kAppId           @"TmaCawd4p492jdPo9uuES7"
#define kAppKey          @"qBGelJkHcJAhzPgbbYA076"
#define kAppSecret       @"thrXL7FrFO7T1f5sIR7rH6"

//页面背景颜色
#define APP_BACKGROUND_COLOR    RGBA(238,238,238,1)
//分割线颜色
#define APP_DIVIDELINE_COLOR    RGBA(226,226,226,1)

//====================友盟================
#define UM_SOCIAL_KEY    @"5507807cfd98c5ef21000382"

//================= associative reference keys=============
static const NSString * OrderCancelAssociatedKey         = @"OrderCancelAssociatedKey";
#endif
