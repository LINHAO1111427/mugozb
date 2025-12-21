//
//  ScreenReocrdManager.h
//  LibProjView
//
//  Created by ssssssss on 2020/11/9.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScreenReocrdManager : NSObject

/// 开始监听
+(void)startMonitor;

/// 结束监听
+(void)stopMonitor;
@end

NS_ASSUME_NONNULL_END
