//
//  BaseModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-5.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@interface EntryModel : RFJModel
JProperty(NSString *username, username);
JProperty(NSString *email, email);
JProperty(NSString *create_time, create_time);
JProperty(NSString *tel, tel);
JProperty(NSString *uid, uid);
JProperty(NSString *star, star);
JProperty(NSString *role_id, role_id);
JProperty(NSString *status, status);
@end
