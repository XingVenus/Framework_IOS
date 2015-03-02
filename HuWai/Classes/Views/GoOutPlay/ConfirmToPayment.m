//
//  ConfirmToPayment.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ConfirmToPayment.h"
#import "OrderDetailModel.h"

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
