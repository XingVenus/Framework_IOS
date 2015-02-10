//
//  FavoriteModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-10.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PaperModel.h"

@protocol FavoriteInfo
@end

@interface FavoriteModel : RFJModel
JProperty(NSArray<FavoriteInfo> *data, data);
JProperty(PaperModel *paper, paper);

@end

@interface FavoriteInfo : RFJModel

JProperty(NSString *sid, id);
JProperty(NSString *title, title);
JProperty(NSString *image, image);
JProperty(NSString *avatar, avatar);
JProperty(NSString *username, username);

@end