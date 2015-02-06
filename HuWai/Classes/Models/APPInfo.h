//
//  APPInfo.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPInfo : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *role_id;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *token; //鉴别用户的token，每次数据请求需要发送
@property (nonatomic,getter = isLogin) BOOL  login;

+(instancetype)shareInit;
//更新用户信息到模型对象
-(void)updateUserInfo:(NSDictionary *)userinfo;

@end
