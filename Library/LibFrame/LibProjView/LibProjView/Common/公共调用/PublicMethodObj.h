//
//  PublicMethodObj.h
//  LibProjView
//
//  Created by klc_sl on 2021/5/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicMethodObj : NSObject

+ (void)showUrl:(NSString *)url;



///判断启动视图的时间于当前时间间隔
+ (void)launchTimeJudge:(NSString *)keys withinOneDayBlock:(void(^)(BOOL within))block;
///更新启动时间为当前时间
+ (void)LaunchTimechange:(NSString *)keys;

@end

NS_ASSUME_NONNULL_END
