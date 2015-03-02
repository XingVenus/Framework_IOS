//
//  OrderDetailModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

#import "UserOrderModel.h"
#import "CommonPersonModel.h"
#import "ActivityDetailModel.h"

@class OrderStatus;
@class ContactsInfo;
//@class ActivityPayInfo;
//@class ActivityPayInfoDetail;
//@class ActivityPayInfoLeader;

@interface OrderDetailModel : RFJModel
JProperty(OrderStatus *order_status, order_status);
JProperty(OrderInfo *order_info, order_info);
JProperty(ContactsInfo *contacts_info, contacts_info);
JProperty(NSArray<CommonPersonInfo> *joins_info, joins_info);
JProperty(ActivityDetailModel *activity_info, activity_info);

@end

@interface OrderStatus : RFJModel
JProperty(NSString *value, value);
JProperty(NSString *text, text);
@end

@interface ContactsInfo : RFJModel
JProperty(NSString *realname, realname);
JProperty(NSString *tel, tel);
JProperty(NSString *o_realname, o_realname);
JProperty(NSString *o_tel, o_tel);
JProperty(NSString *message, message);
@end

//activity_info
//@interface ActivityPayInfo : RFJModel
//JProperty(NSString *apID, id);
//JProperty(NSString *title, title);
//JProperty(ActivityPayInfoDetail *ac_detail, detail);
//JProperty(ActivityPayInfoLeader *ac_leader, leader);
//JProperty(NSString *price, price);
//@end
//@interface ActivityPayInfoDetail : RFJModel
//JProperty(NSString *city, city);
//JProperty(NSString *time, time);
//JProperty(NSString *mode, mode);
//@end
//@interface ActivityPayInfoLeader : RFJModel
//JProperty(NSString *uid, uid);
//JProperty(NSString *avatar, avatar);
//JProperty(NSString *username, username);
//@end

