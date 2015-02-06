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
#define APP_ITUNES_ID  @"956085496"//@"458318329"
//应用在itunes的信息地址,用于版本检测
#define APP_ITUNES_URL     @"http://itunes.apple.com/lookup?id=956085496" //http://itunes.apple.com/lookup?id=你的应用程序的ID

#define REQUEST_BASE_URL    @"http://api.huwai.com"
//#define HTTP_BASE_PATH      @"http://api.huwai.com/"
//
//#define REQUEST_BASE_URL    @"http://172.23.69.2:8080/localization/shopLocation"
//#define HTTP_BASE_PATH      @"http://172.23.69.2:8080/localization/"

//＝＝＝＝＝＝应用沙盒的缓存key定义
#define CACHE_USER_PHONE    @"CACHE_USER_PHONE"
#define CACHE_USER_PASSWORD @"CACHE_USER_PASSWORD"
#define CACHE_TOKEN         @"CACHE_TOKEN"
#define CACHE_USER_INFO     @"CACHE_USER_INFO"

//----用户信息缓存字段
#define USERNAME_CACHE      @"USERNAME_CACHE"
#define EMAIL_CACHE         @"EMAIL_CACHE"
#define CREATETIME_CACHE    @"CREATETIME_CACHE"
#define TEL_CACHE           @"TEL_CACHE"
#define UID_CACHE           @"UID_CACHE"
#define STAR_CACHE          @"STAR_CACHE"
#define ROLEID_CACHE        @"ROLEID_CACHE"
#define STATUS_CACHE        @"STATUS_CACHE"
//＝＝＝＝＝＝名称常量定义
//密码加密密钥
#define SECRET_KEY @"luobodi_haokelai"
//数据库名称
#define DATABASE_NAME   @"photoPrint.sqlite"


//＝＝＝＝＝＝通知常量的定义



//＝＝＝＝＝＝xmpp配置
#define XMPP_SERVER     @"112.21.190.46"
#define XMPP_PORT       5322
#define XMPP_PASSWORD   @"123456"



#endif
