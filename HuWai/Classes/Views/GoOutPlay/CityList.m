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
    [self loadAction:HotcityAction params:nil];
    // Do any additional setup after loading the view.
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (response.code == 20000) {
//        NSLog(@"%@",response.data);
        [response.data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSDictionary *dic = @{@"cid":key,@"cityname":obj};
            [self.dataSource addObject:dic];
        }];
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
    if (section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity2];
        }
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = _activityIndicator;
        __weak UITableViewCell *weakcell = cell;
        __weak UIActivityIndicatorView *weakindicator = _activityIndicator;
        __weak UITableView *weaktableview = tableView;
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
            [weaktableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (row<self.dataSource.count) {
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            }
            NSDictionary *dic = self.dataSource[row];
            cell.textLabel.text = dic[@"cityname"];
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if ((indexPath.section == 0) &&(indexPath.row == 0)) {
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
    }
}
@end
