//
//  LocationHelper.h
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-8.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationHelper : NSObject

typedef void(^DidGetGeolocationsCompledBlock)(LocationHelper *Lhelper,NSError *error);
@property (nonatomic, strong) NSString *addresslines;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *countryCode;

@property (nonatomic, strong) CLLocationManager *locationManager;

+(LocationHelper *)locationHelperManager;
- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled;

@end
