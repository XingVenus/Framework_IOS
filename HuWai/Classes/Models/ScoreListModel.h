//
//  ScoreListModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PagerModel.h"
@protocol ScoreInfo
@end

@interface ScoreListModel : RFJModel
JProperty(NSArray<ScoreInfo> *data, data);
JProperty(PagerModel *pager, pager);
@end

@interface ScoreInfo : RFJModel
JProperty(NSString *sid, id);
JProperty(NSString *leader, leader);
JProperty(NSString *score, score);
JProperty(NSString *status, status);
JProperty(NSString *title, title);
JProperty(NSString *time, time);
JProperty(NSString *image, image);
@property(nonatomic) CGFloat  accuracyRate;
@property(nonatomic) CGFloat  satisfiedRate;
@end
