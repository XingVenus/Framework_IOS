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
JProperty(NSInteger from_uid, from_uid);
JProperty(NSString *from_username, from_username);
JProperty(NSString *to_uid, to_uid);
JProperty(NSString *time, time);
JProperty(NSString *title, title);
JProperty(NSString *message, message);
JProperty(NSString *status, status);
JProperty(NSString *type, type);
@end


