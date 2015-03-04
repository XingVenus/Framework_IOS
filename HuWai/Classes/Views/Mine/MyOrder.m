//
//  MyOrder.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MyOrder.h"
#import "HMSegmentedControl.h"
#import "MyOrderCell.h"
#import "MJRefresh.h"
#import "UserOrderModel.h"
#import "ConfirmToPayment.h"

//static const NSString *kWaiting = @"waiting";
//static const NSString *kCompleted = @"completed";
//static const NSString *kCanceled = @"canceled";
//static const NSString *kRefunded = @"refunded";

@interface MyOrder ()
{
    NSArray *statusArray;
    __block NSInteger currentPage;
}

@property (nonatomic, strong) HMSegmentedControl *segmentControl;

@end

@implementation MyOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    currentPage = 1;
    statusArray = @[@"waiting",@"completed",@"canceled",@"refunded"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.segmentControl];
    if (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.segmentControl.top = 64;
    }else{
        self.segmentControl.top = 0;
    }
    //请求数据
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData) dateKey:@"myorderlist"];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithCallback:^{
        currentPage = currentPage+1;
        [self loadActionWithHUD:OrderMyAction params:@"type",statusArray[OrderStatusWating],@"page",[NSString stringWithInteger:currentPage],@"pagesize",@"10",nil];
    }];
    
    [self loadActionWithHUD:OrderMyAction params:@"type",statusArray[OrderStatusWating],@"page",@"1",@"pagesize",@"10",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - custom method 
#pragma mark 取消支付
-(void)cancelOrderAction:(UIButton *)sender
{
    
}
#pragma mark 去支付
-(void)paymentAction:(UIButton *)sender
{
    OrderInfo *info = self.dataSource[sender.tag];
    ConfirmToPayment *payController = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmToPaymentBoard"];
    payController.order_id = info.order_id;
    [self.navigationController pushViewController:payController animated:YES];
}

-(void)refreshData
{
    [self loadActionWithHUD:OrderMyAction params:@"type",statusArray[self.statusType],@"page",@"1",@"pagesize",@"10",nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == OrderMyAction) {
        UserOrderModel *orderModel = [[UserOrderModel alloc] initWithJsonDict:response.data];
        if (self.tableView.headerRefreshing) {
            currentPage = 1;
            self.dataSource = [NSMutableArray arrayWithArray:orderModel.data];
            [self.tableView headerEndRefreshing];
        }else if(self.tableView.isFooterRefreshing){
            [self.dataSource addObjectsFromArray:orderModel.data];
            [self.tableView footerEndRefreshing];
        }else{
            currentPage = 1;
            self.dataSource = [NSMutableArray arrayWithArray:orderModel.data];
        }
        [self.tableView reloadData];
    }
}

#pragma mark set segmentcontrol method
-(HMSegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"待付款",@"已付款",@"已取消",@"已退款"]];
        _segmentControl.showBorderLine = YES;
        _segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.textColor = [UIColor blackColor];
        _segmentControl.selectionIndicatorColor = [UIColor colorWithRed:46/255.0 green:181/255.0 blue:220/255.0 alpha:1];
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectedTextColor = [UIColor blackColor];
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        
        WEAKSELF;
        [_segmentControl setIndexChangeBlock:^(NSInteger index) {
            DLog(@"selected index is:%d",(int)index);
            weakSelf.statusType = index;
            [weakSelf refreshData];
        }];
    }
    return _segmentControl;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfo *info = self.dataSource[indexPath.row];
    if (self.statusType == OrderStatusWating) {
        if (info.insurance) {
            return 210.0;
        }
        return 150.0;
    }else{
        if (info.insurance) {
            return 165.0;
        }
        return 105.0;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"orderCell";
    static NSString *cellidentifier2 = @"orderCell2";
    static NSString *cellidentifier3 = @"orderCell3";
    static NSString *cellidentifier4 = @"orderCell4";
    OrderInfo *info = self.dataSource[indexPath.row];
    if (self.statusType == OrderStatusWating) {
        if (info.insurance) {
            MyOrderCell *cell = (MyOrderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withInsurance:YES isWating:YES];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.cancelBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.paymentBtn addTarget:self action:@selector(paymentAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell configureCellWithItem:info atIndexPath:indexPath];
            return cell;
        }else{
            MyOrderCell *cell = (MyOrderCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier2];
            
            if (cell == nil) {
                cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier2 withInsurance:NO isWating:YES];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.cancelBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.paymentBtn addTarget:self action:@selector(paymentAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell configureCellWithItem:info atIndexPath:indexPath];
            return cell;
        }
        
    }else{
        if (info.insurance) {
            MyOrderCell *cell = (MyOrderCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier3];
            
            if (cell == nil) {
                cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier3 withInsurance:YES isWating:NO];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell configureCellWithItem:info atIndexPath:indexPath];
            return cell;
        }else{
            MyOrderCell *cell = (MyOrderCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier4];
            
            if (cell == nil) {
                cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier4 withInsurance:NO isWating:NO];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell configureCellWithItem:info atIndexPath:indexPath];
            return cell;
        }
        
    }
}
@end
