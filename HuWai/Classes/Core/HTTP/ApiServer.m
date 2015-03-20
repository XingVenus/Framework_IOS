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
        case CommonPersonListAction:
        {
            uristring = CommonPersonList_Uri;
            break;
        }
        case CommonPersonAddAction:
        {
            uristring = CommonPersonAdd_Uri;
            break;
        }
        case ModifyPasswordAction:
        {
            uristring = ModifyPassword_Uri;
            break;
        }
        case ActivityAction:
        {
            uristring = Activity_Uri;
            break;
        }
        case HotcityAction:
        {
            uristring = Hotcity_Uri;
            break;
        }
        case DestinationAction:
        {
            uristring = Destination_Uri;
            break;
        }
        case ResetpasswordAction:
        {
            uristring = Resetpassword_Uri;
            break;
        }
        case ActivityDetailAction:
        {
            uristring = ActivityDetail_Uri;
            break;
        }
        case AddFavoriteAction:
        {
            uristring = AddFavorite_Uri;
            break;
        }
        case CancelFavoriteAction:
        {
            uristring = CancelFavorite_Uri;
            break;
        }
        case FavoriteListAction:
        {
            uristring = FavoriteList_Uri;
            break;
        }
        case RssListAction:
        {
            uristring = RssList_Uri;
            break;
        }
        case OrderPersonCheckAction:
        {
            uristring = OrderPersonCheck_Uri;
            break;
        }
        case ActivitySurplusAction:
        {
            uristring = ActivitySurplus_Uri;
            break;
        }
        case OrderCreateAction:
        {
            uristring = OrderCreate_Uri;
            break;
        }
        case OrderCancelAction:
        {
            uristring = OrderCancel_Uri;
            break;
        }
        case OrderDetailAction:
        {
            uristring = OrderDetail_Uri;
            break;
        }
        case OrderMyAction:
        {
            uristring = OrderMy_Uri;
            break;
        }
        case ScoreListAction:
        {
            uristring = ScoreList_Uri;
            break;
        }
        case ScoreNewAction:
        {
            uristring = ScoreNew_Uri;
            break;
        }
        case RssAddAction:
        {
            uristring = RssAdd_Uri;
            break;
        }
        case RssCancelAction:
        {
            uristring = RssCancel_Uri;
            break;
        }
        case CommonPersonDeleteAction:
        {
            uristring = CommonPersonDelete_Uri;
            break;
        }
        case ActivityFAQAction:
        {
            uristring = ActivityFAQ_Uri;
            break;
        }
        case ActivityAskAction:
        {
            uristring = ActivityAsk_Uri;
            break;
        }
        case ActivityReplyAction:
        {
            uristring = ActivityReply_Uri;
            break;
        }
        case AppRegistrationAction:
        {
            uristring = AppRegistration_Uri;
            break;
        }
        case MessageListAction:
        {
            uristring = MessageList_Uri;
            break;
        }
        case LoginXiciAction:
        {
            uristring = LoginXici_Uri;
            break;
        }
        case LoginPerfectinfoAction:
        {
            uristring = LoginPerfectinfo_Uri;
            break;
        }
        default:
            break;
    }
    return uristring;
}

@end
