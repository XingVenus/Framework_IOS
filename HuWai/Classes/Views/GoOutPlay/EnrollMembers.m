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

#define WarnText @"本活动当前还剩余%@个报名名额"

@interface EnrollMembers ()
{
    UIButton *headerBtn;
}

@end

@implementation EnrollMembers

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAction:ActivitySurplusAction params:@"id",self.activityID,nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark request response
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    NSString *surplus = response.data[@"surplus"];
    [headerBtn setTitle:[NSString stringWithFormat:WarnText,surplus] forState:UIControlStateNormal];
}

#pragma mark - custom method 
-(void)addNewCommonPerson:(UIButton *)sender
{
    CommonPersonAddOrEdit *cp = [self.storyboard instantiateViewControllerWithIdentifier:@"CommonPersonAddOrEditBoard"];
    cp.pageType = AddType;
    [self.navigationController pushViewController:cp animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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
    return 10;
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
        [cell configureCellWithItem:nil atIndexPath:indexPath];
        return cell;
    }
}

-(void)selectedItem:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    if (btn.selected) {
        [btn setSelected:NO];
        //数据删除
        
    }else{
        [btn setSelected:YES];
        //数据添加
    }
}
@end
