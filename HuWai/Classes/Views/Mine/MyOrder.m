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
#import "BaseNavigationController.h"
#import "ActivityDetail.h"

//static const NSString *kWaiting = @"waiting";
//static const NSString *kCompleted = @"completed";
//static const NSString *kCanceled = @"canceled";
//static const NSString *kRefunded = @"refunded";

@interface MyOrder ()<UIAlertViewDelegate>
{
    NSArray *statusArray;
}

@property (nonatomic, strong) HMSegmentedControl *segmentControl;

@end

@implementation MyOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    self.statusType = OrderStatusWating;
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
    [self.tableView addHeaderWithCallback:^{
        weakSelf.currentPage = 1;
        [self loadDataSource];
    } dateKey:@"myorderlist"];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithCallback:^{
        if (![self checkIsLastPage]) {
            weakSelf.currentPage ++;
            [weakSelf loadDataSource];
        }
    }];
    //加载页面数据
    if (self.fromOrderDone) {
        [self loadOrderDoneList];
    }else{
        [self loadDataSource];
    }
    //添加支付完成刷新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadOrderDoneList) name:MyOrderListLoadNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    DLog(@"%lu",(unsigned long)self.tabBarController.selectedIndex);
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    [self.tabBarController setSelectedIndex:1];
    [MobClick beginLogPageView:self.title];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MyOrderListLoadNotification object:nil];
}

-(void)loadDataSource
{
    [self loadAction:OrderMyAction params:@"type",statusArray[self.statusType],@"page",@(self.currentPage),@"pagesize",@(self.pageSize*2),nil];
}

-(void)loadOrderDoneList
{
    [self.segmentControl setSelectedSegmentIndex:1 animated:NO];
    self.statusType = OrderStatusCompleted;
//    [self loadAction:OrderMyAction params:@"type",@"completed",@"page",@(self.currentPage),@"pagesize",@(self.pageSize*2),nil];
    [self loadDataSource];
}

-(void)popCurrentNavigationOrderController
{
//    if (self.fromOrderDone) {
//        [self.navigationController dismissViewControllerAnimated:YES completion:^{
//            
//        }];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    if (self.tabBarController.selectedIndex == 0) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        [self.tabBarController setSelectedIndex:2];
//        [self.navigationController dismissViewControllerAnimated:YES completion:^{
//            
//        }];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    if (self.fromOrderDone) {
        if ([[APPInfo shareInit].payFromType isEqualToString:@"enroll"]) {
            [self dismissNavigationView:YES];
        }
    }else{
        [self popToLastView:YES];
    }
}
#pragma mark - custom method 
#pragma mark 取消支付
-(void)cancelOrderAction:(UIButton *)sender
{
    UIAlertView *cancelAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定取消订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [cancelAlert show];
    OrderInfo *info = self.dataSource[sender.tag];
    objc_setAssociatedObject(self, &OrderCancelAssociatedKey, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [MobClick event:@"dd_qx"];
        OrderInfo *orderinfo = objc_getAssociatedObject(self, &OrderCancelAssociatedKey);
        [self postActionWithHUD:OrderCancelAction params:@"order_id",orderinfo.order_id,nil];
    }
}
#pragma mark 去支付
-(void)paymentAction:(UIButton *)sender
{
    OrderInfo *info = self.dataSource[sender.tag];
    ConfirmToPayment *payController = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmToPaymentBoard"];
    [APPInfo shareInit].payFromType = @"orderlist";
    payController.order_id = info.order_id;
    BaseNavigationController *payNav = [[BaseNavigationController alloc] initWithRootViewController:payController];
    [self presentViewController:payNav animated:YES completion:nil];
}
#pragma mark data request finish 网络数据请求成功
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == OrderMyAction) {
        UserOrderModel *orderModel = [[UserOrderModel alloc] initWithJsonDict:response.data];
        if (self.tableView.headerRefreshing) {
             self.currentPage = 1;
            self.dataSource = [NSMutableArray arrayWithArray:orderModel.data];
            [self.tableView headerEndRefreshing];
        }else if(self.tableView.isFooterRefreshing){
            [self.dataSource addObjectsFromArray:orderModel.data];
            [self.tableView footerEndRefreshing];
        }else{
            self.currentPage = 1;
            self.dataSource = [NSMutableArray arrayWithArray:orderModel.data];
        }
        self.maxPage = orderModel.pager.pagemax;
        [self.tableView reloadData];
    }else if (tag == OrderCancelAction){
        [self loadDataSource];
    }
}

#pragma mark set segmentcontrol method
-(HMSegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"待付款",@"已付款",@"已取消",@"已退款"]];
        _segmentControl.font = [UIFont systemFontOfSize:15.0];
        _segmentControl.showBorderLine = YES;
        _segmentControl.borderLineColor = APP_DIVIDELINE_COLOR;
        _segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.textColor = [UIColor darkGrayColor];
        _segmentControl.selectionIndicatorColor = [UIColor orangeColor];//[UIColor colorWithRed:46/255.0 green:181/255.0 blue:220/255.0 alpha:1];
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectedTextColor = [UIColor orangeColor];
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        
        WEAKSELF;
        [_segmentControl setIndexChangeBlock:^(NSInteger index) {
            DLog(@"selected index is:%d",(int)index);
            weakSelf.currentPage = 1;
            weakSelf.statusType = index;
            [weakSelf loadDataSource];
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
            return 210.0+40;
        }
        return 150.0+40;
    }else{
        if (info.insurance) {
            return 165.0+40;
        }
        return 105.0+40;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    OrderInfo *info = self.dataSource[indexPath.row];
//    ActivityDetail *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"activityDetailBoard"];
//    detail.activityId = info.goods_id;
//    [self.navigationController pushViewController:detail animated:YES];
    
    OrderInfo *info = self.dataSource[indexPath.row];
    ConfirmToPayment *payController = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmToPaymentBoard"];
    payController.order_id = info.order_id;
    BaseNavigationController *payNav = [[BaseNavigationController alloc] initWithRootViewController:payController];
    [self presentViewController:payNav animated:YES completion:nil];
}
@end
