//
//  SelectListView.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ListType) {
    ListTypeDestination,
    ListTypeTime,
    ListTypePlay
};

@protocol SelectListViewDelegate <NSObject>

@optional
-(void)selectedValueForListType:(ListType)listType value:(NSString *)value;

@end

@interface SelectListView : UIView<UITableViewDataSource,UITableViewDelegate>
- (id)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, weak) id<SelectListViewDelegate> delegate;
@property (nonatomic) ListType listType;

@end
