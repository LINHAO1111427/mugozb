//
//  PushSessionObj.h
//  PushKit
//
//  Created by shao on 2019/9/9.
//  Copyright © 2019 klc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PushSessionObj : NSObject

//+ (void)requestSession:(NSString *)url param:(NSDictionary *)param userId:(int64_t)uid userToken:(NSString *)utoken complete:(void(^)(BOOL success, id _Nullable info))complete;

+ (void)requestSession:(NSString *)url param:(NSDictionary *)param complete:(void (^)(BOOL success, id _Nullable info))complete;

@end

NS_ASSUME_NONNULL_END
