//
//  UserMessageContentModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@interface UserMessageContentModel : RFJModel

JProperty(NSString *mid, id);
JProperty(NSString *from, from);
JProperty(NSString *time, time);
JProperty(NSString *title, title);
JProperty(NSString *summary, summary);

@end
