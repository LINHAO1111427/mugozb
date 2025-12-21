//
//  TimeTool.m
//  Message
//
//  Created by klc_tqd on 2020/5/12.
//  Copyright © 2020 . All rights reserved.
//

#import "TimeTool.h"
#define kLocalizationMsg(key) NSLocalizedString(key, nil)

@implementation TimeTool
#pragma mark --- 将时间转换成时间戳
+ (NSString *)getTimestampFromTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    //    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}


#pragma mark ---- date 转时间戳
+ (NSString *)getTimestampFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    //    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    //    NSString *nowtimeStr = [formatter stringFromDate:date];//----------将nsdate按formatter格式转成nsstring
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return timeSp;
}

#pragma mark ---- nsdate ->nsstring
+ (NSString *)nsdateToNSString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

#pragma mark ---- 年月日
+ (NSString *)getDatetampFromTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    //    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSDate *date = [NSDate date];
    NSString *strDate = [formatter stringFromDate:date];
    
    NSDate *birthdayDate = [formatter dateFromString:strDate];
    //    NSString *nowtimeStr = [formatter stringFromDate:birthdayDate];//----------将nsdate按formatter格式转成nsstring
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[birthdayDate timeIntervalSince1970]];
    
    return timeSp;
}


#pragma mark ---- 返回时间str
+ (NSString *)getDateStrFromeTime:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    //    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *strDate = [formatter stringFromDate:date];
    
    NSDate *birthdayDate = [formatter dateFromString:strDate];
    NSString *nowtimeStr = [formatter stringFromDate:birthdayDate];//----------将nsdate按formatter格式转成nsstring
    
    return nowtimeStr;
}

+ (NSString *)getTimeStampUserDefault
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"timeStampOfAddressBook"];
}

+ (void)saveTimeStampUserDefault:(NSString *)timeStamp
{
    [[NSUserDefaults standardUserDefaults] setObject:timeStamp forKey:@"timeStampOfAddressBook"];
}


#pragma mark ---- 将时间戳转换成时间
+ (NSString *)getTimeFromTimestamp:(NSString *)timeStamp{
    //将对象类型的时间转换为NSDate类型
    //    double time = 1504667976;
    double timeStampDouble = [timeStamp doubleValue];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timeStampDouble];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

#pragma mark ---- 秒转换成时分秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02d",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02d",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02d",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}


+ (NSString *)nowTimeSwitchTimestamp{
    NSDate *datenow = [NSDate date];//现在时间
    
    //这里如果long不够用,就用(long long)
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([datenow timeIntervalSince1970]*1000)];
    
    return timeSp;
}


//判断是不是同一分钟 同一分钟不显示时间
+ (BOOL)judgeSaveMinute:(NSString *)lastMsg nowMsg:(NSString *)nowMsg
{
    if ([lastMsg isEqualToString:nowMsg]) {
        return NO;
    }else{
        return YES;
    }
}

+ (NSInteger)judgeBetweenSecond:(NSDate *)beforeTime lastTime:(NSDate *)lastTime{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit 枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:beforeTime toDate:lastTime options:0];
    return cmps.second;
}


+ (NSString *)achieveDayFormatByTimeString:(NSString *)timeString;
{
    if (!timeString || timeString.length < 10) {
        return kLocalizationMsg(@"时间未知");
    }
    //将时间戳转为NSDate类
    NSTimeInterval time = [[timeString substringToIndex:10] doubleValue];
    NSDate *inputDate=[NSDate dateWithTimeIntervalSince1970:time];
    //
    NSString *lastTime = [self compareDate:inputDate];
    return lastTime;
}

+ (NSString *)compareDate:(NSDate *)inputDate{
    
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger goalInterval = [zone secondsFromGMTForDate: inputDate];
    NSDate *date = [inputDate  dateByAddingTimeInterval: goalInterval];
    
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSInteger localInterval = [zone secondsFromGMTForDate: currentDate];
    NSDate *localeDate = [currentDate  dateByAddingTimeInterval: localInterval];
    
    //今天／昨天／前天
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSDate *today = localeDate;
    NSDate *yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    //    NSDate *beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    //    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    //今年
    NSString *toYears = [[today description] substringToIndex:4];
    
    //目标时间拆分为 年／月
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
        //其他时间
        NSString *time2 = [[date description] substringWithRange:(NSRange){5,11}];
        if ([dateString isEqualToString:todayString]){
            //今天
            dateContent = [NSString stringWithFormat:@"%@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            //昨天
            dateContent = [NSString stringWithFormat:kLocalizationMsg(@"昨天")];
            return dateContent;
        }else{
            //前天
            dateContent = [NSString stringWithFormat:@"%@",time2];
            return dateContent;
        }
    }else{
        //不同年，显示具体日期：如，2008-11-11
        return dateString;
    }
}

+ (NSString*)getTimeStringAutoShort2:(NSDate*)dt mustIncludeTime:(BOOL)includeTime{
    
    NSString *ret = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 当前时间
    
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *curComponents = [calendar components: NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:currentDate];
    
    NSInteger currentYear=[curComponents year];
    
    NSInteger currentMonth=[curComponents month];
    
    NSInteger currentDay=[curComponents day];
    
    // 目标判断时间
    
    NSDateComponents*srcComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:dt];
    
    NSInteger srcYear=[srcComponents year];
    
    NSInteger srcMonth=[srcComponents month];
    
    NSInteger srcDay=[srcComponents day];
    
    // 要额外显示的时间分钟
    
    NSString *timeExtraStr = (includeTime?[TimeTool getTimeString:dt format:@" HH:mm"]:@"");
    
    // 当年
    
    if(currentYear == srcYear) {
        
        long currentTimestamp = [TimeTool getIOSTimeStamp_l:currentDate];
        
        long srcTimestamp = [TimeTool getIOSTimeStamp_l:dt];
        
        // 相差时间（单位：秒）
        
        long delta = currentTimestamp - srcTimestamp;
        
        // 当天（月份和日期一致才是）
        
        if(currentMonth == srcMonth && currentDay == srcDay) {
            
            // 时间相差60秒以内
            
            if(delta < 60)
                
                ret = kLocalizationMsg(@"刚刚");
            
            // 否则当天其它时间段的，直接显示“时:分”的形式
            
            else
                
                ret = [TimeTool getTimeString:dt format:@"HH:mm"];
            
        }
        
        // 当年 && 当天之外的时间（即昨天及以前的时间）
        
        else{
            
            // 昨天（以“现在”的时候为基准-1天）
            
            NSDate *yesterdayDate = [NSDate date];
            
            yesterdayDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:yesterdayDate];
            
            NSDateComponents *yesterdayComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:yesterdayDate];
            
            NSInteger yesterdayMonth = [yesterdayComponents month];
            
            NSInteger yesterdayDay = [yesterdayComponents day];
            
            // 前天（以“现在”的时候为基准-2天）
            
            NSDate*beforeYesterdayDate = [NSDate date];
            
            beforeYesterdayDate = [NSDate dateWithTimeInterval:-48*60*60 sinceDate:beforeYesterdayDate];
            
            NSDateComponents*beforeYesterdayComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:beforeYesterdayDate];
            
            NSInteger beforeYesterdayMonth=[beforeYesterdayComponents month];
            
            NSInteger beforeYesterdayDay=[beforeYesterdayComponents day];
            
            // 用目标日期的“月”和“天”跟上方计算出来的“昨天”进行比较，是最为准确的（如果用时间戳差值
            
            // 的形式，是不准确的，比如：现在时刻是2019年02月22日1:00、而srcDate是2019年02月21日23:00，
            
            // 这两者间只相差2小时，直接用“delta/3600” > 24小时来判断是否昨天，就完全是扯蛋的逻辑了）
            
            if(srcMonth == yesterdayMonth && srcDay == yesterdayDay)
                
                ret = [NSString stringWithFormat:kLocalizationMsg(@"昨天%@"), timeExtraStr];// -1d
            
            // “前天”判断逻辑同上
            
            else if(srcMonth == beforeYesterdayMonth && srcDay == beforeYesterdayDay)
                
                ret = [NSString stringWithFormat:kLocalizationMsg(@"前天%@"), timeExtraStr];// -2d
            
            else{
                
                // 跟当前时间相差的小时数
                
                long deltaHour = (delta/3600);
                
                
                
                // 如果小于或等 7*24小时就显示星期几
                
                if(deltaHour <= 7*24){
                    
                    NSArray<NSString*> *weekdayAry = [NSArray arrayWithObjects:kLocalizationMsg(@"星期日"), kLocalizationMsg(@"星期一"), kLocalizationMsg(@"星期二"), kLocalizationMsg(@"星期三"), kLocalizationMsg(@"星期四"), kLocalizationMsg(@"星期五"), kLocalizationMsg(@"星期六")];
                    
                    // 取出的星期数：1表示星期天，2表示星期一，3表示星期二。。。。 6表示星期五，7表示星期六
                    
                    NSInteger srcWeekday=[srcComponents weekday];
                    
                    // 取出当前是星期几
                    
                    NSString *weedayDesc = [weekdayAry objectAtIndex:(srcWeekday-1)];
                    
                    ret = [NSString stringWithFormat:@"%@%@", weedayDesc, timeExtraStr];
                    
                }
                
                // 否则直接显示完整日期时间
                
                else
                    
                    ret = [NSString stringWithFormat:@"%@%@", [TimeTool getTimeString:dt format:@"yyyy/M/d"], timeExtraStr];
                
            }
            
        }
        
    }
    
    // 往年
    
    else{
        
        ret = [NSString stringWithFormat:@"%@%@", [TimeTool getTimeString:dt format:@"yyyy/M/d"], timeExtraStr];
        
    }
    
    return ret;
    
}

+ (NSString*)getTimeString:(NSDate*)dt format:(NSString*)fmt{
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:fmt];
    
    return[format stringFromDate:(dt==nil?[TimeTool getIOSDefaultDate]:dt)];
    
}

+ (NSTimeInterval) getIOSTimeStamp:(NSDate*)dat{
    
    NSTimeInterval a = [dat timeIntervalSince1970];
    
    return a;
    
}

+ (long) getIOSTimeStamp_l:(NSDate*)dat{
    return [[NSNumber numberWithDouble:[TimeTool getIOSTimeStamp:dat]] longValue];
}

+ (NSDate*)getIOSDefaultDate{
    return [NSDate date];
}


+ (BOOL)isNewMessageShowTime:(NSDate *)newMessageTimeDate compareMessageDate:(NSDate *)compareMessageDate{
    if (compareMessageDate) {
        NSTimeInterval timeBetween = [newMessageTimeDate timeIntervalSinceDate:compareMessageDate];
        if (fabs(timeBetween) > 180) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}


@end
