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
#import "ActivityDetail.h"
#import "SelectListView.h"
#import "NavView.h"

#import "CityList.h"
#import "MJRefresh.h"
#import "ActivityModel.h"
#import "DestinationCityModel.h"
#import "LocationHelper.h"

#define PageSize    20

@interface MainPlay ()<CityListDelegate, SelectListViewDelegate>
{
    NavView *navigationView;
    SelectListView *listPopView;
    
    LocationHelper *_locationHelper;
    UIView *backgroundPopView;
    NSArray *destinationArray;
    NSArray *timeArray;
    NSArray *playArray;
    
    UIButton *locationBtn;
    UIButton *lastSelected;//记录当前选中的按钮
    
    //数据帅选字段
    NSString *_fromCity; //出发城市
    NSString *_destCity; //目的地
    NSString *_time;     //行程时间
    NSString *_play;     //玩法
    NSInteger _currentPage; //当前页
}

@end

@implementation MainPlay

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread sleepForTimeInterval:3.0];

    WEAKSELF;
    timeArray = @[@"1日行程",@"2日行程",@"3日行程",@"4-7日行程",@"7日以上"];
    playArray = @[@"徒步",@"摄影",@"登山",@"露营",@"越野",@"溯溪",@"攀冰",@"骑行",@"潜水",@"自驾",@"滑雪",@"漂流",@"其他"];
    _currentPage = 1;
    //下拉、上拉注册
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"mainplay"];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithCallback:^{
        [weakSelf headerRereshing];
    }];

    //获取目的地城市列表
    [self loadAction:DestinationAction params:nil];
    //添加 隐藏导航条 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNavBarWithNoAnimate) name:@"hideNavBarWithNoAnimate" object:nil];
//    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //////-------左边定位按钮
    navigationView = [[NavView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 94 - [CommonFoundation getStateBarHeight])];
    navigationView.backgroundColor = RGBA(247, 247, 248, 1);
    [self.view addSubview:navigationView];
    CGFloat navViewHeight = CGRectGetHeight(navigationView.bounds);
    //定位按钮
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    locationBtn.frame = CGRectMake(15, navViewHeight - 67, 100, 30);//CGRectMake(15, 7, 100, 30)
    [locationBtn setImage:[UIImage imageNamed:@"place-i"] forState:UIControlStateNormal];
    [locationBtn setTitleColor:RGBA(54, 178, 214, 1) forState:UIControlStateNormal];
    locationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];

    [locationBtn setTitlePositionWithType:ButtonTitlePostionTypeRight withSpacing:4];
    [locationBtn addTarget:self action:@selector(selectDestCity:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:locationBtn];
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(SCREEN_WIDTH - 45, navViewHeight - 67, 30, 30);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchActivity:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchBtn];

    /////-----title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 00, 100, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_WIDTH/2, 0);
    titleLabel.top = navViewHeight - 65;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"出去玩";
    [navigationView addSubview:titleLabel];
    /////------1
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 1001;
    [btn1 addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame = CGRectMake(0, navViewHeight - 35, SCREEN_WIDTH/3, 30);
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
    [btn2 addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame), navViewHeight - 35, SCREEN_WIDTH/3, 30);
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn2 setTitle:@"行程" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    [btn2 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
    [btn2 setContentEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
    [navigationView addSubview:btn2];
    /////--------3
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 1003;
    [btn3 addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame), navViewHeight - 35, SCREEN_WIDTH/3, 30);

    btn3.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn3 setTitle:@"玩法" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    [btn3 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
    [btn3 setContentEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    [navigationView addSubview:btn3];
    [btn3 setContentEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    //定位
    _locationHelper = [[LocationHelper alloc] init];
    [_locationHelper getCurrentGeolocationsCompled:^(NSArray *placemarks, NSError *error) {
        if (placemarks) {
            CLPlacemark *placemark = [placemarks lastObject];
            if (placemark) {
                NSDictionary *addressDictionary = placemark.addressDictionary;
                [locationBtn setTitle:addressDictionary[@"City"] forState:UIControlStateNormal];
                _fromCity = addressDictionary[@"City"];
                ///待定解决
                [self.tableView headerBeginRefreshing];
            }
        }else{
            //显示上次缓存的城市
            [locationBtn setTitle:@"暂无" forState:UIControlStateNormal];
        }
    }];

//    self.navigationController.navigationBar.frame = CGRectMake(0., 20., 320., 180.);
    // Do any additional setup after loading the view.
    //-----弹出层列表展示
    if (!backgroundPopView) {
        backgroundPopView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 - [CommonFoundation getStateBarHeight] + 30, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 30)];
        backgroundPopView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:.6];
        listPopView = [[SelectListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(backgroundPopView.frame) - 100)];
        listPopView.top -= listPopView.height;
        listPopView.delegate = self;
        [backgroundPopView addSubview:listPopView];
        [self.view insertSubview:backgroundPopView belowSubview:navigationView];

        backgroundPopView.hidden = YES;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setFullScreen:YES];
//    if (![APPInfo shareInit].isLogin) {
    
//        UINavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
//        [self presentViewController:loginNav animated:NO completion:nil];
        //[UIApplication sharedApplication].keyWindow.rootViewController
//    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setFullScreen:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 刷新数据
-(void)headerRereshing
{
    [self loadActionWithHUD:ActivityAction params:@"from",_fromCity,@"city",_destCity,@"time",_time,@"play",_play,@"page",[NSNumber numberWithInteger:_currentPage],@"pagesize",[NSNumber numberWithInteger:PageSize],nil];
}
#pragma mark - data response block
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{

    if (tag == ActivityAction) {
        ActivityModel *model = [[ActivityModel alloc] initWithJsonDict:response.data];
        //显示数据
        if (self.tableView.headerRefreshing) {
            self.dataSource = [model.data mutableCopy];
        }else if (self.tableView.footerRefreshing){
            [self.dataSource addObjectsFromArray:model.data];
        }
        
        [self.tableView reloadData];
    }else if (tag == DestinationAction){
        DestinationCityModel *desModel = [[DestinationCityModel alloc] initWithJsonDict:response.data];
        destinationArray = [desModel.data copy];
    }

    
    if (self.tableView.headerRefreshing) {
        [self.tableView headerEndRefreshing];
    }else{
        [self.tableView footerEndRefreshing];
    }
}
-(void)onRequestFailed:(HttpRequestAction)tag response:(Response *)response
{
    if (self.tableView.headerRefreshing) {
        [self.tableView headerEndRefreshing];
    }else{
        [self.tableView footerEndRefreshing];
    }
    
}

#pragma mark - method implement

- (void)setFullScreen:(BOOL)fullScreen
{
    // 状态条
    //   [UIApplication sharedApplication].statusBarHidden = fullScreen;
    // 导航条
    
    [self.navigationController setNavigationBarHidden:fullScreen animated:YES];
    //    [self.navigationController setNavigationBarHidden:fullScreen];
    // tabBar的隐藏通过在初始化方法中设置hidesBottomBarWhenPushed属性来实现
}

-(void)hideNavBarWithNoAnimate
{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)selectDestCity:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"citylist" sender:self];
}

-(void)searchActivity:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"search" sender:self];
}

-(void)showSelectView:(UIButton *)sender
{
    NSInteger btnTag = sender.tag;
    
    if (btnTag == 1001) {
        listPopView.listType = ListTypeDestination;
        listPopView.listData = destinationArray;
    }else if (btnTag == 1002){
        listPopView.listType = ListTypeTime;
        listPopView.listData = timeArray;
    }else if (btnTag == 1003){
        listPopView.listType = ListTypePlay;
        listPopView.listData = playArray;
    }
    if (sender.selected) {
        //隐藏
        lastSelected = nil;
        [UIView animateWithDuration:0.3 animations:^{
            listPopView.top -= listPopView.height;
        } completion:^(BOOL finished) {
            backgroundPopView.hidden = YES;
        }];
    }else{
        //显示
        if (lastSelected && ![lastSelected isEqual:sender]) {
            listPopView.top -= listPopView.height;
            backgroundPopView.hidden = YES;
            lastSelected.selected = NO;
        }
        
        lastSelected = sender;
        backgroundPopView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            listPopView.top = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
    [sender setSelected:!sender.selected];
}

#pragma mark - hotcity delegate
-(void)didSelectedHotCity:(HotCityInfo *)hotcity
{
    _fromCity = hotcity.cid;
    [locationBtn setTitle:hotcity.name forState:UIControlStateNormal];
    [locationBtn setTitlePositionWithType:ButtonTitlePostionTypeRight withSpacing:4];
    [self.tableView headerBeginRefreshing];
}

#pragma mark SelectListView delegate
-(void)selectedValueForListType:(ListType)listType Value:(NSString *)value
{
    //隐藏
    if (listType == ListTypeTime) {
        _time = value;
    }else if (listType == ListTypePlay){
        _play = value;
    }
    [self refreshBtnToSelectedValue:value];
}
#pragma mark 目的城市选择
-(void)selectedDestCity:(DestCityInfo *)destCity
{
    _destCity = destCity.cid;
    NSString *name = destCity.name;
    if (destCity.name.length>5) {
        name = [destCity.name substringWithRange:NSMakeRange(0, 5)];
    }

    [self refreshBtnToSelectedValue:name];
}

-(void)refreshBtnToSelectedValue:(NSString *)value
{
    [lastSelected setTitle:value forState:UIControlStateNormal];
    [lastSelected setSelected:NO];
    [lastSelected setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
    lastSelected = nil;
    [UIView animateWithDuration:0.3 animations:^{
        listPopView.top -= listPopView.height;
    } completion:^(BOOL finished) {
        backgroundPopView.hidden = YES;
    }];
    //数据过滤
    [self.tableView headerBeginRefreshing];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"activitydetail"]) {
        ActivityDetail *activityController = segue.destinationViewController;
        ActivityInfo *infoModel = self.dataSource[selectedRowIndex.row];
        activityController.activityId = infoModel.aid;
        activityController.detailTitle = @"活动详情";
    }else if([segue.identifier isEqualToString:@"citylist"]){
        CityList *clist = segue.destinationViewController;
        clist.delegate = self;
    }
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger row = [indexPath row];
    if (row < self.dataSource.count) {
        ActivityInfo *infoModel = self.dataSource[row];
        [cell configureCellWithItem:infoModel atIndexPath:indexPath];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"activitydetail" sender:self];
}

@end
