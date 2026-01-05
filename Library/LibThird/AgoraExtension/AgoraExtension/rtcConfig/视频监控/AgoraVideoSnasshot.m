//
//  AgoraVideoSnasshot.m
//  AgoraExtension
//
//  Created by klc_sl on 2021/1/11.
//  Copyright © 2021 XTY. All rights reserved.
//

#import "AgoraVideoSnasshot.h"

@interface AgoraVideoSnasshot ()

@property (nonatomic, assign) int second;

@end

@implementation AgoraVideoSnasshot

- (void)dealloc {
    [self stopMonitoring];
}

- (instancetype)initWithSnasshotForSecond:(int)second {
    self = [super init];
    if (self) {
        _second = second;
    }
    return self;
}

- (void)startMonitoring:(ByteRTCEngineKit *)engineKit {
    if (_second <= 0) {
        return;
    }
    // ByteRTC snapshot is not wired; keep as no-op to avoid Agora dependencies.
}

- (void)stopMonitoring {
}

@end
