//
//  Subscribe.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Subscribe.h"
#import "ActivityCell.h"
#import "BlankView.h"
@interface Subscribe ()

@end

@implementation Subscribe

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BlankView *bview = [[BlankView alloc] initWithFrame:CGRectMake(0, 100 - [CommonFoundation getAdapter64Height], SCREEN_WIDTH, 200)];
    bview.textLabel.text = @"您还未订阅任何领队";
//    bview.hidden = YES;
    bview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
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
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureCellWithItem:nil atIndexPath:indexPath];
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
