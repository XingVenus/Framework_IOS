//
//  Mine.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-22.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Mine.h"

@interface Mine ()
{
    NSMutableArray *_arrayCells;
}

@end

@implementation Mine

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayCells = [NSMutableArray arrayWithCapacity:1];
    NSDictionary *listDic = @{@"icon":@"subscribe",@"title":@"我的订阅"};
    [_arrayCells addObject:listDic];
    listDic = @{@"icon":@"form",@"title":@"我的订单"};
    [_arrayCells addObject:listDic];
    listDic = @{@"icon":@"grade",@"title":@"领队打分"};
    [_arrayCells addObject:listDic];
    listDic = @{@"icon":@"collect",@"title":@"收藏的活动"};
    [_arrayCells addObject:listDic];
    listDic = @{@"icon":@"contacts",@"title":@"常用出行人"};
    [_arrayCells addObject:listDic];
    listDic = @{@"icon":@"mynews",@"title":@"消息"};
    [_arrayCells addObject:listDic];
    listDic = @{@"icon":@"setup",@"title":@"系统设置"};
    [_arrayCells addObject:listDic];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    // Return the number of rows in the section.
    return _arrayCells.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100.0;
    }
    
    return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"avatarcell";
    static NSString *CellIdentifier2 = @"minecells";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
        return cell1;
    }else{
        
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        NSDictionary *dic = _arrayCells[row];
        cell2.imageView.image = [UIImage imageNamed:dic[@"icon"]];
        cell2.textLabel.text = dic[@"title"];
        return cell2;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section  = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        [self performSegueWithIdentifier:@"profile" sender:self];
    }else if (section == 1){
        switch (row) {
            case 0:
            {
                [self performSegueWithIdentifier:@"subscribe" sender:self];
            }
                break;
            case 1:
            {
                [self performSegueWithIdentifier:@"myorder" sender:self];
                break;
            }
            case 2:
            {
                [self performSegueWithIdentifier:@"leaderscore" sender:self];
                break;
            }
            case 3:
            {
                [self performSegueWithIdentifier:@"collected" sender:self];
                break;
            }
            case 4:
            {
                [self performSegueWithIdentifier:@"commonperson" sender:self];
                break;
            }
            case 5:
            {
                [self performSegueWithIdentifier:@"messagelist" sender:self];
                break;
            }
            case 6:
            {
                [self performSegueWithIdentifier:@"settings" sender:self];
                break;
            }
            default:
                break;
        }
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
