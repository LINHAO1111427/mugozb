//
//  AppKeyConfig.m
//  emo
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 . All rights reserved.
//

#import "AppKeyConfig.h"

@implementation AppKeyConfig

+ (NSString *)qqAPPID{
    return QQAppId;
}

+ (NSString *)qqAPPkey{
    return QQAppKey;
}

+ (NSString *)wxAPPID{
    return WXAppId;
}

+ (NSString *)wxAppSecret{
    return WXAppSecret;
}

+ (NSString *)universalLink{
    return UniversalLink;
}

+ (NSString *)sinaAPPKey{
    return @"";
}

+ (NSString *)sinaAPPSecret{
    return @"";
}

+ (NSString *)sinaRedirectUrl{
    return @"";
}

@end
