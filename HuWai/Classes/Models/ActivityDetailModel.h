//
//  ActivityDetailModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-25.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@class DetailInfo;
@class LeaderInfo;

@interface ActivityDetailModel : RFJModel

JProperty(NSString *adID, id);
JProperty(NSString *title, title);
JProperty(NSString *price, price);
JProperty(NSArray *flash, flash);
JProperty(DetailInfo *detail, detail);
JProperty(LeaderInfo *leader, leader);
JProperty(NSString *starttime, starttime);
JProperty(NSString *endtime, endtime);
JProperty(NSString *dateline, dateline);
JProperty(BOOL isFavorite, isFavorite);
JProperty(BOOL isRss, isRss);
@end

@interface DetailInfo : RFJModel
JProperty(NSString *city, city);
JProperty(NSString *time, time);
JProperty(NSString *mode, mode);

@end

@interface LeaderInfo : RFJModel
JProperty(NSString *avatar, avatar);
JProperty(NSString *username, username);
JProperty(BOOL verified, verified);
JProperty(NSString *score, score);
JProperty(NSString *gender, gender);
JProperty(NSString *age, age);
JProperty(NSString *fromCity, fromCity);
JProperty(NSString *validationMessage, validationMessage);
JProperty(NSString *times, times);
JProperty(NSString *participants, participants);
JProperty(NSString *rater, rater);
@end
