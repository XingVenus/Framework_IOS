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
#import "OrderGoOutCell.h"
#import "PayTypeCell.h"
#import "PayView.h"

@interface ConfirmToPayment ()
{
    OrderDetailModel *orderDetailModel;
    NSString *payType;
}
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *confirmTotalMoneyLabel;


@property (weak, nonatomic) IBOutlet UIButton *confirmPayBtn;

@end

@implementation ConfirmToPayment

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadActionWithHUD:OrderDetailAction params:@"order_id",self.order_id,nil];
    [self.confirmPayBtn addTarget:self action:@selector(confirmPayAction) forControlEvents:UIControlEventTouchUpInside];
    
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
        NSString *text = [NSString stringWithFormat:@"合计:%@元",orderDetailModel.order_info.money];
        [self.confirmTotalMoneyLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            NSRange boldRange = [[mutableAttributedString string] rangeOfString:orderDetailModel.order_info.money options:NSRegularExpressionSearch];
            
            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
            UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:20];
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            if (font) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[[UIColor orangeColor] CGColor] range:boldRange];
                CFRelease(font);
            }
            return mutableAttributedString;
        }];
        [self.tableView reloadData];
    }else if (tag == OrderGoAction){
        PayView *paycontroller = [[PayView alloc] init];
        paycontroller.urlString = response.data[@"href"];
        paycontroller.title = @"支付宝";
        [self.navigationController pushViewController:paycontroller animated:YES];
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
    if (orderDetailModel) {
        if (indexPath.section == 0) {
            if (orderDetailModel.order_info.insurance) {
                return 210;
            }
            return 150;
        }else if(indexPath.section == 1){
            return 90;
        }else if(indexPath.section == 2){
            if (orderDetailModel.joins_info) {
                return 45+10+45*self.dataSource.count;
            }
            return 0;
        }else if (indexPath.section == 3){
            return 95.0;
        }
    }
    return 0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ((section == 0) || (section == 1)|| (section == 2)) {
//        return 1;
//    }
//    return self.dataSource.count;
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([orderDetailModel.order_status.value isEqualToString:@"1"]) {
        return 4;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = [indexPath section];
    if (section == 0) {
        OrderInfoCell *infocell = [tableView dequeueReusableCellWithIdentifier:@"orderinfocell" forIndexPath:indexPath];
        infocell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (orderDetailModel) {
            [infocell configureCellWithItem:orderDetailModel atIndexPath:indexPath];
        }
        return infocell;
    }else if (section == 1){
        OrderContactCell *contactcell = [tableView dequeueReusableCellWithIdentifier:@"ordercontactcell" forIndexPath:indexPath];
        contactcell.selectionStyle = UITableViewCellSelectionStyleNone;
        [contactcell configureCellWithItem:orderDetailModel.contacts_info atIndexPath:indexPath];
        return contactcell;
    }else if(section == 2){
        OrderGoOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderegooutcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configureCellWithItem:self.dataSource atIndexPath:indexPath];
        return cell;
    }else if (section == 3){
        PayTypeCell *typecell = [tableView dequeueReusableCellWithIdentifier:@"paytypecell" forIndexPath:indexPath];
        typecell.selectionStyle = UITableViewCellSelectionStyleNone;
        [typecell.aliPayBtn addTarget:self action:@selector(payTypeSelection:) forControlEvents:UIControlEventTouchUpInside];
        return typecell;
    }else{
        return nil;
    }
}

-(void)payTypeSelection:(UIButton *)btn
{
    [btn setSelected:!btn.selected];
    if (btn.selected) {
        payType = @"alipay";
    }else{
        payType = nil;
    }
}

- (void)confirmPayAction
{
    if (payType) {
        [self postActionWithHUD:OrderGoAction params:@"order_id",self.order_id,nil];
    }else{
        [self showMessageWithThreeSecondAtCenter:@"请选择支付方式"];
    }
}
@end
