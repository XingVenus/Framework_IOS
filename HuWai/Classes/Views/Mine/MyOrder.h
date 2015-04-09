//
//  MyOrder.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger, OrderStatusType)
{
    OrderStatusWating = 0,
    OrderStatusCompleted,
    OrderStatusCanceled,
    OrderStatusRefunded
};

@interface MyOrder : BaseTableViewController
@property (nonatomic, assign) OrderStatusType statusType;
//@property (nonatomic, assign, getter=isFromOrderDone) BOOL fromOrderDone;

-(IBAction)popCurrentNavigationOrderController;

-(void)loadOrderDoneList;
@end
