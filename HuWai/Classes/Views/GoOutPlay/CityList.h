//
//  CityList.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewController.h"
#import "HotCityModel.h"

@protocol CityListDelegate <NSObject>

@optional
-(void)didSelectedHotCity:(HotCityInfo *)hotcity;

@end

@interface CityList : BaseTableViewController

@property (nonatomic, weak) id<CityListDelegate> delegate;

@end
