//
//  XTMediaConfig.h
//  XTMediaKit
//
//  Created by shirley on 2019/7/22.
//  Copyright © 2019 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XTMediaConfig <NSObject>


///基础地址
+ (NSString *)baseUrl;

///用户ID
+ (int64_t)userId;

///用户token
+ (NSString *)userToken;

///获得记录key
+ (NSString *)getRecordKey;


@optional

+ (BOOL)isUploadService;


@end

NS_ASSUME_NONNULL_END
