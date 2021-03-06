//
//  CommonFoundation.m
//  Sanbao
//
//  Created by WmVenusMac on 14-6-19.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import "CommonFoundation.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+JSON.h"
#import "sys/utsname.h"

@implementation CommonFoundation

//函数作用 :date根据formatter转换成string
+(NSString*)dateToString:(NSString *)formatter date:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return[dateFormatter stringFromDate:date];
}


//函数作用 :将日期从原格式转换成需要的格式
+(NSString*)convertDateFormatter:(NSString*)sourceFormatter
                 targetFormatter:(NSString*)targetFormatter
                      dateString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:sourceFormatter];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:targetFormatter];
    return[dateFormatter stringFromDate:date];
}

//函数作用 :将日期字符串转换成date
+(NSDate *)stringToDate:(NSString *)formatter dateString:(NSString *)dateString
{
    
    NSLocale *locale=[NSLocale currentLocale];
    
	NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[locale localeIdentifier]]];
	[dateFormatter setDateFormat:formatter];
	return [dateFormatter dateFromString:dateString];
}

//将char数据转换成utf8格式的string
+(NSString *)charToUTF8String:(const char *)charData
{
    NSString *string = [NSString stringWithUTF8String:charData];
    return string;
}

//函数作用 :得到随机数字
+(int)randNumber:(int)max
{
    return arc4random()%max+1;
}

//函数作用 :替换不必要的字符
+(NSString *)replaceStringToString:(NSString *)needReplaceStr
                     replaceString:(NSString *)replaceString
                   toReplaceString:(NSString *)toReplaceString
{
    NSString *string = [needReplaceStr stringByReplacingOccurrencesOfString:replaceString withString:toReplaceString];
    return string;
}

//函数作用 :去除首尾空格以及换行符号
+ (NSString *)trimString:(NSString *)buf
{
    //    NSString *string = [[NSMutableString alloc] initWithString:buf];
    //    [buf stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //
    //    CFStringTrimWhitespace((CFMutableStringRef)string);
    //
    //    return [string autorelease];
    return [buf.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(BOOL)isEmptyString:(NSString *)value
{
    if ((value == nil) || ([self trimString:value].length == 0) || (value == (NSString *)[NSNull null])) {
        return YES;
    }
    
    return NO;
}

//将data类型的数据,转成UTF8的数据
+(NSString *)dataToUTF8String:(NSData *)data
{
    NSString *buf = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //    NSString *buf = [[NSString alloc] initWithData:data encoding:enc];
    
	return buf;
}

//角度转弧度
+ (CGFloat)toRadians:(CGFloat)degree
{
    return degree / 180.0 * M_PI;
}
//弧度转角度
+ (CGFloat)toDegrees:(CGFloat)radian
{
    return radian / M_PI * 180.0;
}

//将string转换为指定编码
+(NSString *)changeDataToEncodinString:(NSData *)data encodin:(NSStringEncoding )encodin
{
    NSString *buf = [[NSString alloc] initWithData:data encoding:encodin];
    return buf;
}

//uialert提醒
+(void)alertWithTitle:(NSString *)title
              Message:(NSString *)message
             delegate:(id)delegate
         cancelButton:(NSString *)cancelButton
          otherButton:(NSString *)otherButton
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:delegate cancelButtonTitle:cancelButton otherButtonTitles:otherButton,nil];
	
	[alert show];
}

+ (BOOL)checkEmail:(NSString *)checkString
{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    
    return [emailTest evaluateWithObject:checkString];
}

+(BOOL)checkPhoneNo:(NSString *)checkString
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:checkString];
}

//将字符串转成MD5
+ (NSString *)MD5Value:(NSString *)str
{
	if (str==nil) {
		return nil;
	}
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

//秒转化为显示字符串
+ (NSString *)secondsToTimeStr:(NSInteger)time
{
    NSString *retStr;
    
    NSInteger min = time/60;
    NSInteger sec = time%60;
    
    if(min < 10 && sec < 10)
    {
        retStr = [NSString stringWithFormat:@"0%ld:0%ld",(long)min,(long)sec];
    }
    else if(min < 10)
    {
        retStr = [NSString stringWithFormat:@"0%ld:%ld",(long)min,(long)sec];
    }
    else if(sec < 10)
    {
        retStr = [NSString stringWithFormat:@"%ld:0%ld",(long)min,(long)sec];
    }
    else
    {
        retStr = [NSString stringWithFormat:@"%ld:%ld",(long)min,(long)sec];
    }
    
    return retStr;
}

/**
 解析查询字符串
 query : 查询字符串，以 ‘&’ 分隔
 */
+ (NSDictionary *)parseQueryString:(NSString *)query {
    // 定义字典
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 检测字符串中是否包含 ‘？’
    NSRange range = [query rangeOfString:@"?"];
    if(range.location != NSNotFound){
        NSArray *queryArr = [query componentsSeparatedByString:@"?"];
        [dict setObject:queryArr[0] forKey:@"url"];
        query = queryArr[1];
    }else{
        // 如果一个url连 '?' 都没有，那么肯定就没有参数
        [dict setObject:query forKey:@"url"];
        return dict;
    }
    
    // 检测字符串中是否包含 ‘&’
    if([query rangeOfString:@"&"].location != NSNotFound){
        // 以 & 来分割字符，并放入数组中
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        // 遍历字符数组
        for (NSString *pair in pairs) {
            // 以等号来分割字符
            NSArray *elements = [pair componentsSeparatedByString:@"="];
            NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            // 添加到字典中
            [dict setObject:val forKey:key];
        }
    }else if([query rangeOfString:@"="].location != NSNotFound){ // 检测字符串中是否包含 ‘=’
        NSArray *elements = [query componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // 添加到字典中
        [dict setObject:val forKey:key];
    }
    
    //NSLog(@"dict -> %@", dict);
    return dict;
}

/**
 获得今天为星期几
 */
+ (NSInteger)getweek{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;//[[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    return [comps weekday] - 1;
}

#pragma mark - 图片存储处理
+(UIImage *)getImageFromURL:(NSString *)fileURL {
    
    DLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSDataWritingAtomic error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSDataWritingAtomic error:nil];
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        DLog(@"文件后缀不认识");
    }
}

+(NSString *)timeStampStringWithDate:(NSDate *)date
{
    //    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    NSInteger interval = [zone secondsFromGMTForDate:date];
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return timeSp;
}

+(NSString *)dateStringWithTimeStamp:(NSString *)timeStamp withFormate:(NSString *)FormateString
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:FormateString];
    return [dateFormatter stringFromDate:confromTimesp];
}

//+ (CGFloat)getAdapterHeight {
//    CGFloat adapterHeight = 0;
//    if (![self isIOS7]) {
//        adapterHeight = 44;
//    }
//    return adapterHeight;
//}

+ (CGFloat)getStateBarHeight {
    CGFloat adapterHeight = 0;
    if (![self isIOS7]) {
        adapterHeight = 20;
    }
    return adapterHeight;
}

+ (CGFloat)getAdapter64Height {
    CGFloat adapterHeight = 0;
    if (![self isIOS7]) {
        adapterHeight = 64;
    }
    return adapterHeight;
}

+ (CGFloat)getAdapterNavigationHeight
{
    CGFloat adapterHeight = 0;
    if ([self isIOS7]) {
        adapterHeight = 64;
    }else{
        adapterHeight = 44;
    }
    return adapterHeight;
}

+ (BOOL)isIOS7 {
    return [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
}

+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (id)onCheckVersion
{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:APP_ITUNES_LOOKUP_URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [results JSONValue];
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        if (![lastVersion isEqualToString:currentVersion]) {
            return [releaseInfo objectForKey:@"trackViewUrl"];
        }
    }
    return [NSNumber numberWithBool:NO];
}

+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //获得设备型号
//        int mib[2];
//        size_t len;
//        char *machine;
//        
//        mib[0] = CTL_HW;
//        mib[1] = HW_MACHINE;
//        sysctl(mib, 2, NULL, &len, NULL, 0);
//        machine = malloc(len);
//        sysctl(mib, 2, machine, &len, NULL, 0);
//        
//        NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
//        free(machine);
    
        if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";//(A1203)
        if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";//(A1241/A1324)
        if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";//(A1303/A1325)
        if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";//(A1332)
        if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";//(A1332)
        if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";//(A1349)
        if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";//(A1387/A1431)
        if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";//(A1428)
        if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";//(A1429/A1442)
        if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";//(A1456/A1532)
        if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";//(A1507/A1516/A1526/A1529)
        if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";//(A1453/A1533)
        if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";//(A1457/A1518/A1528/A1530)
        if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";//(A1522/A1524)
        if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";//(A1549/A1586)
        
        if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";//(A1213)
        if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";//(A1288)
        if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";//(A1318)
        if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";//(A1367)
        if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";//(A1421/A1509)
        
        if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";//(A1219/A1337)
        
        if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";//(A1395)
        if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";//(A1396)
        if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";//(A1397)
        if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";//(A1395+New Chip)
        if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";//(A1432)
        if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";//(A1454)
        if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";//(A1455)
        
        if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";//(A1416)
        if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";//(A1403)
        if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";//(A1430)
        if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";//(A1458)
        if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";//(A1459)
        if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";//(A1460)
        
        if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";//(A1474)
        if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";//(A1475)
        if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";//(A1476)
        if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";//(A1489)
        if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";//(A1490)
        if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";//(A1491)
        
        if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
        if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
        return platform;
}

+(BOOL)isAllowRemoteNotifications
{
    if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_7_1){
//        BOOL isRemoteNotify = [UIApplication sharedApplication].isRegisteredForRemoteNotifications;
        UIUserNotificationType type = [UIApplication sharedApplication].currentUserNotificationSettings.types;
        int typeBadge = (type & UIUserNotificationTypeBadge);
        int typeSound = (type & UIUserNotificationTypeSound);
        int typeAlert = (type & UIUserNotificationTypeAlert);
        BOOL ret = typeBadge || typeSound || typeAlert;
        return ret;
    }else{
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        int typeBadge = (type & UIRemoteNotificationTypeBadge);
        int typeSound = (type & UIRemoteNotificationTypeSound);
        int typeAlert = (type & UIRemoteNotificationTypeAlert);
        BOOL ret = typeBadge || typeSound || typeAlert;
        return ret;
    }
}
@end