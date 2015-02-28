//
//  APPInfo.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "APPInfo.h"
#import "EntryModel.h"

@implementation APPInfo

+(instancetype)shareInit
{
    static APPInfo *infoObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoObj = [[self alloc] init];
    });
    return infoObj;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *username = [CacheBox getCache:USERNAME_CACHE];
        NSString *email = [CacheBox getCache:EMAIL_CACHE];
        NSString *createtime = [CacheBox getCache:CREATETIME_CACHE];
        NSString *tel = [CacheBox getCache:TEL_CACHE];
        NSString *uid = [CacheBox getCache:UID_CACHE];
        NSString *star = [CacheBox getCache:STAR_CACHE];
        NSString *roleid = [CacheBox getCache:ROLEID_CACHE];
        NSString *status = [CacheBox getCache:STATUS_CACHE];

        NSDictionary *userinfo = @{@"username":username?username:@"",@"email":email?email:@"",@"create_time":createtime?createtime:@"",@"tel":tel?tel:@"",@"uid":uid?uid:@"",@"star":star?star:@"",@"role_id":roleid?roleid:@"",@"status":status?status:@""};
        if (userinfo) {
            [self updateUserInfo:userinfo];
        }
    }
    return self;
}

-(void)updateUserInfo:(NSDictionary *)userinfo
{
    EntryModel *model = [[EntryModel alloc] initWithJsonDict:userinfo];
    self.username = model.username;
    self.email = model.email;
    self.create_time = model.create_time;
    self.tel = model.tel;
    self.uid = model.uid;
    self.star = model.star;
    self.role_id = model.role_id;
    self.status = model.status;
    [CacheBox saveCache:USERNAME_CACHE value:model.username];
    [CacheBox saveCache:EMAIL_CACHE value:model.email];
    [CacheBox saveCache:CREATETIME_CACHE value:model.create_time];
    [CacheBox saveCache:TEL_CACHE value:model.tel];
    [CacheBox saveCache:UID_CACHE value:model.uid];
    [CacheBox saveCache:STAR_CACHE value:model.star];
    [CacheBox saveCache:ROLEID_CACHE value:model.role_id];
    [CacheBox saveCache:STATUS_CACHE value:model.status];
}
@end
