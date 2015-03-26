//
//  MessageGroupModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
@protocol GroupInfo
@end

@interface MessageGroupModel : RFJModel
JProperty(NSArray<GroupInfo> *data, data);
@end

@interface GroupInfo : RFJModel
JProperty(NSString *type, type);
JProperty(NSString *title, title);
JProperty(NSString *message, message);
JProperty(NSString *time, time);
JProperty(NSString *num, num);
@property (nonatomic, assign) BOOL isCheck;
@end
