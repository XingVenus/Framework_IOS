//
//  BaseModel.h
//  HuWai
//  用户登录
//  Created by WmVenusMac on 15-2-5.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@interface EntryModel : RFJModel
JProperty(NSString *avatar, avatar);
JProperty(NSString *username, username);
JProperty(NSString *email, email);
JProperty(NSString *create_time, create_time);
JProperty(NSString *phone, phone);
JProperty(NSString *uid, uid);
JProperty(NSString *star, star);
JProperty(NSString *role_id, role_id);
JProperty(NSString *status, status);
@end
