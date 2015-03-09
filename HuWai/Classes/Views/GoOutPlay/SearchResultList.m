//
//  SearchResultList.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-9.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "SearchResultList.h"
#import "ActivityModel.h"
#import "ActivityCell.h"
#import "ActivityDetail.h"

@interface SearchResultList ()

@end

@implementation SearchResultList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"searchReultToDetail"]) {
        ActivityDetail *activityController = segue.destinationViewController;
        ActivityInfo *infoModel = self.dataList[selectedRowIndex.row];
        activityController.activityId = infoModel.aid;
        activityController.detailTitle = @"活动详情";
    }
}
#pragma mark - tableview delegate implement
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/kHeghtRatio;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"resultactivitycell";
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger row = [indexPath row];
    if (row < self.dataList.count) {
        ActivityInfo *infoModel = self.dataList[row];
        [cell configureCellWithItem:infoModel atIndexPath:indexPath];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self performSegueWithIdentifier:@"searchReultToDetail" sender:self];
}

@end
