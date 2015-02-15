//
//  ResetPassword.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"

@interface ResetPassword : BaseViewController

@property (nonatomic, strong) NSString *resetToken;
@property (nonatomic, strong) NSString *phoneNumber;
@end
