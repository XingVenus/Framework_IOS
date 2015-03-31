//
//  ActivityDetail.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewController.h"
@class ActivityDetailModel;
@class TitleAndPriceView;

@protocol ActivityDataDelegate <NSObject>

@optional
-(void)didCancelSubscribe;
-(void)didCancelCollected;

@end

@interface ActivityDetail : BaseTableViewController

@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, strong) NSString *activityId;

@property (nonatomic, weak) id<ActivityDataDelegate> delegate;
@end

@interface TitleAndPriceView : UIView

-(void)setDataInViews:(ActivityDetailModel *)model;
@end
