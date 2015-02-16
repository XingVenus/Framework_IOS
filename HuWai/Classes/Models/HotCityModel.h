//
//  HotCityModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@protocol HotCityInfo
@end

@interface HotCityModel : RFJModel
JProperty(NSArray<HotCityInfo> *data, data);
@end

@interface HotCityInfo : RFJModel
JProperty(NSString *cid, id);
JProperty(NSString *name, name);
@end
