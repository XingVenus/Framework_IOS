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
    [self loadDataSource];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource
{
    [self loadActionWithHUD:ScoreListAction params:@"type",@"0",@"page",[NSString stringWithInteger:self.currentPage],@"pagesize",@"10",nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == ScoreListAction) {
        ScoreListModel *listmodel = [[ScoreListModel alloc] initWithJsonDict:response.data];
        self.dataSource = [NSMutableArray arrayWithArray:listmodel.data];
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
    if (indexPath.row > 3) {
        return 130;
    }
    return 230;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"notscorecell";
    static NSString *cellIdentifier2 = @"hasscorecell";
    if (indexPath.row>3) {
        HasScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!cell) {
            cell = [[HasScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell configureCellWithItem:nil atIndexPath:indexPath];
        return cell;
    }else{
        
        NotScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell) {
            cell = [[NotScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.starControl1.delegate = self;
        cell.starControl2.delegate = self;
        [cell configureCellWithItem:nil atIndexPath:indexPath];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%ld",(long)indexPath.row);
}

-(void)starsSelectionChanged:(EDStarRating*)control rating:(float)rating
{
    
}

@end
