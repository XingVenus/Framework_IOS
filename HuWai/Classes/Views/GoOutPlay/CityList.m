//
//  CityList.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CityList.h"
#import "LocationHelper.h"

@interface CityList ()
{
    LocationHelper *_location;
    UIActivityIndicatorView *_activityIndicator;
    UIButton *refreshBtn;
}

@end

@implementation CityList

- (void)viewDidLoad {
    [super viewDidLoad];
    _location = [[LocationHelper alloc] init];
    //判断热门城市列表，存在并相同则不请求，否则请求数据
    
    [self loadAction:HotcityAction params:nil];
    //定位风火轮
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 80, 45);
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //定位当前城市
/*
    __weak UIActivityIndicatorView *weakindicator = _activityIndicator;
    __weak UITableView *weaktableview = self.tableView;
    [weakindicator startAnimating];
    [_location getCurrentGeolocationsCompled:^(NSArray *placemarks, NSError *error) {
        [weakindicator stopAnimating];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell *blockcell = [weaktableview cellForRowAtIndexPath:indexpath];
        //返回位置信息的实现
        dispatch_async(dispatch_get_main_queue(), ^{
            if (placemarks) {
                CLPlacemark *placemark = [placemarks lastObject];
                if (placemark) {
                    NSDictionary *addressDictionary = placemark.addressDictionary;
                    blockcell.textLabel.text = addressDictionary[@"City"];
                }
            }else{
                blockcell.textLabel.text = @"定位失败";
            }
            [self.tableView reloadData];
            // 更新界面  - 在这里很耗内存，待检查原因
//            [weaktableview beginUpdates];
//            [weaktableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
//            [weaktableview endUpdates];
        });
    }];
 */
}
#pragma mark - request delegate
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{

    HotCityModel *hotModel = [[HotCityModel alloc] initWithJsonDict:response.data];
    self.dataSource = [hotModel.data mutableCopy];
    //此处需写入缓存
    
    [self.tableView reloadData];

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

#pragma mark - tableview method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"定位城市";
    }
    return @"热门城市";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identity = @"hotcitycell";
    static NSString *identity2 = @"currentcitycell";
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    if (section == 0 && row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity2];
            [cell addSubview:_activityIndicator];
            refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            refreshBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 80, 45);
            [refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
            [refreshBtn addTarget:self action:@selector(locationCityAction:) forControlEvents:UIControlEventTouchUpInside];
            [refreshBtn setAdjustsImageWhenHighlighted:NO];
            [cell addSubview:refreshBtn];
        }
//        cell.accessoryView = _activityIndicator;
        if (self.gpsCity) {
            cell.textLabel.text = self.gpsCity;
        }else{
            cell.textLabel.text = @"无法定位";
        }
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (row<self.dataSource.count) {
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            }
            HotCityInfo *dic = self.dataSource[row];
            cell.textLabel.text = dic.name;
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSInteger row = [indexPath row];
    if ((indexPath.section == 0) &&(row == 0)) {
        [CacheBox saveCache:LOCATION_CITY_NAME value:self.gpsCity];
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectedHotCity:cityName:)]) {
            [_delegate didSelectedHotCity:nil cityName:self.gpsCity];
        }
        [CacheBox saveCache:LOCATION_CITY_NAME value:self.gpsCity];
    }else{
        HotCityInfo *dic = self.dataSource[row];
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectedHotCity:cityName:)]) {
            [_delegate didSelectedHotCity:dic.cid cityName:dic.name];
        }
        [CacheBox saveCache:LOCATION_CITY_NAME value:dic.name];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)locationCityAction:(UIButton *)sender
{
    [_activityIndicator startAnimating];
    refreshBtn.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        UITableViewCell *locationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
            // 更新界面
//            locationCell.textLabel.text = @"正在定位...";
            __weak UITableViewCell *weakcell = locationCell;
            __weak UIActivityIndicatorView *weakindicator = _activityIndicator;
            [_location getCurrentGeolocationsCompled:^(NSArray *placemarks, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakindicator stopAnimating];
                    refreshBtn.hidden = NO;
                    //返回位置信息的实现
                    if (placemarks) {
                        CLPlacemark *placemark = [placemarks lastObject];
                        if (placemark) {
                            
                            NSDictionary *addressDictionary = placemark.addressDictionary;
                            self.gpsCity = addressDictionary[@"City"];
                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                        }
                    }else{
                        weakcell.textLabel.text = @"定位失败";
                    }
                });
            }];
        
    });
    
    
}
@end
