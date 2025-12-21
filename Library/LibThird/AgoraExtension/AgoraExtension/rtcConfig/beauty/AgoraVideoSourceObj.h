//
//  AgoraVideoSourceObj.h
//  AgoraExtension
//
//  Created by klc_sl on 2020/9/17.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraVideoSourceObj : NSObject<AgoraVideoSourceProtocol>


- (void)switchCamera:(void(^)(BOOL isFront))positionBlock;


@end

NS_ASSUME_NONNULL_END
