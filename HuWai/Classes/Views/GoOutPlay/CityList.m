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
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //定位当前城市
    
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
}
#pragma mark - request delegate
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (response.code == 20000) {
        HotCityModel *hotModel = [[HotCityModel alloc] initWithJsonDict:response.data];
        self.dataSource = [hotModel.data mutableCopy];
        //此处需写入缓存
        
        [self.tableView reloadData];
    }
    [self showMessageWithThreeSecondAtCenter:response.message];
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
        }
        cell.accessoryView = _activityIndicator;
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
        [_activityIndicator startAnimating];
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        selectedCell.textLabel.text = @"正在定位...";
        __weak UITableViewCell *weakcell = selectedCell;
        __weak UIActivityIndicatorView *weakindicator = _activityIndicator;
        [_location getCurrentGeolocationsCompled:^(NSArray *placemarks, NSError *error) {
            [weakindicator stopAnimating];
            //返回位置信息的实现
            if (placemarks) {
                
                CLPlacemark *placemark = [placemarks lastObject];
                if (placemark) {
                    
                    NSDictionary *addressDictionary = placemark.addressDictionary;
                    weakcell.textLabel.text = addressDictionary[@"City"];
                }
            }else{
                weakcell.textLabel.text = @"定位失败";
            }
        }];
    }else{
        HotCityInfo *dic = self.dataSource[row];
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectedHotCity:)]) {
            [_delegate didSelectedHotCity:dic];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
