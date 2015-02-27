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
@interface CommonPerson ()

@end

@implementation CommonPerson

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataSource];
//    NSArray *dataArray = @[@"aa",@"bb",@"cc",@"dd",@"aa",@"bb",@"cc",@"dd",@"aa",@"bb",@"cc",@"dd",@"aa",@"bb",@"cc",@"dd"];
//    [self.dataSource addObjectsFromArray:dataArray];
    // Do any additional setup after loading the view.
}

-(void)loadDataSource
{
//    [self postAppendUriAction:CommonPersonListAction withValue:[APPInfo shareInit].uid params:nil];
    [self postActionWithHUD:CommonPersonListAction params:nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (response.code == 20000) {
        if (tag == CommonPersonListAction) {
            if (response.data) {
                CommonPersonModel *model = [[CommonPersonModel alloc] initWithJsonDict:response.data];
                self.dataSource = [model.data mutableCopy];
                [self.tableView reloadData];
            }
        }
    }
    
    [self showMessageWithThreeSecondAtCenter:response.message];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
        return cell2;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CommonPersonAddOrEdit *addoreditController = segue.destinationViewController;
    
    NSIndexPath *selectedRowIndex=[self.tableView indexPathForSelectedRow];

    if (selectedRowIndex.section == 0) {
        addoreditController.pageType = AddType;
    }else{
        addoreditController.pageType = EditType;
        addoreditController.info = (CommonPersonInfo *)self.dataSource[selectedRowIndex.row];
    }
    
}


@end
