//
//  SubscribeModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PaperModel.h"

@protocol SubscribeInfo
@end

@interface SubscribeModel : RFJModel
JProperty(NSArray<SubscribeInfo> *data, data);
JProperty(PaperModel *paper, paper);
@end

@interface SubscribeInfo : RFJModel

JProperty(NSString *sid, id);
JProperty(NSString *title, title);
JProperty(NSString *image, image);
JProperty(NSString *avatar, avatar);
JProperty(NSString *uid, uid);
JProperty(NSString *username, username);

@end