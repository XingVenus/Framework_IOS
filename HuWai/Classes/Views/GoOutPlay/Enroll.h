//
//  Enroll.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"

@interface Enroll : BaseViewController

@property (nonatomic, strong) NSString *activityID;

@property (weak, nonatomic) IBOutlet UITextField *orderPersonField;
@property (weak, nonatomic) IBOutlet UITextField *orderPersonPhoneField;
@property (weak, nonatomic) IBOutlet UITextField *emergencyPersonField;
@property (weak, nonatomic) IBOutlet UITextField *emergencyPersonPhoneField;

- (IBAction)orderCheckAction:(id)sender;
@end
