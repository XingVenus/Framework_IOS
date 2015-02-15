//
//  PagerModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"

@interface PagerModel : RFJModel
JProperty(NSInteger total, total);
JProperty(NSInteger page, page);
JProperty(NSInteger pagesize, pagesize);
JProperty(NSInteger pagemax, pagemax);
@end
