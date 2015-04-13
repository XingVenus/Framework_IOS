//
//  APPInfo.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPInfo : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *role_id;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *token; //鉴别用户的token，每次数据请求需要发送
//@property (nonatomic,getter = isLogin) BOOL  login; //用于表示用户本次打开应用
@property (nonatomic, strong) NSString *apnsType; //APNS消息推送类型
@property (nonatomic) BOOL firstLaunch;
@property (nonatomic, strong) NSString *payFromType; //报名页面：enroll,订单列表页面：orderlist
@property (nonatomic, assign, getter = isUpdatedCommonPerson) BOOL updatedCommonPerson; //用于标记本次打开应用更新常用联系人数据

@property (nonatomic, strong) NSString *GPSCity; //用户当前定位的城市

+(instancetype)shareInit;
//更新用户信息到模型对象
-(void)updateUserInfo:(NSDictionary *)userinfo;

@end
