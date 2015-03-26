//
//  UserOrderModel.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "RFJModel.h"
#import "PagerModel.h"

@protocol OrderInfo
@end
@interface UserOrderModel : RFJModel
JProperty(NSArray<OrderInfo> *data, data);
JProperty(PagerModel *pager, pager);
@end

@interface OrderInfo : RFJModel
JProperty(NSString *order_id, order_id);
JProperty(NSString *money, money);
JProperty(NSString *goods_id, goods_id);
JProperty(NSString *title, title);
JProperty(NSString *price, price);
JProperty(NSString *num, num);
JProperty(NSString *leader_id, leader_id);
JProperty(NSString *leader_username, leader_username);
JProperty(NSString *insurance, insurance);
JProperty(NSString *insurance_price, insurance_price);
JProperty(NSString *insurance_num, insurance_num);
JProperty(NSString *image, image);
JProperty(NSString *time, time);
@end