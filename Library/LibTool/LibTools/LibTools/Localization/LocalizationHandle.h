//
//  LocalizationHandle.h
//  TCDemo
//
//  Created by admin on 2019/9/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define kLocalizationMsg(key) NSLocalizedString(key, nil)
#define kLocalization_Msg(key) [LocalizationHandle getStringForKey:key withTable:@"InfoPlist"]

@interface LocalizationHandle : NSObject

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
+(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

@end

NS_ASSUME_NONNULL_END
