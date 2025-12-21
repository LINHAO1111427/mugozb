//
//  IPhoneInfo.h
//  TCDemo
//
//  Created by admin on 2019/11/16.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IPhoneInfo : NSObject

+ (NSString *)appVersionNO;

+ (NSString *)appVersionBuild;

+ (NSString *)phoneType;

+ (NSString *)systemVersion;

+ (NSString *)phoneUUID;

+ (NSString *)ipAddress;

+ (NSString *)appBundleIdentifier;
@end


