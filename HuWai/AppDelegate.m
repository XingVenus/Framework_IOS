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
    if (message) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //友盟分享注册
    [UMSocialData setAppKey:UM_SOCIAL_KEY];
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
    
    // [2]:注册APNS
    [self registerRemoteNotification];
    
    // [2-EXT]: 获取启动时收到的APN
    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString *payloadMsg = [message objectForKey:@"payload"];
        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        [self alertRemoteMessage:record withTitle:nil];
        DLog(@"%@",message);
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    return YES;
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
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
//    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
    
//    NSDictionary *aps = [userInfo objectForKey:@"aps"];
        //    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
    
        //    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
        //    [self alertRemoteMessage:record];
        //    DLog(@"%@",userInfo);
//    NSDictionary *bodyDic = aps[@"alert"];
//    [self alertRemoteMessage:bodyDic[@"body"] withTitle:nil];
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
    //通知并注册服务器
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
@end
