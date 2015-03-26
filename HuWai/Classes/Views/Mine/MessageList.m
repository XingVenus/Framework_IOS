//
//  MessageList.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-26.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MessageList.h"
#import "MessageGroupCell.h"
#import "UserMessageModel.h"
#import "NSString+RectSize.h"

@interface MessageList ()

@end

@implementation MessageList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
    WEAKSELF;
    [self.tableView addFooterWithCallback:^{
        weakSelf.currentPage ++;
        [weakSelf loadDataSource];
    }];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource
{
    [self loadAction:MessageListAction params:@"page",[NSNumber numberWithInteger:self.currentPage],@"pagesize",@"10",nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == MessageListAction) {
        UserMessageModel *mModel = [[UserMessageModel alloc] initWithJsonDict:response.data];
        if (self.tableView.isFooterRefreshing) {
            [self.dataSource addObjectsFromArray:mModel.data];
            [self.tableView footerEndRefreshing];
        }else{
            self.dataSource = [mModel.data mutableCopy];
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
#pragma mark tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageInfo *info = self.dataSource[indexPath.row];
    CGSize rect = [info.message stringRectSizeWithfontSize:14.0 andWidth:SCREEN_WIDTH - 8*2 withLineSpacing:5];
    
    return rect.height + 35 + 8 + 10;//上面的距离、下边的距离 以及多的10像素距离
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"messagelistcell";
    MessageGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MessageInfo *info = self.dataSource[indexPath.row];
    [cell configureCellWithItem:info atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%ld",(long)indexPath.row);
}
@end
