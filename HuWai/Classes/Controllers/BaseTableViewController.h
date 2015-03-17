//
//  BaseTableTableViewController.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MJRefresh.h"
typedef void(^DidChangeLocationCityBlock)();

@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
/**
 *  显示大量数据的控件
 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;
/**
 *  初始化init的时候设置tableView的样式才有效
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/**
 *  table的数据源对象
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;
/**
 *  最大页数
 */
@property (nonatomic, assign) NSInteger maxPage;
/**
 *  每页的数量
 */
@property (nonatomic, assign) NSInteger pageSize;
/**
 *  去除iOS7新的功能api，tableView的分割线变成iOS6正常的样式
 */
- (void)configuraTableViewNormalSeparatorInset;

/**
 *  配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
 *
 *  @param tableView 目标tableView
 */
- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;

/**
 *  加载本地或者网络数据源
 */
- (void)loadDataSource;

//custom method for this app
- (void)alertChangeLocationCity:(NSString *)cityName didChangeCityBlock:(DidChangeLocationCityBlock)changeBlock;

- (BOOL)checkIsLastPage;
@end
