//
//  BaseViewController.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreController.h"
#import "ApiServer.h"
#import "BlankView.h"
#import "BaseNavigationController.h"

//NSDictionary *argsTpMap(id firstObject,...);

@interface BaseViewController : CoreController

@property (nonatomic, assign) BOOL hideShowMessage;

-(void)showMessageWithThreeSecondAtCenter:(NSString *)message afterDelay:(NSTimeInterval)interval;

-(IBAction)popToLastView:(BOOL)animated;
-(IBAction)dismissNavigationView:(BOOL)animated;

//-----custom method to use
-(NSString *)genderToString:(NSInteger)gender;
@end
