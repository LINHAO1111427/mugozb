//
//  TimeTool.h
//  Message
//
//  Created by klc_tqd on 2020/5/12.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeTool : NSObject


///时间转时间戳
+ (NSString *)getTimestampFromTime;

///时间戳转时间
+ (NSString *)getTimeFromTimestamp:(NSString *)timeStamp;

///date 转时间戳
+ (NSString *)getTimestampFromDate:(NSDate *)date;

+ (NSString *)nowTimeSwitchTimestamp;

///年月日
+ (NSString *)getDatetampFromTime;

///返回时间str
+ (NSString *)getDateStrFromeTime:(NSDate *)date;

///userDefault 通讯录里的时间戳保存与读取
+ (NSString *)getTimeStampUserDefault;


+ (void)saveTimeStampUserDefault:(NSString *)timeStamp;

///nsdate ->nsstring
+ (NSString *)nsdateToNSString:(NSDate *)date;

///秒转换成时分秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime;

///判断是不是同一分钟 同一分钟不显示时间
+ (BOOL)judgeSaveMinute:(NSString *)lastMsg nowMsg:(NSString *)nowMsg;

///判读两个时间之间相差多少秒
+ (NSInteger)judgeBetweenSecond:(NSDate *)beforeTime lastTime:(NSDate *)lastTime;


+ (NSString *)achieveDayFormatByTimeString:(NSString *)timeString;


+ (NSString*)getTimeStringAutoShort2:(NSDate*)dt mustIncludeTime:(BOOL)includeTime;


+ (NSString*)getTimeString:(NSDate*)dt format:(NSString*)fmt;


+ (NSTimeInterval) getIOSTimeStamp:(NSDate*)dat;

 

///获得指定NSDate对象iOS时间戳的long形式（格式遵从ios的习惯，以秒为单位，形如：1485159493）。

+ (long) getIOSTimeStamp_l:(NSDate*)dat;

 
///获得iOS当前系统时间的NSDate对象。

+ (NSDate*)getIOSDefaultDate;



///比较当前消息的时间和上一条消息的时间，放回当前消息是否需要显示时间
+ (BOOL)isNewMessageShowTime:(NSDate *)newMessageTimeDate compareMessageDate:(NSDate *_Nullable)compareMessageDate;


@end

NS_ASSUME_NONNULL_END
