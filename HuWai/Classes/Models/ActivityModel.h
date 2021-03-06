//
//  ActivityModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PagerModel.h"

@protocol ActivityInfo
@end

@interface ActivityModel : RFJModel
JProperty(NSArray<ActivityInfo> *data, data);
JProperty(PagerModel *pager, pager);
@end

@interface ActivityInfo : RFJModel
JProperty(NSString *aid, id);
JProperty(NSString *title, title);
JProperty(NSString *image, image);
JProperty(NSString *price, price);
JProperty(NSString *uid, uid);
JProperty(NSString *username, username);
JProperty(NSString *avatar, avatar);
@end
