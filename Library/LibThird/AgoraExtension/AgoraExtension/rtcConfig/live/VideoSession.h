//
//  VideoSession.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VolcEngineRTC/VolcEngineRTC.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoSession : NSObject

@property (assign, nonatomic) NSUInteger uid;
@property (weak, nonatomic) UIView *hostingView;
@property (strong, nonatomic) ByteRTCVideoCanvas *canvas;

- (instancetype)initWithUid:(NSUInteger)uid AndHostingView:(UIView *)hostingView;

@end

NS_ASSUME_NONNULL_END
