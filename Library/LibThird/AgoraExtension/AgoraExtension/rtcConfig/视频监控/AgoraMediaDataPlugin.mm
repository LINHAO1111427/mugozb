//
//  AgoraMediaRawData.mm
//  OpenVideoCall
//
//  Created by CavanSu on 26/02/2018.
//  Copyright © 2018 Agora. All rights reserved.
//

#import "AgoraMediaDataPlugin.h"

@implementation AgoraMediaDataPlugin

+ (instancetype)mediaDataPluginWithAgoraKit:(ByteRTCEngineKit *)agoraKit {
    return [[AgoraMediaDataPlugin alloc] init];
}

- (void)registerVideoRawDataObserver:(ObserverVideoType)observerType {
}

- (void)deregisterVideoRawDataObserver:(ObserverVideoType)observerType {
}

- (void)registerAudioRawDataObserver:(ObserverAudioType)observerType {
}

- (void)deregisterAudioRawDataObserver:(ObserverAudioType)observerType {
}

- (void)registerPacketRawDataObserver:(ObserverPacketType)observerType {
}

- (void)deregisterPacketRawDataObserver:(ObserverPacketType)observerType {
}

- (void)setVideoRawDataFormatter:(AgoraVideoRawDataFormatter *)formatter {
}

- (AgoraVideoRawDataFormatter *)getCurrentVideoRawDataFormatter {
    return [[AgoraVideoRawDataFormatter alloc] init];
}

- (void)localSnapshot:(void (^ _Nullable)(AGImage * _Nonnull image))completion {
}

- (void)remoteSnapshotWithUid:(NSUInteger)uid image:(void (^ _Nullable)(AGImage * _Nonnull image))completion {
}

@end
