//
//  Mine.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-22.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Mine.h"
#import "PAAImageView.h"

@interface Mine ()
{
    NSMutableArray *_arrayCells;
}

@end

@implementation Mine

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayCells = [NSMutableArray arrayWithCapacity:1];
    NSDictionary *listDic = @{@"icon":@"form",@"title":@"我的订单"};
    [_arrayCells addObject:@[listDic]];
    NSDictionary *dic1 = @{@"icon":@"subscribe",@"title":@"我的订阅"};
    NSDictionary *dic2 = @{@"icon":@"grade",@"title":@"领队打分"};
    NSDictionary *dic3 = @{@"icon":@"collect",@"title":@"收藏的活动"};
    NSDictionary *dic4 = @{@"icon":@"contacts",@"title":@"常用出行人"};
    [_arrayCells addObject:@[dic1,dic2,dic3,dic4]];
    NSDictionary *dic5 = @{@"icon":@"mynews",@"title":@"消息"};
    NSDictionary *dic6 = @{@"icon":@"setup",@"title":@"系统设置"};
    [_arrayCells addObject:@[dic5,dic6]];
    
    [self initHeaderView];
//    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
//    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initHeaderView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    backView.backgroundColor = APP_BACKGROUND_COLOR;
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head-img"]];
    imageview.frame = CGRectMake(0, 10, SCREEN_WIDTH, 100);
    [backView addSubview:imageview];
    if ([CacheBox getCache:CACHE_TOKEN]) {
        //显示头像以及名称
        PAAImageView *avatar = [[PAAImageView alloc] initWithFrame:CGRectMake(20, 0, 55, 55) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor grayColor]];
        avatar.centerY = backView.height/2;
        avatar.placeHolderImage = [UIImage imageNamed:@"avatar"];
        //            [avatar setImageURL:[CacheBox getCache:CACHE_TOKEN]];
        [backView addSubview:avatar];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 120, 30)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.centerY = backView.height/2;
        nameLabel.text = [CacheBox getCache:USERNAME_CACHE];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-r-g"]];
        arrowImage.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 12, 20);
        arrowImage.centerY = backView.height/2;
        [backView addSubview:arrowImage];
        [backView addSubview:nameLabel];
    }else{
        //提示语以及登录按钮
        
    }
    self.tableView.tableHeaderView = backView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return _arrayCells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayCells[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier1 = @"avatarcell";
    static NSString *CellIdentifier2 = @"minecells";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *array = _arrayCells[section];
    NSDictionary *dic = array[row];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
    cell2.imageView.image = [UIImage imageNamed:dic[@"icon"]];
    cell2.textLabel.text = dic[@"title"];
        return cell2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    switch (section) {
        case 0:
            if (row == 0) {
                [self performSegueWithIdentifier:@"myorder" sender:self];
                break;
            }
            break;
        case 1:
            if (row == 0) {
                [self performSegueWithIdentifier:@"subscribe" sender:self];
            }else if(row == 1){
                [self performSegueWithIdentifier:@"leaderscore" sender:self];
            }else if (row == 2){
                [self performSegueWithIdentifier:@"collected" sender:self];
            }else if (row == 3){
                [self performSegueWithIdentifier:@"commonperson" sender:self];
            }
            break;
        case 2:
            if (row == 0) {
                [self performSegueWithIdentifier:@"messagelist" sender:self];
            }else if (row == 1){
                [self performSegueWithIdentifier:@"settings" sender:self];
                break;
            }
            break;
            
        default:
            break;
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

@end
