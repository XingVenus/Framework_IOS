//
//  Search.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-9.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Search.h"
#import "ActivityModel.h"
#import "SearchResultList.h"
#import "BaseNavigationController.h"

@interface Search ()<UITextFieldDelegate>
{
    ActivityModel *dataModel;
}
@property (strong, nonatomic) UITextField *searchField;

@end

@implementation Search

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70, 30)];
    self.navigationItem.titleView = self.searchField;
    self.searchField.background = [UIImage imageNamed:@"search-bg"];
    self.searchField.returnKeyType = UIReturnKeySearch;
    self.searchField.enablesReturnKeyAutomatically = YES;
    _searchField.delegate = self;
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search-icon"]];
    searchImage.contentMode = UIViewContentModeScaleAspectFit;
    searchImage.frame = CGRectMake(0, 0, 34, 16);
    _searchField.leftView = searchImage;
//    [_searchField setValue:[NSNumber numberWithInt:-15] forKey:@"paddingLeft"];
    _searchField.tintColor = [UIColor grayColor];
    _searchField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    // Do any additional setup after loading the view.
    
    //搜索按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 40 , 40);

    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [cancelButton addTarget:self action:@selector(dismissNavigationView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil
                                   action:nil];
    fixedSpace.width = -10;
    self.navigationItem.rightBarButtonItems = @[fixedSpace,cancelItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SearchResultList *resultController = (SearchResultList *)segue.destinationViewController;
    resultController.title = [CommonFoundation trimString:self.searchField.text];
    resultController.dataList = dataModel.data;
}

-(void)searchAction
{
    DLog(@"%@",@"searchAction");
    NSString *keyword = [CommonFoundation trimString:self.searchField.text];
    if (![CommonFoundation isEmptyString:keyword]) {
        NSString *fromcity = [CacheBox getCache:LOCATION_CITY_NAME];
        [self loadActionWithHUD:ActivityAction params:@"from",fromcity,@"keyword",keyword,nil];
    }else{
        [self showMessageWithThreeSecondAtCenter:@"请输入搜索内容"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchField endEditing:YES];
    [self searchAction];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == ActivityAction) {
        dataModel = [[ActivityModel alloc] initWithJsonDict:response.data];
        if (dataModel.data.count>0) {
            [self performSegueWithIdentifier:@"searchresultlist" sender:self];
        }else{
            [self showMessageWithThreeSecondAtCenter:@"亲，没有找到相关出行内容"];
        }
        
//        if (self.tableView.headerRefreshing) {
//            self.currentPage = 1;
//            self.dataSource = [model.data mutableCopy];
//        }else if (self.tableView.footerRefreshing && model.data){
//            [self.dataSource addObjectsFromArray:model.data];
//        }else{
//            self.dataSource = [NSMutableArray arrayWithArray:model.data];
//        }
    }
}
@end
