//
//  ScoreListModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
@protocol ScoreInfo
@end

@interface ScoreListModel : RFJModel
JProperty(NSArray<ScoreInfo> *data, data);
@end

@interface ScoreInfo : RFJModel
JProperty(NSString *sid, id);
JProperty(NSString *leader, leader);
JProperty(NSString *score, score);
JProperty(NSString *status, status);
JProperty(NSString *title, title);
@property(nonatomic) CGFloat  accuracyRate;
@property(nonatomic) CGFloat  satisfiedRate;
@end
