//
//  ApiServer.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ApiServer.h"

@implementation ApiServer

#pragma mark 请求uri定位
+(NSString *)uriStringFromAction:(HttpRequestAction)action
{
    NSString *uristring = nil;
    switch (action) {
        case UserEntryAction:
        {
            uristring = UserEntry_Uri;
        }
            break;
        case UserRegisterAction:
        {
            uristring = UserRegister_Uri;
        }
            break;
        case SendSmsAction:
        {
            uristring = SendSms_Uri;
        }
            break;
        case SmsTokenAction:
        {
            uristring = SmsToken_Uri;
            break;
        }
        case GettokenAction:
        {
            uristring = Gettoken_Uri;
            break;
        }
        default:
            break;
    }
    return uristring;
}

@end
