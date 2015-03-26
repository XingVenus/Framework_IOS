//
//  CommentList.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CommentList.h"
#import "UserMessageModel.h"
#import "CommentCell.h"

@interface CommentList ()

@end

@implementation CommentList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataSource];//加载数据
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WEAKSELF;
    [self.tableView addFooterWithCallback:^{
        weakSelf.currentPage ++;
        [weakSelf loadDataSource];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource
{
    [self loadAction:MessageListAction params:@"type",@"comment",@"page",@(self.currentPage),@"pagesize",@(self.pageSize),nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == MessageListAction) {
        [self endHeaderOrFooterRefreshing];
        UserMessageModel *comment = [[UserMessageModel alloc] initWithJsonDict:response.data];
        if (self.tableView.isFooterRefreshing) {
            [self.dataSource addObjectsFromArray:comment.data];
        }else{
            self.dataSource = [comment.data mutableCopy];
        }
        [self.tableView reloadData];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CommentCell heightForCellWithText:self.dataSource[indexPath.row] availableWidth:0] + 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *commentIdentifier = @"commentIdentifier";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
    if (!cell) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell configureCellWithItem:self.dataSource[indexPath.row] atIndexPath:indexPath];
    return cell;
}

@end
