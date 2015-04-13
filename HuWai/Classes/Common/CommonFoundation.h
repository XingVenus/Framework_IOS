//
//  CommonFoundation.h
//  Sanbao
//
//  Created by WmVenusMac on 14-6-19.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFoundation : NSObject

/**   函数名称 :dateToString
 **   函数作用 :date根据formatter转换成string
 **   函数参数 :
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           date       ---日期
 **   函数返回值:格式
 **/
+(NSString*)dateToString:(NSString *)formatter date:(NSDate *)date;


/**   函数名称 :convertDateFormatter
 **   函数作用 :将日期从原格式转换成需要的格式
 **   函数参数 :
 **           sourceFormatter  ---原格式
 **           targetFormatter  ---要的格式，比如:@"MMM yyyy"
 **           dateString       ---日期
 **   函数返回值:格式
 **/
+(NSString*)convertDateFormatter:(NSString*)sourceFormatter
                 targetFormatter:(NSString*)targetFormatter
                      dateString:(NSString*)dateString;


/**   函数名称 :stringToDate
 **   函数作用 :将日期字符串转换成date
 **   函数参数 :
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           dateString ---日期
 **   函数返回值:date
 **/
+(NSDate *)stringToDate:(NSString *)formatter dateString:(NSString *)dateString;


/**   函数名称 :charToUTF8String
 **   函数作用 :将char数据转换成utf8格式的string
 **   函数参数 :
 **           charData  ---需转换的char数据
 **   函数返回值:utf8格式string
 **/
+(NSString *)charToUTF8String:(const char *)charData;


/**   函数名称 :randNumber
 **   函数作用 :得到随机数字
 **   函数参数 :   max －－随机数的最大值
 **   函数返回值:随机数
 **/
+(int)randNumber:(int)max;


/**   函数名称 :replaceStringToString
 **   函数作用 :替换不需要的字符
 **   函数参数 :   needReplaceStr   ---需要替换的string
 replaceString    ---需要替换掉的特殊字符
 toReplaceString  ---替换成需要的字符
 **   函数返回值:替换后string
 **/
+(NSString *)replaceStringToString:(NSString *)needReplaceStr
                     replaceString:(NSString *)replaceString
                   toReplaceString:(NSString *)toReplaceString;


/**   函数名称 :replaceFirstAndEndSpace
 **   函数作用 :去除首尾空格
 **   函数参数 :   buf   ---需要替换的string
 **   函数返回值:去除首尾空格后的string
 **/
+(NSString *)trimString:(NSString *)buf;

/**
 *  判断字符串为空 包括 nil @""  null NULL
 *
 */
+(BOOL)isEmptyString:(NSString *)value;

/**   函数名称 :DataToUTF8String
 **   函数作用 :将data类型的数据,转成UTF8的数据
 **   函数参数 :   data   ---需要转化的data
 **   函数返回值:utf8格式string
 **/
+(NSString *)dataToUTF8String:(NSData *)data;


/**   函数名称 :toRadians
 **   函数作用 :角度转弧度
 **   函数参数 :  角度
 **   函数返回值:  弧度
 **/
//角度转弧度
+ (CGFloat)toRadians:(CGFloat)degree;
//弧度转角度
+ (CGFloat)toDegrees:(CGFloat)radian;



/**   函数名称 :changeDataToEncodinString
 **   函数作用 :将data转换成所需格式的string
 **   函数参数 :
 **            data ---所需转化的data
 **         encodin ---编码格式
 **   函数返回值:  转换好的string
 **/
+(NSString *)changeDataToEncodinString:(NSData *)data encodin:(NSStringEncoding )encodin;



/**   函数名称 :alertWithTitle
 **   函数作用 :提醒工具
 **   函数参数 :  title               ---提醒的标题(可以为nil)
 **              Message            ---提醒的内容(可以为nil)
 **             delegate            ---delegate(可以为nil)
 **            cancelButton         ---取消按钮(可以为nil)
 **             otherButton         ---其他按钮(可以为nil)
 **   函数返回值:  无
 **/
+(void)alertWithTitle:(NSString *)title
              Message:(NSString *)message
             delegate:(id)delegate
         cancelButton:(NSString *)cancelButton
          otherButton:(NSString *)otherButton;

/**   函数名称 :checkEmail:
 **   函数作用 :检测邮箱是否合法
 **   函数参数 : 待检测的邮箱地址
 **   函数返回值:  YES 合法 NO 不合法
 **/
+ (BOOL)checkEmail:(NSString *)checkString;
/**
 *  checkString - 待检测的电话号码字符串
 *  检测电话号码的合法性
 */
+ (BOOL)checkPhoneNo:(NSString *)checkString;

+ (NSString *)MD5Value:(NSString *)str;

+ (NSString *)secondsToTimeStr:(NSInteger)time;

////////////add  by jx//////////
/**
 解析查询字符串
 query : 查询字符串，以 ‘&’ 分隔
 */
+ (NSDictionary *)parseQueryString:(NSString *)query;

/**
 获得今天为星期几
 */
+ (NSInteger)getweek;

#pragma mark - 图片处理
+(UIImage *)getImageFromURL:(NSString *)fileURL;
+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

+(NSString *)timeStampStringWithDate:(NSDate *)date;
+(NSString *)dateStringWithTimeStamp:(NSString *)timeStamp withFormate:(NSString *)FormateString;

//add by venus
//+ (CGFloat)getAdapterHeight;
+ (CGFloat)getStateBarHeight;
+ (CGFloat)getAdapter64Height;
+ (CGFloat)getAdapterNavigationHeight;
+ (BOOL)isIOS7;
//版本检测
+ (id)onCheckVersion;
/**
 *  获得Ios系统版本号的函数
 */
+ (float)getIOSVersion;

+ (NSString *)deviceString;
@end

