//
//  OrderDone.m
//  HuWai
//
//  Created by WmVenusMac on 15-4-8.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "OrderDone.h"
#import "PayDoneForActivityCell.h"
#import "MyOrder.h"

@interface OrderDone ()

@end

@implementation OrderDone

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
    if ([segue.identifier isEqualToString:@"orderdonetolist"]) {
        MyOrder *orderController = segue.destinationViewController;
        orderController.fromOrderDone = YES;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderDetailModel.order_info.insurance) {
        return 270.f;
    }
    return 210;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"payDoneCell";
    PayDoneForActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PayDoneForActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier withInsurance:self.orderDetailModel.order_info.insurance?YES:NO];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.forwardOrderBtn addTarget:self action:@selector(goToOrderList:) forControlEvents:UIControlEventTouchUpInside];
    [cell configureCellWithItem:self.orderDetailModel atIndexPath:indexPath];
    return cell;
}

-(void)goToOrderList:(UIButton *)sender
{
    if ([[APPInfo shareInit].payFromType isEqualToString:@"enroll"]) {
        [self performSegueWithIdentifier:@"orderdonetolist" sender:self];
    }else if([[APPInfo shareInit].payFromType isEqualToString:@"orderlist"]){
        [self dismissNavigationView:NO];
    }
}

@end
