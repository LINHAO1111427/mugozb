//
//  AgoraVideoSourceObj.h
//  AgoraExtension
//
//  Created by klc_sl on 2020/9/17.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraVideoSourceObj : NSObject

- (void)startCapture;
- (void)stopCapture;
- (void)switchCamera:(void(^)(BOOL isFront))positionBlock;

@end

NS_ASSUME_NONNULL_END
