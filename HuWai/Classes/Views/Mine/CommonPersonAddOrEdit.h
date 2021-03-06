//
//  CommonPersonAddOrEdit.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, PageShowType) {
    AddType,    //添加
    EditType,   //编辑
};

@protocol CommonPersonDataDelegate <NSObject>

@optional
-(void)addOrEditDone;

@end

@interface CommonPersonAddOrEdit : BaseViewController

@property (nonatomic, weak) id<CommonPersonDataDelegate> delegate;
@property (nonatomic) PageShowType pageType;
@property (nonatomic) BOOL isFromEnroll; //来自订单页面
@property (weak, nonatomic) IBOutlet UITextField *peopleName;
@property (weak, nonatomic) IBOutlet UITextField *identityNo;
@property (weak, nonatomic) IBOutlet UITextField *phoneNo;
@property (weak, nonatomic) IBOutlet UIButton *gender;

@property (nonatomic, strong) NSString  *pid;
@end
