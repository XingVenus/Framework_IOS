//
//  ConfirmToPayment.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ConfirmToPayment.h"
#import "OrderDetailModel.h"

#import "OrderInfoCell.h"
#import "OrderContactCell.h"

@interface ConfirmToPayment ()
{
    OrderDetailModel *orderDetailModel;
}

@end

@implementation ConfirmToPayment

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadActionWithHUD:OrderDetailAction params:@"order_id",self.order_id,nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == OrderDetailAction) {
        orderDetailModel = [[OrderDetailModel alloc] initWithJsonDict:response.data];
        if (orderDetailModel.joins_info) {
            self.dataSource = [NSMutableArray arrayWithArray:orderDetailModel.joins_info];
        }
        [self.tableView reloadData];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (orderDetailModel.order_info.insurance) {
            return 210;
        }
        return 150;
    }else if(indexPath.section == 1){
        return 90;
    }else{
        return 44;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((section == 0) || (section == 1)|| (section == 2)) {
        return 1;
    }
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = [indexPath section];
    if (section == 0) {
        OrderInfoCell *infocell = [tableView dequeueReusableCellWithIdentifier:@"orderinfocell" forIndexPath:indexPath];
        infocell.selectionStyle = UITableViewCellSelectionStyleNone;
        [infocell configureCellWithItem:orderDetailModel atIndexPath:indexPath];
        return infocell;
    }else if (section == 1){
        OrderContactCell *contactcell = [tableView dequeueReusableCellWithIdentifier:@"ordercontactcell" forIndexPath:indexPath];
        contactcell.selectionStyle = UITableViewCellSelectionStyleNone;
        [contactcell configureCellWithItem:orderDetailModel.contacts_info atIndexPath:indexPath];
        return contactcell;
    }else if(section == 2){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = @"出行人";
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
        return cell;
    }else{
        CommonPersonInfo *personInfo = self.dataSource[indexPath.row];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = personInfo.name;
        cell.detailTextLabel.text = personInfo.phone;
        return cell;
    }

}
@end
