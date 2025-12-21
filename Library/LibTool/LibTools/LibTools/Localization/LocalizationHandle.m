//
//  LocalizationHandle.m
//  TCDemo
//
//  Created by admin on 2019/9/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LocalizationHandle.h"

@implementation LocalizationHandle

+(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table{
    if ([NSBundle mainBundle]) {
        return NSLocalizedStringFromTableInBundle(key, table, [NSBundle mainBundle], @"");
    }
    return NSLocalizedStringFromTable(key, table, @"");
}

@end
