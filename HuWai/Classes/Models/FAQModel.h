//
//  FAQModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-12.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PagerModel.h"

@protocol FAQInfo
@end

@interface FAQModel : RFJModel
JProperty(NSArray<FAQInfo> *data, data);
JProperty(PagerModel *pager, pager);
@end

@interface FAQInfo : RFJModel
JProperty(NSString *fid, id);
JProperty(NSString *avatar, avatar);
JProperty(NSString *username, username);
JProperty(NSString *time, time);
JProperty(NSString *reply, reply);
JProperty(NSString *reply_time, reply_time);
@end
