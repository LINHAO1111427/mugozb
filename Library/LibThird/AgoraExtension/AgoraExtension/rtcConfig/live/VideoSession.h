//
//  VideoSession.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoSession : NSObject

@property (assign, nonatomic) NSUInteger uid;
@property (weak, nonatomic) UIView *hostingView;
@property (strong, nonatomic) AgoraRtcVideoCanvas *canvas;

- (instancetype)initWithUid:(NSUInteger)uid AndHostingView:(UIView *)hostingView;

@end

NS_ASSUME_NONNULL_END
