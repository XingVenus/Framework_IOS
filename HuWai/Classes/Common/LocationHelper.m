//
//  LocationHelper.m
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-8.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "LocationHelper.h"

@interface LocationHelper () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) DidGetGeolocationsCompledBlock didGetGeolocationsCompledBlock;

@end

@implementation LocationHelper

- (void)setup {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 5.0;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.locationManager.delegate = nil;
    self.locationManager = nil;
    self.didGetGeolocationsCompledBlock = nil;
}

- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    // As of iOS 8, apps must explicitly request location services permissions. INTULocationManager supports both levels, "Always" and "When In Use".
    // INTULocationManager determines which level of permissions to request based on which description key is present in your app's Info.plist
    // If you provide values for both description keys, the more permissive "Always" level is requested.
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1 && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//        BOOL hasAlwaysKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil;
        BOOL hasWhenInUseKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil;
        if (hasWhenInUseKey) {
            [self.locationManager requestWhenInUseAuthorization];
        }
//        if (hasAlwaysKey) {
//            [self.locationManager requestAlwaysAuthorization];
//        } else if (hasWhenInUseKey) {
//            [self.locationManager requestWhenInUseAuthorization];
//        } else {
//            // At least one of the keys NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription MUST be present in the Info.plist file to use location services on iOS 8+.
////            NSAssert(hasAlwaysKey || hasWhenInUseKey, @"To use location services in iOS 8+, your Info.plist must provide a value for either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription.");
//        }
    }
#endif /* __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1 */
    self.didGetGeolocationsCompledBlock = compled;
    [self.locationManager startUpdatingLocation];
    //判断定位服务的开启并授权
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"%@",@"未开启定位服务");
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

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currLocation completionHandler:
     ^(NSArray* placemarks, NSError* error) {
         if (self.didGetGeolocationsCompledBlock && placemarks.count>0) {
             self.didGetGeolocationsCompledBlock(placemarks,nil);
         }
     }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    if (self.didGetGeolocationsCompledBlock) {
        self.didGetGeolocationsCompledBlock(nil,error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [manager requestAlwaysAuthorization];
            }
            break;
        }
        default:
            break;
            
    }
}
@end
