//
//  AppDelegate.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-13.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GexinSdk.h"
typedef enum {
    SdkStatusStoped,
    SdkStatusStarting,
    SdkStatusStarted
} SdkStatus;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GexinSdkDelegate>
{
    @private
    NSString *_deviceToken;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GexinSdk *gexinPusher;
@property (assign, nonatomic) SdkStatus sdkStatus;
-(void)handlePushUserInfo:(NSString *)apnsType viewController:(UINavigationController *)vc;
@end

