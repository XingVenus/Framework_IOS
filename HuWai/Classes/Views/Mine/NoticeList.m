//
//  NoticeList.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "NoticeList.h"
#import "NoticeCell.h"
#import "UserMessageModel.h"

@interface NoticeList ()

@end

@implementation NoticeList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataSource];//加载数据
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WEAKSELF;
    [self.tableView addFooterWithCallback:^{
        if (![self checkIsLastPage]) {
            weakSelf.currentPage ++;
            [weakSelf loadDataSource];
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

-(void)loadDataSource
{
    [self loadAction:MessageListAction params:@"type",@"notice",@"page",@(self.currentPage),@"pagesize",@(self.pageSize),nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == MessageListAction) {
        [self endHeaderOrFooterRefreshing];
        UserMessageModel *notice = [[UserMessageModel alloc] initWithJsonDict:response.data];
        self.maxPage = notice.pager.pagemax;
        if (self.tableView.isFooterRefreshing) {
            [self.dataSource addObjectsFromArray:notice.data];
        }else{
            self.dataSource = [notice.data mutableCopy];
            if (_delegate && [_delegate respondsToSelector:@selector(didGetNoticeList)]) {
                [_delegate didGetNoticeList];
            }
        }
        [self.tableView reloadData];
        
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NoticeCell heightForCellWithText:self.dataSource[indexPath.row] availableWidth:AvalibleWidth] + 10 + 5*3 + 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *commentIdentifier = @"commentIdentifier";
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
    if (!cell) {
        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell configureCellWithItem:self.dataSource[indexPath.row] atIndexPath:indexPath];
    return cell;
}

@end
