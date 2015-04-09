//
//  CommonPerson.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CommonPerson.h"
#import "CommonPersonAddOrEdit.h"
#import "CommonPersonModel.h"
@interface CommonPerson ()<CommonPersonDataDelegate>
{
    CommonPersonInfo *deleteInfo;
    CommonPersonAddOrEdit *addoreditController;
}

@end

@implementation CommonPerson

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (CURRENT_SYS_VERSION>=7.0) {
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    [self loadDataSource];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

-(void)dealloc
{
    addoreditController.delegate = nil;
}

-(void)loadDataSource
{
    NSArray *dataArray = [[DatabaseUtil shareDatabase] selectFromTable:COMMON_PERSON_TABLE conditions:@{@"ownerid":[APPInfo shareInit].uid}];
    //直接从数据库获取
    if (dataArray.count>0) {
        CommonPersonModel *model = [[CommonPersonModel alloc] initWithJsonDict:@{@"data":dataArray}];
        self.dataSource = [model.data mutableCopy];
    }
    if (![APPInfo shareInit].updatedCommonPerson) {
        [self loadActionWithHUD:CommonPersonListAction params:nil];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{

    if (tag == CommonPersonListAction) {
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
    }else if (tag == CommonPersonDeleteAction){
        DLog(@"%@",deleteInfo);
        [[DatabaseUtil shareDatabase] deleteFromTableName:COMMON_PERSON_TABLE conditionString:[NSString stringWithFormat:@"id = %@ and ownerid = %@",deleteInfo.pid,[APPInfo shareInit].uid]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"addCommonPersonCell";
    static NSString *CellIdentifier2 = @"commonPersonCell";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
        cell1.imageView.image = [UIImage imageNamed:@"add-p"];
        cell1.textLabel.text = @"添加一位";
        return cell1;
    }else{
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        CommonPersonInfo *info = self.dataSource[row];
        cell2.textLabel.text = info.name;
        cell2.detailTextLabel.text = info.phone;
        return cell2;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
// 删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        deleteInfo = self.dataSource[indexPath.row];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //网络请求删除
        [self postActionWithHUD:CommonPersonDeleteAction params:@"id",deleteInfo.pid,nil];
    }
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    addoreditController = segue.destinationViewController;
    
    NSIndexPath *selectedRowIndex=[self.tableView indexPathForSelectedRow];
    addoreditController.delegate = self;
    if (selectedRowIndex.section == 0) {
        addoreditController.pageType = AddType;
    }else{
        addoreditController.pageType = EditType;
        CommonPersonInfo *item = (CommonPersonInfo *)self.dataSource[selectedRowIndex.row];
        addoreditController.pid = item.pid;
    }
    
}

#pragma mark CommonPersonDataDelegate method
-(void)addOrEditDone
{
    [self loadDataSource];
}
@end
