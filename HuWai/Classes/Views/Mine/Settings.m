//
//  Settings.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-26.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Settings.h"

@interface Settings ()
{
    NSArray *_settingList;
    UIButton *_loginOrOutBtn;
    UISwitch *switchBtn;
}

@end

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    if (CURRENT_SYS_VERSION>=7.0) {
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    _settingList = @[@[@"开启消息提醒",@"清除图片缓存"],@[@"意见反馈",@"用户协议"],@[@"关于我们",@"鼓励我们"]];
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    _loginOrOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginOrOutBtn.frame = CGRectMake(20, 10, SCREEN_WIDTH - 20*2, 40);
    [_loginOrOutBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginOrOutBtn setTitle:@"退 出" forState:UIControlStateSelected];
    [_loginOrOutBtn addTarget:self action:@selector(loginOrOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginOrOutBtn setBackgroundImage:[UIImage imageNamed:@"quit-mutual"] forState:UIControlStateNormal];
    [_loginOrOutBtn setBackgroundImage:[UIImage imageNamed:@"quit"] forState:UIControlStateHighlighted];
    [footerview addSubview:_loginOrOutBtn];
    
    self.tableView.tableFooterView = footerview;
    

    [[[SDWebImageManager sharedManager] imageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        DLog(@"total:%lu,Size:%lu",(unsigned long)fileCount,(unsigned long)totalSize);
    }];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *token = [CacheBox getCache:CACHE_TOKEN];
    if (token) {
        [_loginOrOutBtn setSelected:YES];
    }
}

-(void)loginOrOutAction:(UIButton *)sender
{
    if (_loginOrOutBtn.selected) {
        [CacheBox removeObjectValue:CACHE_TOKEN];
    }
    BaseNavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavBoard"];
    [self presentViewController:loginNav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_settingList[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"settingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if (section == 0) {
        if (row == 0) {
            if (!switchBtn) {
                switchBtn = [[UISwitch alloc] init];
                switchBtn.center = CGPointMake(SCREEN_WIDTH - 40, cell.centerY);
                [switchBtn addTarget:self action:@selector(oneSwitchValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加事件监听器的方法
                if ([[CacheBox getCache:OPEN_MESSAGE_ALERT] isEqualToString:@"ON"]) {
                    [switchBtn setOn:YES];
                }else{
                    [switchBtn setOn:NO];
                }
                [cell addSubview:switchBtn];
            }
        }else if (row == 1){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",(float)([[SDImageCache sharedImageCache] getSize]/1024.0/1024.0)];
        }
    }
    cell.textLabel.text = _settingList[section][row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case 0:
        {
            if (row == 1) {
                //清除图片缓存
                [[[SDWebImageManager sharedManager] imageCache] clearDisk];
                [[[SDWebImageManager sharedManager] imageCache] clearMemory];
                [self showMessageWithThreeSecondAtCenter:@"清理完成"];
                [self.tableView reloadData];
                /*不过这里要特别注意一下，在IOS7中你会发现使用这两个方法缓存总清除不干净，即使断网下还是会有数据。这是因为在IOS7中，缓存机制做了修改，使用上述两个方法只清除了SDWebImage的缓存，没有清除系统的缓存，所以我们可以在清除缓存的代理中额外添加以下：
                 */
                //[[NSURLCache sharedURLCache] removeAllCachedResponses];
            }
        }
            break;
        case 1:
        {
            if (row == 0) {
                //意见反馈
                [self performSegueWithIdentifier:@"feedback" sender:self];
            }else if (row == 1){
                //用户协议
                [self performSegueWithIdentifier:@"agreement" sender:self];
            }
        }
            break;
        case 2:
        {
            if (row == 0) {
                //关于我们
                [self performSegueWithIdentifier:@"aboutus" sender:self];
            }else if (row == 1){
                //鼓励我们
            }
        }
            break;
        default:
            break;
    }
}

-(void)oneSwitchValueChanged:(UISwitch *) sender
{
    NSLog(@"%@", sender.isOn ? @"ON" : @"OFF");
    [CacheBox saveCache:OPEN_MESSAGE_ALERT value:sender.isOn?@"ON":@"OFF"];
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
