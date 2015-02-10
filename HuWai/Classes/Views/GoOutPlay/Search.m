//
//  Search.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-9.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Search.h"
@interface Search ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)backToMain:(id)sender;

@end

@implementation Search

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchField.width = SCREEN_WIDTH - 60;
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
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 50, 30);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search-mutual"] forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search-lighted"] forState:UIControlStateHighlighted];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = searchItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)searchAction
{
    DLog(@"%@",@"searchAction");
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

- (IBAction)backToMain:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
