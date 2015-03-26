//
//  NoticeList.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol NoticeListDelegate <NSObject>

@optional
-(void)didGetNoticeList;
@end

@interface NoticeList : BaseTableViewController

@property(nonatomic, strong) id<NoticeListDelegate> delegate;

@end
