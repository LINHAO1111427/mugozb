//
//  NSDate+Time.m
//  LibTools
//
//  Created by klc_sl on 2020/7/18.
//  Copyright © 2020 . All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)


+ (NSString *)timeInterval:(int64_t)time dateFormat:(NSString *)dateFormat{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:dateFormat];
    
    NSString* string=[formatter stringFromDate:confromTimesp];
    
    return string;

}

+ (NSDate *)dateFormString:(NSString *)str dataFormat:(NSString *)dateFormat {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:dateFormat];
    
    NSDate *date = [format dateFromString:str];
    
    return date;
}

- (NSString *)timeStringWithDateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:dateFormat];
    
    NSString* string=[formatter stringFromDate:self];
    
    return string;    
}


@end
