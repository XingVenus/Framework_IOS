//
//  Mine.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-22.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Mine.h"
#import "PAAImageView.h"
#import "Login.h"
#import "Register.h"

#import "JSBadgeView.h"

@interface Mine ()
{
    NSMutableArray *_arrayCells;
    JSBadgeView *subscribeBadgeView;
    JSBadgeView *scoreBadgeView;
    JSBadgeView *messageBadgeView;
}

@end

@implementation Mine

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayCells = [NSMutableArray arrayWithCapacity:1];
    NSDictionary *listDic = @{@"icon":@"form",@"title":@"我的订单"};
    [_arrayCells addObject:@[listDic]];
    NSDictionary *dic1 = @{@"icon":@"subscribe",@"title":@"我的订阅"};
    NSDictionary *dic2 = @{@"icon":@"grade",@"title":@"领队打分"};
    NSDictionary *dic3 = @{@"icon":@"collect",@"title":@"收藏的活动"};
    NSDictionary *dic4 = @{@"icon":@"contacts",@"title":@"常用出行人"};
    [_arrayCells addObject:@[dic1,dic2,dic3,dic4]];
    NSDictionary *dic5 = @{@"icon":@"mynews",@"title":@"消息"};
    NSDictionary *dic6 = @{@"icon":@"setup",@"title":@"系统设置"};
    [_arrayCells addObject:@[dic5,dic6]];
    
    
//    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
//    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initHeaderView];
    [MobClick beginLogPageView:self.title];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initHeaderView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 86)];//106
    
    backView.backgroundColor = APP_BACKGROUND_COLOR;
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head-bg"]];
    imageview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 86);
    [backView addSubview:imageview];
    if ([CacheBox getCache:CACHE_TOKEN]) {
        //添加触摸手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToProfile:)];
        singleTap.numberOfTapsRequired = 1;
        [backView addGestureRecognizer:singleTap];
        //显示头像以及名称
        PAAImageView *avatar = [[PAAImageView alloc] initWithFrame:CGRectMake(20, 0, 55, 55) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor whiteColor]];
        avatar.centerY = backView.height/2;
        avatar.placeHolderImage = [UIImage imageNamed:@"avatar"];
        [avatar setImageURL:[NSURL URLWithString:[APPInfo shareInit].avatar]];
        [backView addSubview:avatar];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 120, 30)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.centerY = backView.height/2;
        nameLabel.text = [CacheBox getCache:USERNAME_CACHE];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-r-g"]];
        arrowImage.frame = CGRectMake(SCREEN_WIDTH - 30, 0, 12, 20);
        arrowImage.centerY = backView.height/2;
        [backView addSubview:arrowImage];
        [backView addSubview:nameLabel];
    }else{
        //提示语以及登录按钮
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 24)];
        textLabel.centerX = backView.centerX;
        textLabel.text = @"您还没有登录";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:16.0];
        textLabel.textColor = [UIColor whiteColor];
        [backView addSubview:textLabel];
        UIButton *lgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lgBtn.tag = 1;
        [lgBtn setTitle:@"登录" forState:UIControlStateNormal];
        lgBtn.frame = CGRectMake(SCREEN_WIDTH/2-80, 40, 60, 28);
        lgBtn.layer.cornerRadius = 3.0;
        lgBtn.layer.borderWidth = 1.0;
        lgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        lgBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [lgBtn addTarget:self action:@selector(loginOrRegister:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:lgBtn];
        
        UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        regBtn.tag = 2;
        [regBtn setTitle:@"注册" forState:UIControlStateNormal];
        regBtn.frame = CGRectMake(SCREEN_WIDTH/2+80 - 60, 40, 60, 28);
        regBtn.layer.cornerRadius = 3.0;
        regBtn.layer.borderWidth = 1.0;
        regBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        regBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [regBtn addTarget:self action:@selector(loginOrRegister:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:regBtn];
    }
    self.tableView.tableHeaderView = backView;
}

-(void)tapToProfile:(UITapGestureRecognizer*)recognizer
{
    [self performSegueWithIdentifier:@"profile" sender:self];
}

- (void)loginOrRegister:(UIButton *)sender
{
    BaseNavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavBoard"];
    if (sender.tag == 1) {
        [self presentViewController:loginNav animated:YES completion:nil];
    }else if (sender.tag == 2){
        [self presentViewController:loginNav animated:YES completion:^{
            [loginNav.topViewController performSegueWithIdentifier:@"userRegister" sender:loginNav];
        }];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return _arrayCells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayCells[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier1 = @"avatarcell";
    static NSString *CellIdentifier2 = @"minecells";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *array = _arrayCells[section];
    NSDictionary *dic = array[row];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
    cell2.imageView.image = [UIImage imageNamed:dic[@"icon"]];
    cell2.textLabel.text = dic[@"title"];
    if (section == 1) {
        if (row == 0 && [CacheBox getCache:SUBSCRIBE_PUSH]) {
            subscribeBadgeView = [[JSBadgeView alloc] initWithParentView:cell2.contentView alignment:JSBadgeViewAlignmentCenterLeft];
            subscribeBadgeView.badgeText = @"new";
            subscribeBadgeView.badgeTextFont = [UIFont systemFontOfSize:12.0];
            subscribeBadgeView.badgePositionAdjustment = CGPointMake(150, 0);
        }else if (row == 1 && [CacheBox getCache:SCORE_PUSH]) {
            scoreBadgeView = [[JSBadgeView alloc] initWithParentView:cell2.contentView alignment:JSBadgeViewAlignmentCenterLeft];
            scoreBadgeView.badgeText = @"new";
            scoreBadgeView.badgeTextFont = [UIFont systemFontOfSize:12.0];
            scoreBadgeView.badgePositionAdjustment = CGPointMake(150, 0);
        }
    }else if (section == 2){
        if (row == 0 && [CacheBox getCache:MESSAGE_PUSH]) {
            messageBadgeView = [[JSBadgeView alloc] initWithParentView:cell2.contentView alignment:JSBadgeViewAlignmentCenterLeft];
            messageBadgeView.badgeText = @"new";
            messageBadgeView.badgeTextFont = [UIFont systemFontOfSize:12.0];
            messageBadgeView.badgePositionAdjustment = CGPointMake(120, 0);
        }
    }
    
    return cell2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    switch (section) {
        case 0:
            if (row == 0) {
                [MobClick event:@"w_dd"];
                [self performSegueWithIdentifier:@"myorder" sender:self];
                break;
            }
            break;
        case 1:
            if (row == 0) {
                [MobClick event:@"w_dy"];
                [self performSegueWithIdentifier:@"subscribe" sender:self];
                [CacheBox removeObjectValue:SUBSCRIBE_PUSH];
                [subscribeBadgeView removeFromSuperview];
            }else if(row == 1){
                [MobClick event:@"w_df"];
                [self performSegueWithIdentifier:@"leaderscore" sender:self];
                [CacheBox removeObjectValue:SCORE_PUSH];
                [scoreBadgeView removeFromSuperview];
            }else if (row == 2){
                [MobClick event:@"w_sc"];
                [self performSegueWithIdentifier:@"collected" sender:self];
            }else if (row == 3){
                [MobClick event:@"w_cxr"];
                [self performSegueWithIdentifier:@"commonperson" sender:self];
            }
            break;
        case 2:
            if (row == 0) {
                [MobClick event:@"w_xx"];
                [self performSegueWithIdentifier:@"messagegroup" sender:self];
                [CacheBox removeObjectValue:MESSAGE_PUSH];
                [messageBadgeView removeFromSuperview];
            }else if (row == 1){
                [MobClick event:@"w_sz"];
                [self performSegueWithIdentifier:@"settings" sender:self];
                break;
            }
            break;
            
        default:
            break;
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

@end
