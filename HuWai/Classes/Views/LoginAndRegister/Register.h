//
//  Register.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-21.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, AcountType) {
    AcountTypeDefault = 0,
    AcountTypeXiCi,
    AcountTypeQQ
};

@interface Register : BaseViewController

@property (nonatomic, assign) AcountType fromType;
@property (nonatomic, strong) NSDictionary *xiciInfo;
@property (nonatomic, strong) NSString *xiciPwd;
@end
