//
//  LeaderScore.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "LeaderScore.h"
#import "NotScoreCell.h"
#import "HasScoreCell.h"
#import "ScoreListModel.h"

@interface LeaderScore ()<EDStarRatingProtocol>

@end

@implementation LeaderScore

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    [self loadDataSource];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self loadActionWithHUD:ScoreListAction params:@"page",[NSNumber numberWithInteger:self.currentPage],@"pagesize",[NSNumber numberWithInteger:self.pageSize],nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == ScoreListAction) {
        ScoreListModel *listmodel = [[ScoreListModel alloc] initWithJsonDict:response.data];
        if (self.tableView.isFooterRefreshing) {
            [self.dataSource addObjectsFromArray:listmodel.data];
            [self.tableView footerEndRefreshing];
        }else{
            self.dataSource = [NSMutableArray arrayWithArray:listmodel.data];
        }
        self.maxPage = listmodel.pager.pagemax;//当前列表最大页数
        [self.tableView reloadData];
    }else if (tag == ScoreNewAction){
        [self loadActionWithHUD:ScoreListAction params:@"page",@1,@"pagesize",[NSNumber numberWithInteger:self.pageSize*self.currentPage],nil];
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
    if (self.dataSource.count>0) {
        ScoreInfo *score = self.dataSource[indexPath.row];
        if ([score.status intValue] == 1) {
            return 120;
        }
        return 230;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"notscorecell";
    static NSString *cellIdentifier2 = @"hasscorecell";
    NSInteger row = [indexPath row];
    ScoreInfo *score = self.dataSource[row];
    if ([score.status intValue] == 1) {
        HasScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!cell) {
            cell = [[HasScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell configureCellWithItem:score atIndexPath:indexPath];
        return cell;
    }else{
        
        NotScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell) {
            cell = [[NotScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.scoreButton addTarget:self action:@selector(submitScore:) forControlEvents:UIControlEventTouchUpInside];
        }

        cell.starControl1.returnBlock = ^(float rating )
        {
            [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (row == idx) {
                    ScoreInfo *data = (ScoreInfo *)obj;
                    data.accuracyRate = rating;
                }
            }];
        };
        cell.starControl2.returnBlock = ^(float rating )
        {
            [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (row == idx) {
                    ScoreInfo *data = (ScoreInfo *)obj;
                    data.satisfiedRate = rating;
                }
            }];
        };
        [cell configureCellWithItem:score atIndexPath:indexPath];
        return cell;
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DLog(@"%ld",(long)indexPath.row);
//}
-(void)submitScore:(UIButton *)sender
{
    ScoreInfo *data = (ScoreInfo *)self.dataSource[sender.tag];
    NotScoreCell *cell = (NotScoreCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    CGFloat rate1 = cell.starControl1.rating;
    CGFloat rate2 = cell.starControl2.rating;
    if (rate1>0 && rate2>0) {
        [self postActionWithHUD:ScoreNewAction params:@"id",data.sid,@"description",[NSNumber numberWithFloat:rate1],@"server",[NSNumber numberWithFloat:rate2],nil];
    }else{
        [self showMessageWithThreeSecondAtCenter:@"亲，请打分"];
    }
}

//-(void)starsSelectionChanged:(EDStarRating*)control rating:(float)rating
//{
//    
//}

@end
