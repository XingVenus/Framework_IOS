//
//  UserMessageModel.h
//  HuWai
//  消息列表模型
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PagerModel.h"

@protocol MessageInfo
@end

@interface UserMessageModel : RFJModel
JProperty(NSArray<MessageInfo> *data, data);
JProperty(PagerModel *pager, pager);
@end

@interface MessageInfo : RFJModel
JProperty(NSInteger mid, id);
JProperty(NSString *title, title);
JProperty(NSInteger from_uid, from_uid);
JProperty(NSString *from_username, from_username);
JProperty(NSString *to_uid, to_uid);
JProperty(NSString *time, time);
JProperty(NSString *message, message);
JProperty(NSString *status, status);
JProperty(NSString *type, type);

//活动留言返回消息体
JProperty(NSString *activity_id, activity_id);
JProperty(NSString *from_time, from_time);
JProperty(NSString *from_avatar, from_avatar);
JProperty(NSString *from_content, from_content);
JProperty(NSString *reply_time, reply_time);
JProperty(NSString *reply_uid, reply_uid);
JProperty(NSString *reply_avatar, reply_avatar);
JProperty(NSString *reply_username, reply_username);
JProperty(NSString *reply_content, reply_content);
@end



