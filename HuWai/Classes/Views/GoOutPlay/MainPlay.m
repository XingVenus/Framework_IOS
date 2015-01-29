//
//  MainPlay.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MainPlay.h"
#import "ActivityCell.h"
#import "UIButton+ButtonUtility.h"
@interface MainPlay ()
{
    UIView *navigationView;
}

@end

@implementation MainPlay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.height = 74;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //////-------左边定位按钮
    navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.navigationController.navigationBar.height)];
    DLog(@"height is:%f",self.navigationController.navigationBar.height);
    navigationView.hidden = YES;

    [self.navigationController.navigationBar addSubview:navigationView];
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    locationBtn.backgroundColor = [UIColor redColor];
    locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    locationBtn.frame = CGRectMake(15, 7, 100, 30);
    [locationBtn setImage:[UIImage imageNamed:@"place-i"] forState:UIControlStateNormal];
    [locationBtn setTitleColor:RGBA(54, 178, 214, 1) forState:UIControlStateNormal];
    [locationBtn setTitle:@"南京" forState:UIControlStateNormal];
    [locationBtn setTitlePositionWithType:ButtonTitlePostionTypeRight withSpacing:5];
    [locationBtn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];

    [navigationView addSubview:locationBtn];
    /////-----title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_WIDTH/2, 22);
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"出去玩";
    [navigationView addSubview:titleLabel];
    /////------1
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 1001;
    btn1.frame = CGRectMake(0, 40, SCREEN_WIDTH/3, 30);
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn1 setTitle:@"目的地" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    [btn1 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
    [btn1 setContentEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [navigationView addSubview:btn1];
    ////-----2
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = 1002;
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame), 40, SCREEN_WIDTH/3, 30);
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn2 setTitle:@"行程" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    [btn2 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
    [btn2 setContentEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    [navigationView addSubview:btn2];
    /////--------3
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 1003;
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame), 40, SCREEN_WIDTH/3, 30);
    btn3.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn3 setTitle:@"玩法" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    [btn3 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
    [btn3 setContentEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    [navigationView addSubview:btn3];
//    self.navigationController.navigationBar.frame = CGRectMake(0., 20., 320., 180.);
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    navigationView.hidden = NO;
//    self.navigationController.navigationBar.frame = CGRectMake(0., 20., 320., 180.);
    if (![APPInfo shareInit].isLogin) {
        
//        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
//        [self presentViewController:loginNav animated:NO completion:nil];
        //[UIApplication sharedApplication].keyWindow.rootViewController
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    navigationView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark method implement
-(void)selectCity:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"citylist" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/kHeghtRatio;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"activitycell";
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureCellWithItem:nil atIndexPath:indexPath];
    return cell;
}

@end
