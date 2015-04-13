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

#import "CommentList.h"
#import "NoticeList.h"

@interface MessageGroup ()<CommentListDelegate, NoticeListDelegate>
{
    CommentList *comment;
    NoticeList *notice;
}

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

-(void)dealloc
{
    comment.delegate = nil;
    notice.delegate = nil;
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
    if ([segue.identifier isEqualToString:@"commentlist"]) {
        comment = segue.destinationViewController;
        if (!comment.delegate) {
            comment.delegate = self;
        }
    }else if ([segue.identifier isEqualToString:@"noticelist"]){
        notice = segue.destinationViewController;
        if (!notice.delegate) {
            notice.delegate = self;
        }
    }
}

#pragma mark delegate method
-(void)didGetCommentList
{
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GroupInfo *info = (GroupInfo *)obj;
        if ([info.type isEqualToString:@"comment"]) {
            info.num = @"0";
        }
    }];
    [self.tableView reloadData];
}

-(void)didGetNoticeList
{
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GroupInfo *info = (GroupInfo *)obj;
        if ([info.type isEqualToString:@"notice"]) {
            info.num = @"0";
        }
    }];
    [self.tableView reloadData];
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
        [MobClick event:@"xiaoxi1"];
        [self performSegueWithIdentifier:@"commentlist" sender:self];
    }else if (row == 1){
        [MobClick event:@"xiaoxi2"];
        [self performSegueWithIdentifier:@"noticelist" sender:self];
    }
}
@end
