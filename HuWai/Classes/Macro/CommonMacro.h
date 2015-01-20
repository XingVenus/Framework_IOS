//
//  CommonMacro.h
//  Sanbao
//
//  Created by WmVenusMac on 14-6-16.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#ifndef Sanbao_CommonMacro_h
#define Sanbao_CommonMacro_h

//#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define _APPDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

//应用名称
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//应用软件版本
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//应用软件build版本 一般作为开发内部使用
#define APP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//设备屏幕宽度
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
//设备屏幕高度
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

//调试log
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//设备系统版本
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//沙盒Documents目录
#define APP_DOC_DIR     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//沙盒Library目录
#define APP_LIB_DIR     [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
//沙盒Library下的cache目录
#define APP_LIB_CACHE_DIR  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
//沙盒tmp下的cache目录,这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息
#define APP_TMP_DIR        NSTemporaryDirectory()

#define WEAKSELF __weak __typeof(self) weakSelf = self;//// AFNetworking的写法__weak __typeof(&*self)weakSelf = self;这种写法不局限于某个viewcontroller

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#endif
