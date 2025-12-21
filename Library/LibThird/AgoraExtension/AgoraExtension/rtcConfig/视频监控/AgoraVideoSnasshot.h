//
//  AgoraVideoSnasshot.h
//  AgoraExtension
//
//  Created by klc_sl on 2021/1/11.
//  Copyright © 2021 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface AgoraVideoSnasshot : NSObject


@property (nonatomic, copy)void(^snasshotBlock)(UIImage *image);

- (instancetype)initWithSnasshotForSecond:(int)second;

///开始监控
- (void)startMonitoring:(AgoraRtcEngineKit *)engineKit;


- (void)stopMonitoring;


@end

NS_ASSUME_NONNULL_END
