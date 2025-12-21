//
//  NSDate+Time.h
//  LibTools
//
//  Created by klc_sl on 2020/7/18.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Time)

///时间戳
+ (NSString *)timeInterval:(int64_t)time dateFormat:(NSString *)dateFormat;


+ (NSDate *)dateFormString:(NSString *)str dataFormat:(NSString *)dateFormat;


- (NSString *)timeStringWithDateFormat:(NSString *)dateFormat;




@end

NS_ASSUME_NONNULL_END
