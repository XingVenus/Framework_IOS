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

@interface LeaderScore ()

@end

@implementation LeaderScore

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"notscorecell";
    static NSString *cellIdentifier2 = @"hasscorecell";
    NotScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell) {
            cell = [[NotScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureCellWithItem:nil atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%ld",(long)indexPath.row);
}

@end
