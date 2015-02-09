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
};

#define UserRegister_Uri    @"/v1/register"
#define UserEntry_Uri       @"/v1/login/entry"
#define SendSms_Uri         @"/v1/notification/sms"
#define SmsToken_Uri        @"/v1/notification/sms/:smsToken"
#define Gettoken_Uri        @"/v1/login/gettoken"
#define Resetpassword_Uri   @"/v1/login/resetpassword"
#define CommonPersonList_Uri    @"/v1/participants/list?uid=:string"
#define CommonPersonAdd_Uri     @"/v1/participants/add"
#define ModifyPassword_Uri      @"/v1/user/password"

//活动
#define Activity_Uri        @"/v1/activity/list"

@interface ApiServer : NSObject

+(NSString *)uriStringFromAction:(HttpRequestAction)action;

@end
