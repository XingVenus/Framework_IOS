//
//  LocationHelper.m
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-8.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "LocationHelper.h"

@interface LocationHelper () <CLLocationManagerDelegate>

@property (nonatomic, copy) DidGetGeolocationsCompledBlock didGetGeolocationsCompledBlock;

@end

@implementation LocationHelper

+(LocationHelper *)locationHelperManager
{
    static LocationHelper *locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[self alloc] init];
    });
    return locationManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationManager) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.distanceFilter = kCLDistanceFilterNone;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//            _locationManager.distanceFilter = 5.0;
        }
    }
}

- (void)dealloc {
//    self.locationManager.delegate = nil;
//    self.locationManager = nil;
    self.didGetGeolocationsCompledBlock = nil;
}

- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled
{

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    // As of iOS 8, apps must explicitly request location services permissions. INTULocationManager supports both levels, "Always" and "When In Use".
    // INTULocationManager determines which level of permissions to request based on which description key is present in your app's Info.plist
    // If you provide values for both description keys, the more permissive "Always" level is requested.
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1 && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        BOOL hasWhenInUseKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil;
        BOOL hasAlwaysKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil;

        if (hasWhenInUseKey) {
            [self.locationManager requestWhenInUseAuthorization];
        } else if (hasAlwaysKey) {
            [self.locationManager requestAlwaysAuthorization];
        } else {
            // At least one of the keys NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription MUST be present in the Info.plist file to use location services on iOS 8+.
//            NSAssert(hasAlwaysKey || hasWhenInUseKey, @"To use location services in iOS 8+, your Info.plist must provide a value for either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription.");
        }
    }
#endif
    self.didGetGeolocationsCompledBlock = compled;
    [self.locationManager startUpdatingLocation];
    //判断定位服务的开启并授权
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"%@",@"未开启定位服务");
        [self alertDeniedMessage];
    }
}

#pragma mark - CLLocationManager Delegate

// 代理方法实现
/**
 返回位置信息的实现
 CLPlacemark *placemark = [placemarks lastObject];
 if (placemark) {
     NSDictionary *addressDictionary = placemark.addressDictionary;
     NSArray *formattedAddressLines = [addressDictionary valueForKey:@"FormattedAddressLines"];
     NSString *geoLocations = [formattedAddressLines lastObject];
     NSLog(@"%@",geoLocations);
 }
 
 */
#pragma mark 定位成功
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __weak __typeof(self) weakSelf = self;
    [geocoder reverseGeocodeLocation:currLocation completionHandler:
     ^(NSArray* placemarks, NSError* error) {
         //返回位置信息的实现
         CLPlacemark *placemark = [placemarks lastObject];
         if (placemark) {
             NSDictionary *addressDictionary = placemark.addressDictionary;
             NSArray *formattedAddressLines = [addressDictionary valueForKey:@"FormattedAddressLines"];
             weakSelf.addresslines = [formattedAddressLines lastObject];
             weakSelf.countryCode = addressDictionary[@"CountryCode"];
             weakSelf.country = addressDictionary[@"Country"];
             weakSelf.state = addressDictionary[@"State"];
             weakSelf.city = addressDictionary[@"City"];
             weakSelf.street = addressDictionary[@"Street"];
         }
         if (self.didGetGeolocationsCompledBlock && placemarks.count>0) {
             self.didGetGeolocationsCompledBlock(weakSelf,nil);
         }else if (error){
             self.didGetGeolocationsCompledBlock(nil,error);
         }
     }];
    [manager stopUpdatingLocation];
}
#pragma mark 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if (self.didGetGeolocationsCompledBlock) {
        self.didGetGeolocationsCompledBlock(nil,error);
    }
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [manager requestWhenInUseAuthorization];
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [manager requestAlwaysAuthorization];
            }else{
                [manager startUpdatingLocation];
            }
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            //弹出未开启提示
            [self alertDeniedMessage];
            break;
        }
        default:
            break;
    }
}
#pragma mark 未开启定位服务的信息提示
-(void)alertDeniedMessage
{
    NSString *message = [NSString stringWithFormat:@"请在iPhone “设置-隐私-定位服务”中允许%@使用定位服务",APP_NAME];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
#ifdef __IPHONE_8_0
    alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
#endif
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (&UIApplicationOpenSettingsURLString != NULL) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}
@end
