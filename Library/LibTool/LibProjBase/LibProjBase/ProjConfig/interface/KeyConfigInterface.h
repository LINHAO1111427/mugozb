//
//  KeyConfigInterface.h
//  emo
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KeyConfigInterface <NSObject>

+ (NSString *)qqAPPID;

+ (NSString *)qqAPPkey;

+ (NSString *)wxAPPID;

+ (NSString *)wxAppSecret;

+ (NSString *)universalLink;

+ (NSString *)sinaAPPKey;

+ (NSString *)sinaAPPSecret;

+ (NSString *)sinaRedirectUrl;

@end

NS_ASSUME_NONNULL_END
