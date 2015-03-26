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
#import "LaunchView.h"
#import "SLButton.h"

#define PageSize    20
const static NSInteger kTabHeight = 40;

@interface MainPlay ()<CityListDelegate, SelectListViewDelegate,UIGestureRecognizerDelegate>
{
    NavView *navigationView;
    SelectListView *listPopView;
    CityList *clist;
    
    LocationHelper *_locationHelper;

    UIView *backgroundPopView;
    NSMutableArray *destinationArray;
    NSArray *timeArray;
    NSArray *playArray;
    
    UIButton *locationBtn;
    UIButton *lastSelected;//记录当前选中的按钮
    
    //数据帅选字段
    NSString *_fromCity; //出发城市
    NSString *_destCity; //目的地
    NSString *_time;     //行程时间
    NSString *_play;     //玩法
//    NSInteger _currentPage; //当前页
    
    LaunchView *launchview;
}

@end

@implementation MainPlay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRegistration:) name:UserRegistrationNotification object:nil];
    //引导页面
    NSString *lastBuildversion = [CacheBox getCache:LAUNCH_BUILD_VERSION];
    if (![lastBuildversion isEqualToString:APP_BUILD_VERSION]) {
        launchview = [[LaunchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        launchview.isSkipBtn = YES;
        [launchview fillDataWithImagesArray:@[@"launch1",@"launch2",@"launch3",@"launch4"]];
        [CacheBox saveCache:LAUNCH_BUILD_VERSION value:APP_BUILD_VERSION];
        [[UIApplication sharedApplication].keyWindow addSubview:launchview];
    }
    //---------
    [NSThread sleepForTimeInterval:2.0]; //延迟启动图片显示

    if (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//貌似是可有可无
    }
    //////////////////==============================================
    WEAKSELF;
    timeArray = @[@"全部",@"1日行程",@"2日行程",@"3日行程",@"4-7日行程",@"7日以上"];
    playArray = @[@"全部",@"徒步",@"摄影",@"登山",@"露营",@"越野",@"溯溪",@"攀冰",@"骑行",@"潜水",@"自驾",@"滑雪",@"漂流",@"其他"];
    //下拉、上拉注册
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithCallback:^{
        weakSelf.currentPage = 1;
        [weakSelf loadDataSource];
    } dateKey:@"mainplay"];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithCallback:^{
        if (![weakSelf checkIsLastPage]) {
            weakSelf.currentPage++;
            [weakSelf loadDataSource];
        }
    }];
    
    //获取目的地城市列表
    [self loadAction:DestinationAction params:nil];
    //初始化获取活动列表
    [self loadDataSource];
    //添加 隐藏导航条 通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNavBarWithNoAnimate) name:@"hideNavBarWithNoAnimate" object:nil];
//    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //////-------左边定位按钮
    /*
    navigationView = [[NavView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 94 - [CommonFoundation getStateBarHeight])];
    navigationView.backgroundColor = RGBA(247, 247, 248, 1);
    [self.view addSubview:navigationView];
     */
    navigationView = [[NavView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTabHeight)];
    [self.view addSubview:navigationView];
//    if (CURRENT_SYS_VERSION>=7.0) {
//        navigationView.top = 64;
//    }
//    CGFloat navViewHeight = CGRectGetHeight(navigationView.bounds);
    //定位按钮
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    locationBtn.frame = CGRectMake(0, 0, 100, 30);//CGRectMake(15, navViewHeight - 67, 100, 30);//CGRectMake(15, 7, 100, 30)
    [locationBtn setImage:[UIImage imageNamed:@"place-i"] forState:UIControlStateNormal];
    [locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    locationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [locationBtn setTitle:[CacheBox getCache:LOCATION_CITY_NAME] forState:UIControlStateNormal];
    [locationBtn setTitlePositionWithType:ButtonTitlePostionTypeRight withSpacing:4];
    [locationBtn addTarget:self action:@selector(selectDestCity:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:locationBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
//    [navigationView addSubview:locationBtn];
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 30, 30);//CGRectMake(SCREEN_WIDTH - 45, navViewHeight - 67, 30, 30);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchActivity:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = searchItem;
//    [navigationView addSubview:searchBtn];

    /////-----title
    /*
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 00, 100, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_WIDTH/2, 0);
    titleLabel.top = navViewHeight - 65;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"出去玩";
    [navigationView addSubview:titleLabel];
     */
    /////------1
    SLButton *btn1 = [SLButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 1001;
    [btn1 addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn1 setTitle:@"目的地" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    UIImage *downImg = [UIImage imageNamed:@"down"];
    [btn1 setImage:downImg forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    btn1.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, kTabHeight);//CGRectMake(0, navViewHeight - 35, SCREEN_WIDTH/3, 30);
//    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(0, btn1.titleLabel.bounds.size.width, 0, -btn1.titleLabel.bounds.size.width)];
//    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -downImg.size.width, 0, downImg.size.width)];
//    [btn1 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
//    [btn1 setContentEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [navigationView addSubview:btn1];
    ////-----2
    SLButton *btn2 = [SLButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = 1002;
    [btn2 addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn2 setTitle:@"行程" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    btn2.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, kTabHeight);//CGRectMake(CGRectGetMaxX(btn1.frame), navViewHeight - 35, SCREEN_WIDTH/3, 30);
//    [btn2 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
//    [btn2 setContentEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
    [navigationView addSubview:btn2];
    /////--------3
    SLButton *btn3 = [SLButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 1003;
    [btn3 addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    btn3.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn3 setTitle:@"玩法" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    btn3.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, kTabHeight);//CGRectMake(CGRectGetMaxX(btn2.frame), navViewHeight - 35, SCREEN_WIDTH/3, 30);
//    [btn3 setTitlePositionWithType:ButtonTitlePostionTypeLeft withSpacing:5];
//    [btn3 setContentEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    [navigationView addSubview:btn3];
    //定位
    _locationHelper = [[LocationHelper alloc] init];
    [_locationHelper getCurrentGeolocationsCompled:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count>0) {
            CLPlacemark *placemark = [placemarks lastObject];
            if (placemark) {
                NSDictionary *addressDictionary = placemark.addressDictionary;
                NSString  *City = addressDictionary[@"City"];
                [APPInfo shareInit].GPSCity = addressDictionary[@"City"];
                //如果有原定位城市需要提示用户切换，否则直接设置为当前定位城市
                if ([CacheBox getCache:LOCATION_CITY_NAME]) {
                    [self alertChangeLocationCity:City didChangeCityBlock:^(BOOL exchange) {
                        if (exchange) {
                            [weakSelf locateCurrentCity:City];
                        }
                    }];
                }else{
                    [weakSelf locateCurrentCity:City];
                }
            }
        }else{
            //显示上次缓存的城市
            [locationBtn setTitle:[CacheBox getCache:LOCATION_CITY_NAME] forState:UIControlStateNormal];
        }
    }];

//    self.navigationController.navigationBar.frame = CGRectMake(0., 20., 320., 180.);
    // Do any additional setup after loading the view.
    //-----弹出层列表展示
    if (!backgroundPopView) {
//        backgroundPopView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 - [CommonFoundation getStateBarHeight] + 30, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 30)];
        backgroundPopView = [[UIView alloc] initWithFrame:CGRectMake(0,kTabHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-kTabHeight-49)];
        backgroundPopView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:.6];
        
        UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopView:)];
        hideTap.numberOfTapsRequired = 1;
        hideTap.delegate = self;
        [backgroundPopView addGestureRecognizer:hideTap];
//        listPopView = [[SelectListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(backgroundPopView.frame) - 100)];
        listPopView = [[SelectListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        //listPopView.top -= listPopView.height;
        listPopView.delegate = self;
        [backgroundPopView addSubview:listPopView];
        [self.view insertSubview:backgroundPopView belowSubview:navigationView];
//        [self.view addSubview:backgroundPopView];
        backgroundPopView.hidden = YES;
    }
    
}
/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setFullScreen:YES];
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
*/
-(void)dealloc
{
    listPopView.delegate = nil;
    clist.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UserRegistrationNotification object:nil];
}
#pragma mark 加载数据
-(void)loadDataSource
{
    [self loadAction:ActivityAction params:@"from",_fromCity?_fromCity:[CacheBox getCache:LOCATION_CITY_NAME],@"city",_destCity,@"time",_time,@"play",_play,@"page",@(self.currentPage),@"pagesize",@(self.pageSize),nil];
}
#pragma mark - data response block
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{

    if (tag == ActivityAction) {
        ActivityModel *model = [[ActivityModel alloc] initWithJsonDict:response.data];
        //显示数据
        if (self.tableView.headerRefreshing) {
            self.currentPage = 1;
            self.dataSource = [model.data mutableCopy];
        }else if (self.tableView.footerRefreshing && model.data){
            [self.dataSource addObjectsFromArray:model.data];
        }else{
            self.dataSource = [NSMutableArray arrayWithArray:model.data];
        }
        self.maxPage = model.pager.pagemax;
        [self.tableView reloadData];
    }else if (tag == DestinationAction){
        DestinationCityModel *desModel = [[DestinationCityModel alloc] initWithJsonDict:response.data];
        DestCityInfo *destDic = [[DestCityInfo alloc] initWithJsonDict:@{@"cid":@"0",@"name":@"全部"}];
        destinationArray = [desModel.data mutableCopy];
        [destinationArray insertObject:destDic atIndex:0];
    }else if (tag == AppRegistrationAction){
        self.hideShowMessage = YES;
    }

    [self endHeaderOrFooterRefreshing];
    
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
#pragma mark 定位当前城市
- (void)locateCurrentCity:(NSString *)city
{
    _fromCity = city;
    [CacheBox saveCache:LOCATION_CITY_NAME value:city];
    [locationBtn setTitle:city forState:UIControlStateNormal];
    self.currentPage = 1;
    [self loadDataSource];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass(touch.view.class) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
    
}

-(void)hidePopView:(UITapGestureRecognizer*)recognizer
{

    [UIView animateWithDuration:0.3 animations:^{
        listPopView.top = -listPopView.height;
        lastSelected.selected = NO;
    } completion:^(BOOL finished) {
        backgroundPopView.hidden = YES;
        lastSelected = nil;
    }];
}

-(void)userRegistration:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    NSString *clientId = dic[@"clientId"];
    NSString *devicetoken = dic[@"devicetoken"];
    [self postAction:AppRegistrationAction params:@"app",@"ios",@"cid",clientId,@"devicetoken",devicetoken,nil];
}

/*
- (void)setFullScreen:(BOOL)fullScreen
{
    // 状态条
    //   [UIApplication sharedApplication].statusBarHidden = fullScreen;
    // 导航条
    
    [self.navigationController setNavigationBarHidden:fullScreen animated:YES];
    //    [self.navigationController setNavigationBarHidden:fullScreen];
    // tabBar的隐藏通过在初始化方法中设置hidesBottomBarWhenPushed属性来实现
}
*/
//-(void)hideNavBarWithNoAnimate
//{
//    [self.navigationController setNavigationBarHidden:YES];
//}

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
    
    CGFloat popViewHeight = listPopView.listData.count*45;
    if (popViewHeight>315) {
        popViewHeight = 315;
    }
    listPopView.height = popViewHeight;
    listPopView.tableView.height = popViewHeight;
    
    if (sender.selected) {
        //隐藏
        [UIView animateWithDuration:0.3 animations:^{
            listPopView.top = -listPopView.height;
        } completion:^(BOOL finished) {
            backgroundPopView.hidden = YES;
            lastSelected = nil;
        }];
    }else{
        //显示
        backgroundPopView.hidden = NO;
        listPopView.top =-listPopView.height;
        
        if (lastSelected && ![lastSelected isEqual:sender]) {
            listPopView.top =-listPopView.height;
            lastSelected.selected = NO;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            listPopView.top = 0;
        } completion:^(BOOL finished) {
            lastSelected = sender;
        }];
    }
    [sender setSelected:!sender.selected];
}

#pragma mark - hotcity delegate
#pragma mark 定位城市更改
-(void)didSelectedHotCity:(NSString *)hotcityID cityName:(NSString *)hotcityName
{
    if (hotcityID) {
        _fromCity = hotcityID;
    }else{
        _fromCity = hotcityName;
    }
    [locationBtn setTitle:hotcityName forState:UIControlStateNormal];
    [locationBtn setTitlePositionWithType:ButtonTitlePostionTypeRight withSpacing:4];
//    [self.tableView headerBeginRefreshing];
    self.currentPage = 1;
    [self loadDataSource];
}

#pragma mark SelectListView delegate
-(void)selectedValueForListType:(ListType)listType Value:(NSString *)value
{
    //隐藏
    NSString *showValue = @"";
    if (listType == ListTypeTime) {
        if ([value isEqualToString:@"全部"]) {
            _time = @"";
            showValue = @"行程";
        }else{
            _time = value;
            showValue = value;
        }
    }else if (listType == ListTypePlay){
        if ([value isEqualToString:@"全部"]) {
            _play = @"";
            showValue = @"玩法";
        }else{
            _play = value;
            showValue = value;
        }
    }
    [self refreshBtnToSelectedValue:showValue];
}
#pragma mark 目的城市选择
-(void)selectedDestCity:(DestCityInfo *)destCity
{
    NSString *name;
    if ([destCity.cid intValue] == 0) {
        _destCity = @"";
        name = @"目的地";
    }else{
        _destCity = destCity.cid;
        name = destCity.name;
    }

//    if (destCity.name.length>5) {
//        name = [destCity.name substringWithRange:NSMakeRange(0, 5)];
//    }

    [self refreshBtnToSelectedValue:name];
}

-(void)refreshBtnToSelectedValue:(NSString *)value
{
    [lastSelected setTitle:value forState:UIControlStateNormal];
    [lastSelected setSelected:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        listPopView.top -= listPopView.height;
        backgroundPopView.hidden = YES;
    } completion:^(BOOL finished) {
        lastSelected = nil;
    }];
    //数据过滤
    self.currentPage = 1;
    [self loadDataSource];
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
        clist = segue.destinationViewController;
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
    return SCREEN_WIDTH/kHeghtRatio + 10;
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
