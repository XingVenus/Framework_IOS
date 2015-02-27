//
//  ApiServer.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HttpRequestAction){
    UserRegisterAction, //用户注册
    SendSmsAction,      //短信验证码 发送
    SmsTokenAction,     //手机验证码 校验
    GettokenAction,     //获取用户登录令牌
    UserEntryAction,    //用户登录
    ResetpasswordAction,//重设密码
    CommonPersonListAction,//常用出行人列表
    CommonPersonAddAction, //常用出行人 新增
    ModifyPasswordAction,   //修改密码
    ActivityAction,         //活动列表
    HotcityAction,      //获取城市列表 热门城市
    DestinationAction,     // 目的地城市
    ActivityDetailAction,   //活动详情
    AddFavoriteAction,      //添加收藏
    CancelFavoriteAction,    //取消收藏
    FavoriteListAction,     //收藏列表
    RssListAction,          //订阅列表
};

//我的
#define UserRegister_Uri    @"/v1/register"
#define UserEntry_Uri       @"/v1/login/entry"
#define SendSms_Uri         @"/v1/notification/sms"
#define SmsToken_Uri        @"/v1/notification/sms/:smsToken"
#define Gettoken_Uri        @"/v1/login/gettoken"
#define Resetpassword_Uri   @"/v1/login/resetpassword"
#define CommonPersonList_Uri    @"/v1/participants/list"
#define CommonPersonAdd_Uri     @"/v1/participants/add"
#define ModifyPassword_Uri      @"/v1/user/password"
#define FavoriteList_Uri    @"/v1/favorite/list"
#define RssList_Uri         @"/v1/rss/list"

//活动
#define Activity_Uri        @"/v1/activity/list"
#define Hotcity_Uri         @"/v1/region/hotcity"
#define Destination_Uri     @"/v1/region/destination"
#define ActivityDetail_Uri  @"/v1/activity/view?id=:id"
#define AddFavorite_Uri     @"/v1/favorite/add"
#define CancelFavorite_Uri  @"/v1/favorite/cancel"

@interface ApiServer : NSObject

+(NSString *)uriStringFromAction:(HttpRequestAction)action;

@end
