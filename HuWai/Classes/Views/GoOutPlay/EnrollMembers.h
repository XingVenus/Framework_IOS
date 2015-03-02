//
//  EnrollMembers.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewController.h"

extern NSString *const EnrollMembersAddNewNotification;

@interface EnrollMembers : BaseTableViewController

@property (nonatomic, strong) NSString *activityID;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *o_realname;
@property (nonatomic, strong) NSString *o_phone;

@end
