//
//  Subscribe.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Subscribe.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import "ActivityDetail.h"

@interface Subscribe ()

@end

@implementation Subscribe

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadDataSource];
    [self.tableView addFooterWithCallback:^{
        weakSelf.currentPage = self.currentPage + 1;
        [weakSelf loadDataSource];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource
{
    [self loadActionWithHUD:RssListAction params:@"page",[NSString stringWithInteger:self.currentPage],@"pagesize",@"10",nil];
}
#pragma mark - request data response
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == RssListAction) {
        ActivityModel *aModel = [[ActivityModel alloc] initWithJsonDict:response.data];
        if (aModel.data) {
            if (self.tableView.isFooterRefreshing) {
                [self.dataSource addObjectsFromArray:aModel.data];
                [self.tableView footerEndRefreshing];
            }else{
                self.dataSource = [NSMutableArray arrayWithArray:aModel.data];
            }
            [self.tableView reloadData];
        }else{
            if (self.currentPage == 1) {
                self.blankView.textTitle = @"您还未订阅任何领队";
                self.blankView.imageIcon = [UIImage imageNamed:@"expression-wu"];
                self.blankView.hidden = NO;
            }
            if (self.tableView.isFooterRefreshing) {
                [self showMessageWithThreeSecondAtCenter:@"没有更多数据了"];
                [self.tableView footerEndRefreshing];
            }
        }
    }
}

#pragma mark tableview data soure delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/kHeghtRatio;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"activitycell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger row = [indexPath row];
    if (row < self.dataSource.count) {
        ActivityInfo *infoModel = self.dataSource[row];
        [cell configureCellWithItem:infoModel atIndexPath:indexPath];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%ld",(long)indexPath.row);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
