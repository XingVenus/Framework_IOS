//
//  DestinationCityModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-15.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@protocol DestCityInfo
@end

@interface DestinationCityModel : RFJModel
JProperty(NSArray<DestCityInfo> *data, data);
@end

@interface DestCityInfo : RFJModel
JProperty(NSString *cid, id);
JProperty(NSString *name, name);
@end