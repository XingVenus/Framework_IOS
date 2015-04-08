//
//  EnrollMembers.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "EnrollMembers.h"
#import "UIButton+ButtonUtility.h"
#import "CommonPersonAddOrEdit.h"
#import "EnrollMemberCell.h"
#import "CommonPersonModel.h"
#import "ConfirmToPayment.h"

static NSString *WarnText = @"本活动当前还剩余%@个报名名额";

NSString *const EnrollMembersAddNewNotification = @"EnrollMembersAddNewNotification";

@interface EnrollMembers ()
{
    UIButton *headerBtn;
    
    NSString *orderID;
}

- (IBAction)submitOrderAction:(id)sender;
@end

@implementation EnrollMembers

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAction:ActivitySurplusAction params:@"id",self.activityID,nil];
    
    //获取联系人数据
    NSArray *dataArray = [[DatabaseUtil shareDatabase] selectFromTable:COMMON_PERSON_TABLE conditions:@{@"ownerid":[APPInfo shareInit].uid}];
    //----直接从数据库获取
    if (dataArray.count>0) {
        CommonPersonModel *model = [[CommonPersonModel alloc] initWithJsonDict:@{@"data":dataArray}];
        self.dataSource = [model.data mutableCopy];
    }
    if (![APPInfo shareInit].updatedCommonPerson) {
        [self loadActionWithHUD:CommonPersonListAction params:nil];
    }
    
    //添加新出行人通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewMember:) name:EnrollMembersAddNewNotification object:nil];
    //----------
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(20, 5, SCREEN_WIDTH - 40, 40);
    [headerBtn setImage:[UIImage imageNamed:@"horn"] forState:UIControlStateNormal];
    [headerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    headerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [headerBtn setTitle:[NSString stringWithFormat:WarnText,@"0"] forState:UIControlStateNormal];
//    [headerBtn setAdjustsImageWhenHighlighted:NO];
    [headerBtn setTitlePositionWithType:ButtonTitlePostionTypeRight withSpacing:4];
    [headerView addSubview:headerBtn];
    self.tableView.tableHeaderView = headerView;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footerBtn.frame = CGRectMake(20, 15, SCREEN_WIDTH - 40, 40);
    [footerBtn setBackgroundImage:[UIImage imageNamed:@"Login"] forState:UIControlStateNormal];
    [footerBtn setTitle:@"添加新出行人" forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(addNewCommonPerson:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:footerBtn];
    self.tableView.tableFooterView = footerView;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EnrollMembersAddNewNotification object:nil];
}
#pragma mark request response
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == ActivitySurplusAction) {
        NSString *surplus = response.data[@"surplus"];
        [headerBtn setTitle:[NSString stringWithFormat:WarnText,surplus] forState:UIControlStateNormal];
    }else if(tag == OrderCreateAction){
        orderID = response.data[@"order_id"];
        [self performSegueWithIdentifier:@"confirmtopayment" sender:self];
    }else if (tag == CommonPersonListAction){
        if (response.data) {
            [APPInfo shareInit].updatedCommonPerson = YES; //本次标记为已经更新
            CommonPersonModel *model = [[CommonPersonModel alloc] initWithJsonDict:response.data];
            self.dataSource = [model.data mutableCopy];
            [self.tableView reloadData];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作--插入数据库
                for (CommonPersonInfo *pInfo in model.data) {
                    NSArray *result = [[DatabaseUtil shareDatabase] selectFromTable:COMMON_PERSON_TABLE conditions:@{@"id":pInfo.pid}];
                    if (result.count == 0) {
                        [[DatabaseUtil shareDatabase] insertTableName:COMMON_PERSON_TABLE keyArray:@[@"id",@"name",@"gender",@"identity",@"phone",@"ownerid"] valueArrary:@[pInfo.pid,pInfo.name,pInfo.gender,pInfo.identity,pInfo.phone,[APPInfo shareInit].uid]];
                    }
                }
            });
        }
    }
}

#pragma mark - custom method 
-(void)addNewCommonPerson:(UIButton *)sender
{
    CommonPersonAddOrEdit *cp = [self.storyboard instantiateViewControllerWithIdentifier:@"CommonPersonAddOrEditBoard"];
    cp.pageType = AddType;
    cp.isFromEnroll = YES;
    [self.navigationController pushViewController:cp animated:YES];
}

-(void)addNewMember:(NSNotification *)notice
{
    NSString *pid = [notice object];
    NSArray *newOne = [[DatabaseUtil shareDatabase] selectFromTable:COMMON_PERSON_TABLE conditions:@{@"id":pid,@"ownerid":[APPInfo shareInit].uid}];
    CommonPersonInfo *infoObj = [[CommonPersonInfo alloc] initWithJsonDict:newOne[0]];
    [self.dataSource addObject:infoObj];
    [self.tableView reloadData];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"confirmtopayment"]) {
        ConfirmToPayment *confirmController = segue.destinationViewController;
        confirmController.order_id = orderID;
    }
}

#pragma mark - tableview method 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *identity1 = @"membersTextCell";
    
    if (section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = @"常用出行人";
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        return cell;
    }else{
        EnrollMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"enrollMemeberCell" forIndexPath:indexPath];
        [cell.checkBtn addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchUpInside];
        CommonPersonInfo *info = self.dataSource[row];
        [cell configureCellWithItem:info atIndexPath:indexPath];
        return cell;
    }
}

-(void)selectedItem:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    if (btn.selected) {
        [btn setSelected:NO];
    }else{
        [btn setSelected:YES];
    }
    
    //设置按钮选中状态-(数据添加或删除)
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == tag) {
            ((CommonPersonInfo *)obj).isSelected = btn.selected;
        }
    }];
}
#pragma mark 提交订单
- (IBAction)submitOrderAction:(id)sender {
    __block NSMutableArray *memberIDs = [NSMutableArray arrayWithCapacity:1];
    NSString *memberIDString = @"";
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CommonPersonInfo *info = (CommonPersonInfo *)obj;
        if (info.isSelected) {
            [memberIDs addObject:info.pid];
        }
    }];
    if (memberIDs) {
        memberIDString = [memberIDs componentsJoinedByString:@","];
    }
    
    [self postActionWithHUD:OrderCreateAction message:@"提交订单" params:@"id",self.activityID,@"realname",self.realname,@"phone",self.phone,@"o_realname",self.o_realname,@"o_phone",self.o_phone,@"message",@"",@"joins",memberIDString ,nil];
    
}
@end
