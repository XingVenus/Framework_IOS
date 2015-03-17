//
//  BaseTableTableViewController.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewController.h"



@interface BaseTableViewController ()<UIAlertViewDelegate>
{
    UIAlertView *alert;
}
/**
 *  判断tableView是否支持iOS7的api方法
 *
 *  @return 返回预想结果
 */
- (BOOL)validateSeparatorInset;

@property (nonatomic, copy) DidChangeLocationCityBlock didChangeLocationCityBlock;
@end

@implementation BaseTableViewController

#pragma mark - TableView Helper Method

- (BOOL)validateSeparatorInset {
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        return YES;
    }
    return NO;
}

#pragma mark - Publish Method

- (void)configuraTableViewNormalSeparatorInset {
    if ([self validateSeparatorInset]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView {
    if ([tableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) {
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
}

- (void)loadDataSource {
    // subClasse
}

#pragma mark - Propertys
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataSource;
}

#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化当前页码为1
    self.currentPage = 1;
    self.pageSize = 10;
    self.maxPage = 1;
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
//        self.automaticallyAdjustsScrollViewInsets = NO;
        //sdk7.0_later  tableview分组样式时，表头与导航之间的距离上移20
        if (self.tableView.style == UITableViewStyleGrouped) {
            //self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
        }
    }
    self.tableView.backgroundColor = APP_BACKGROUND_COLOR;//RGBA(242, 242, 243, 1);
//    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //去除多余的空白行
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self.tableView setNeedsLayout];
//    [self.tableView setNeedsUpdateConstraints];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.dataSource = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
}

-(BOOL)checkIsLastPage
{
    if (self.currentPage>=self.maxPage) {
        [self showMessageWithThreeSecondAtCenter:NO_MORE_DATA_MESSAGE];
        [self.tableView footerEndRefreshing];
        return YES;
    }
    return NO;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - location city change alert view
-(void)alertChangeLocationCity:(NSString *)cityName didChangeCityBlock:(DidChangeLocationCityBlock)changeBlock
{
    NSString *cacheCity = [CacheBox getCache:LOCATION_CITY_NAME];
    if (![cacheCity isEqualToString:cityName]) {
        if (!alert) {
            alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:[NSString stringWithFormat:@"系统定位你在\"%@\",是否切换",cityName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"切换", nil];
        }
        
        [alert show];
        self.didChangeLocationCityBlock = changeBlock;
    }
    
}
#pragma mark alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (self.didChangeLocationCityBlock) {
            self.didChangeLocationCityBlock();
        }
    }
}
@end
