//
//  UserMessageModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PaperModel.h"

@protocol MessageInfo
@end

@interface UserMessageModel : RFJModel
JProperty(NSArray<MessageInfo> *data, data);
JProperty(PaperModel *paper, paper);
@end


@interface MessageInfo : RFJModel
JProperty(NSInteger mid, id);
JProperty(NSInteger from_uid, from_uid);
JProperty(NSString *from_username, from_username);
JProperty(NSString *time, time);
JProperty(NSString *title, title);
JProperty(NSString *message, message);
JProperty(NSString *status, status);
JProperty(BOOL system, system);
@end


