//
//  AppDelegate.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-13.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "AppDelegate.h"
#import "NSString+JSON.h"
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void)alertRemoteMessage:(NSString *)message withTitle:(NSString *)title
{
#ifdef DEBUG
    if (message) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
#endif
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [APPInfo shareInit].firstLaunch = YES;
    //友盟分享注册
    [UMSocialData setAppKey:UM_SOCIAL_KEY];
    //友盟统计分析
    [self umengTrack];
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
    
    // [2]:注册APNS
    [self registerRemoteNotification];
    
    // [2-EXT]: 获取启动时收到的APN
    NSDictionary *message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString *payloadMsg = [message objectForKey:@"payload"];
        [APPInfo shareInit].apnsType = payloadMsg;
//        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        [self alertRemoteMessage:[CommonFoundation dataToUTF8String:[message JSONString]] withTitle:@"launch"];
        UITabBarController *rootTab = (UITabBarController *)self.window.rootViewController;
        [self handlePushUserInfo:payloadMsg viewController:(UINavigationController *)rootTab.viewControllers[0]];
        DLog(@"launch%@",message);
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    return YES;
}

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
//    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UM_SOCIAL_KEY reportPolicy:(ReportPolicy) BATCH channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
//    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // [EXT] 切后台关闭SDK，让SDK第一时间断线，让个推先用APN推送
    [self stopSdk];
    [APPInfo shareInit].firstLaunch = NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // [EXT] 重新上线
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 注册通知
- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    if (!_gexinPusher) {
        _sdkStatus = SdkStatusStoped;
        
        NSError *err = nil;
        _gexinPusher = [GexinSdk createSdkWithAppId:kAppId
                                             appKey:kAppKey
                                          appSecret:kAppSecret
                                         appVersion:APP_VERSION
                                           delegate:self
                                              error:&err];
        if (!_gexinPusher) {
            [self alertRemoteMessage:[err localizedDescription] withTitle:nil];
        } else {
            _sdkStatus = SdkStatusStarting;
        }
        
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];

    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"deviceToken:%@", _deviceToken);
    
    // [3]:向个推服务器注册deviceToken
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:_deviceToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // [3-EXT]:如果APNS注册失败，通知个推服务器
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:@""];
    }
    
    [self alertRemoteMessage:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]] withTitle:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    [self alertRemoteMessage:record withTitle:nil];
    DLog(@"%@",userinfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    //从后台运行中打开调用
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    // [4-EXT]:处理APN
    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
    [APPInfo shareInit].apnsType = payloadMsg;
//    NSDictionary *aps = [userInfo objectForKey:@"aps"];
        //    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
    
        //    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
        //    [self alertRemoteMessage:record];
        //    DLog(@"%@",userInfo);
//    NSDictionary *bodyDic = aps[@"alert"];
    [self alertRemoteMessage:[CommonFoundation dataToUTF8String:[userInfo JSONString]] withTitle:@"completionHandler"];
    
    if (![APPInfo shareInit].firstLaunch) {
        if ([APPInfo shareInit].apnsType) {
            UINavigationController *selectedNaviVC=nil;
            id rootViewController = self.window.rootViewController;
            if ([rootViewController isKindOfClass:[UITabBarController class]]) {
                UITabBarController *rootTab = (UITabBarController *)rootViewController;
                
                if ([rootTab.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    selectedNaviVC = (UINavigationController *)rootTab.selectedViewController;
                }
            }
            [self handlePushUserInfo:[APPInfo shareInit].apnsType viewController:selectedNaviVC];
        }
        
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)stopSdk
{
    if (_gexinPusher) {
        [_gexinPusher destroy];
        _gexinPusher = nil;
        _sdkStatus = SdkStatusStoped;
    }
}

#pragma mark - GexinSdkDelegate
- (void)GexinSdkDidRegisterClient:(NSString *)clientId
{
    // [4-EXT-1]: 个推SDK已注册
    _sdkStatus = SdkStatusStarted;
    //通知并注册服务器 - 优化已经注册不再执行
    [[NSNotificationCenter defaultCenter] postNotificationName:UserRegistrationNotification object:nil userInfo:@{@"clientId":clientId?clientId:@"",@"devicetoken":_deviceToken?_deviceToken:@""}];
}

- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId
{
    // [4]: 收到个推消息
    
    NSData *payload = [_gexinPusher retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                                              length:payload.length
                                            encoding:NSUTF8StringEncoding];
    }
    /*
     {
     "from_uid" = 1;
     "from_username" = "\U5c0f\U79d8\U4e66";
     message = "\U5e8a\U524d\U660e\U6708\U5149\Uff0c\U7591\U662f\U5730\U4e0a\U971c\U3002";
     msgtype = 1;
     time = "2015-03-31 10:45:05";
     title = "\U9759\U591c\U601d";
     "to_uid" = 57;
     }
     */
    NSDictionary *msgDic = [payloadMsg JSONValue];
    if ([[CacheBox getCache:OPEN_MESSAGE_ALERT] isEqualToString:@"ON"]) {
        [self alertRemoteMessage:msgDic[@"message"] withTitle:msgDic[@"from_username"]];
    }
    
    if ([msgDic[@"msgtype"] isEqualToString:@"1"] || [msgDic[@"msgtype"] isEqualToString:@"2"]) {
        [CacheBox saveCache:MESSAGE_PUSH value:msgDic[@"msgtype"]];
    }else if([msgDic[@"msgtype"] isEqualToString:@"3"]){
        [CacheBox saveCache:SUBSCRIBE_PUSH value:msgDic[@"msgtype"]];
    }else{
        [CacheBox saveCache:SCORE_PUSH value:msgDic[@"msgtype"]];
    }
}

- (void)GexinSdkDidOccurError:(NSError *)error
{
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    [self alertRemoteMessage:[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]] withTitle:nil];
}

-(void)handlePushUserInfo:(NSString *)apnsType viewController:(UINavigationController *)vc
{
    if (apnsType) {
        if (vc) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *controller = nil;
            switch ([apnsType intValue]) {
                case 1:
                case 2:
                {
                    controller = [story instantiateViewControllerWithIdentifier:@"messagegroupBoard"];
                    break;
                }
                case 3:
                {
                    controller = [story instantiateViewControllerWithIdentifier:@"SubscribeBoard"];
                    break;
                }
                case 4:
                {
                    controller = [story instantiateViewControllerWithIdentifier:@"leaderScoreBoard"];
                    break;
                }
                default:
                    break;
            }
            if (controller) {
                [vc.visibleViewController.navigationController pushViewController:controller animated:YES];
            }
        }
    }
}
@end
