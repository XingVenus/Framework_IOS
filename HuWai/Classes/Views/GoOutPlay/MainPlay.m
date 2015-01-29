//
//  MainPlay.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MainPlay.h"
#import "ActivityCell.h"
@interface MainPlay ()

@end

@implementation MainPlay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_WIDTH/2, 22);
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"出去玩";
    [self.navigationController.navigationBar addSubview:titleLabel];

//    self.navigationController.navigationBar.frame = CGRectMake(0., 20., 320., 180.);
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.frame = CGRectMake(0., 20., 320., 180.);
    if (![APPInfo shareInit].isLogin) {
        
//        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
//        [self presentViewController:loginNav animated:NO completion:nil];
        //[UIApplication sharedApplication].keyWindow.rootViewController
    }
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
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/kHeghtRatio;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"activitycell";
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureCellWithItem:nil atIndexPath:indexPath];
    return cell;
}

@end
