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

-(void)loadDataSource
{
    [self loadActionWithHUD:RssListAction params:@"page",@(self.currentPage),@"pagesize",@(self.pageSize),nil];
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
        }
        self.maxPage = aModel.pager.pagemax;
    }
}

#pragma mark tableview data soure delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/kHeghtRatio+10;
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
    [self performSegueWithIdentifier:@"subscribeActivityDetail" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"subscribeActivityDetail"]) {
        ActivityDetail *activityController = segue.destinationViewController;
        ActivityInfo *infoModel = self.dataSource[selectedRowIndex.row];
        activityController.activityId = infoModel.aid;
        activityController.detailTitle = @"活动详情";
    }
}


@end
