//
//  PushInfoHandle.m
//  PushKit
//
//  Created by klc_sl on 2021/11/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "PushInfoHandle.h"

@implementation PushInfoHandle

- (NSMutableDictionary *)param{
    if (!_param) {
        _param = [[NSMutableDictionary alloc] init];
    }
    return _param;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSDictionary *tempDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"PushInfoHandle"];
        [self.param addEntriesFromDictionary:tempDic];
        
    }
    return self;
}

///保存推送ID
- (void)savePushId:(NSString *)pushId {

    if (pushId.length == 0) {
        return;
    }
    
    [self.param setObject:[self getCurrentDateString] forKey:pushId];
    [[NSUserDefaults standardUserDefaults] setObject:[self.param copy] forKey:@"PushInfoHandle"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    ///当天日期
    NSString *currentDate = [self getCurrentDateString];
    ///存放临时数据
    NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:self.param];
    ///遍历
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        ///如果保存的数据日期不等于当天 && 当前的推送ID也不等于保存的ID ---》删除该数据
        (![obj isEqualToString:currentDate] && ([pushId longLongValue] != [key longLongValue]))?[self.param removeObjectForKey:key]:nil;
    }];
    
}

///推送ID是否存在
- (BOOL)existsPushId:(NSString *)pushId {
    
    __block BOOL exists = NO;
    if (pushId.length > 0) {
        [self.param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([pushId longLongValue] == [key longLongValue]){
                exists = YES;
                *stop = YES;
            }
        }];
    }
    return exists;
}


///获取当前日期
- (NSString *)getCurrentDateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}

@end
