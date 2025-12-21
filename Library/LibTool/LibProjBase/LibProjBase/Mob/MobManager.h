//
//  MobManager.h
//  TCDemo
//
//  Created by admin on 2019/11/13.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/SSDKTypeDefine.h>
#import <ShareSDK/ShareSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobManager : NSObject

+ (void)registPlatforms;


+ (void)shareType:(SSDKPlatformType)type title:(NSString *)title content:(NSString *)content image:(id)image url:(NSString *)url shareResult:(void(^)(BOOL success))shareResult;


+ (void)loginType:(SSDKPlatformType)type resultHandle:(void(^)(BOOL success, SSDKUser *user))handle;


@end

NS_ASSUME_NONNULL_END
