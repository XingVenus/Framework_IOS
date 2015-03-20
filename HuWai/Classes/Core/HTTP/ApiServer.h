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
    CommonPersonDeleteAction,  //常用出行人 删除
    ModifyPasswordAction,   //修改密码
    ActivityAction,         //活动列表
    HotcityAction,      //获取城市列表 热门城市
    DestinationAction,     // 目的地城市
    ActivityDetailAction,   //活动详情
    ActivityFAQAction,      //活动内容 问答列表
    AddFavoriteAction,      //添加收藏
    CancelFavoriteAction,    //取消收藏
    FavoriteListAction,     //收藏列表
    RssListAction,          //订阅列表
    OrderPersonCheckAction, //检查订单联系人、紧急联系人
    ActivitySurplusAction,  //活动内容 剩余名额
    OrderCreateAction,      //创建订单
    OrderCancelAction,      //取消订单
    OrderDetailAction,      //订单详情
    OrderMyAction,          //我的订单
    ScoreListAction,        //已（待）打分列表
    ScoreNewAction,         //领队打分 评分
    RssAddAction,           //添加订阅
    RssCancelAction,        //取消订阅
    ActivityAskAction,      //活动内容 提问
    ActivityReplyAction,    //活动内容 回复
    AppRegistrationAction,  //客户端消息组件注册
    MessageListAction,      //我的消息 列表
    LoginXiciAction,        //西祠用户登录
    LoginPerfectinfoAction  //完善信息xici 、qq
};


#define AppRegistration_Uri @"/v1/app/registration" //客户端消息组件注册
//我的
#define MessageList_Uri     @"/v1/message/list"     //我的消息 列表 get
#define UserRegister_Uri    @"/v1/register"
#define UserEntry_Uri       @"/v1/login/entry"      //用户登录
#define LoginXici_Uri       @"/v1/login/xici"       //西祠用户登录-
#define LoginPerfectinfo_Uri    @"/v1/login/perfectinfo" //用户登录-完善信息
#define SendSms_Uri         @"/v1/notification/sms"
#define SmsToken_Uri        @"/v1/notification/sms/:smsToken"
#define Gettoken_Uri        @"/v1/login/gettoken"
#define Resetpassword_Uri   @"/v1/login/resetpassword"
#define CommonPersonList_Uri    @"/v1/participants/list" //常用出行人列表 get
#define CommonPersonAdd_Uri     @"/v1/participants/add"
#define CommonPersonDelete_Uri  @"/v1/participants/delete"
#define ModifyPassword_Uri      @"/v1/user/password"
#define FavoriteList_Uri    @"/v1/favorite/list"  //活动内容 问答列表 get
#define ActivityAsk_Uri     @"/v1/activity/ask" //活动内容 提问
#define ActivityReply_Uri   @"/v1/activity/reply"   //活动内容 回复
#define RssList_Uri         @"/v1/rss/list"
#define OrderPersonCheck_Uri        @"/v1/order/check"
#define OrderCreate_Uri     @"/v1/order/create"   //创建订单
#define OrderCancel_Uri     @"/v1/order/cancel"   //取消订单
#define OrderDetail_Uri     @"/v1/order/detail"     //订单详情 get
#define OrderMy_Uri         @"/v1/order/my"         //我的订单 get
#define ScoreList_Uri       @"/v1/score/list"   //领队打分 已（待）打分列表 get
#define ScoreNew_Uri        @"/v1/score/new"    //领队打分 评分
//活动
#define Activity_Uri        @"/v1/activity/list"
#define Hotcity_Uri         @"/v1/region/hotcity"
#define Destination_Uri     @"/v1/region/destination"
#define ActivityDetail_Uri  @"/v1/activity/view"  //get
#define ActivityFAQ_Uri     @"/v1/activity/faq"     //get
#define AddFavorite_Uri     @"/v1/favorite/add"
#define CancelFavorite_Uri  @"/v1/favorite/cancel"
#define ActivitySurplus_Uri @"/v1/activity/surplus" //get
#define RssAdd_Uri          @"/v1/rss/add"      //添加订阅
#define RssCancel_Uri       @"/v1/rss/cancel"   //取消订阅

@interface ApiServer : NSObject

+(NSString *)uriStringFromAction:(HttpRequestAction)action;

@end
