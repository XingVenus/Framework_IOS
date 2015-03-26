//
//  MessageGroup.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MessageGroup.h"
#import "MessageGroupModel.h"
#import "MessageGroupCell.h"

@interface MessageGroup ()

@end

@implementation MessageGroup

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
    [self loadAction:MessageGroupAction params:nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == MessageGroupAction) {
        self.hideShowMessage = YES;
        MessageGroupModel *groupModel = [[MessageGroupModel alloc] initWithJsonDict:response.data];
        self.dataSource = [groupModel.data mutableCopy];
        [self.tableView reloadData];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"messagegroupcell";
    MessageGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GroupInfo *info = self.dataSource[indexPath.row];
    [cell configureCellWithItem:info atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (row == 0) {
        [self performSegueWithIdentifier:@"commentlist" sender:self];
    }else if (row == 1){
        [self performSegueWithIdentifier:@"noticelist" sender:self];
    }
}
@end
