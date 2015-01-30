//
//  SelectListView.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectListView : UIView<UITableViewDataSource,UITableViewDelegate>
- (id)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listData;

@end
