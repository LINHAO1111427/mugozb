//
//  HttpSessionObj.h
//  XTMedisKit
//
//  Created by shirley on 2019/9/9.
//  Copyright © 2019 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpSessionObj : NSObject


+ (void)getRtcToken:(NSString *)channelName userId:(int64_t)uid successBlock:(void(^)(BOOL success, NSDictionary *dic))block;

+ (void)sendpushUrl:(NSString *)pushUrl userId:(int64_t)uid roomId:(NSString *)roomId successBlock:(void (^)(BOOL, NSDictionary * _Nonnull))block;
@end

NS_ASSUME_NONNULL_END
