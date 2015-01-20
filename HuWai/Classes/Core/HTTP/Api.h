//
//  Api.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#ifndef HuWai_Api_h
#define HuWai_Api_h

typedef NS_ENUM(NSInteger, HttpRequestAction){
    UserRegisterAction,
    UserLoginAction,
    SendSmsAction, //短信验证码 发送
    SmsTokenAction, //手机验证码 校验
};

#define UserRegister_Uri    @"/v1/register"
#define UserLogin_Uri       @"/v1/login/entry"
#define SendSms_Uri         @"/v1/notification/sms"
#define SmsToken            @"/v1/notification/sms/:token"



#endif
