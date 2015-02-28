//
//  CommonPersonModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@protocol CommonPersonInfo
@end

@interface CommonPersonModel : RFJModel
JProperty(NSArray<CommonPersonInfo> *data, data);
@end

@interface CommonPersonInfo : RFJModel
JProperty(NSString *pid, id);
JProperty(NSString *name, name);
JProperty(NSString *gender, gender);
JProperty(NSString *identity, identity);
JProperty(NSString *phone, phone);
@end
