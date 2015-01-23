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
    NSArray *_arrayCells;
}

@end

@implementation Mine

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayCells = @[@"我的订阅",@"我的订单",@"领队打分",@"收藏的活动",@"常用出行人",@"消息",@"系统设置"];
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
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
        cell2.textLabel.text = _arrayCells[row];
        return cell2;
    }
    
    // Configure the cell...
    

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
                
            }
                break;
            case 1:
            {
                break;
            }
            case 2:
            {
                break;
            }
            case 3:
            {
                break;
            }
            case 4:
            {
                [self performSegueWithIdentifier:@"commonperson" sender:self];
                break;
            }
            case 5:
            {
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
