//
//  AgoraMPAudio.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraBase.h>
#import <MPAudioProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraMPAudio : AgoraBase<MPAudioProtocol>

+ (instancetype)registerObj;

@end

NS_ASSUME_NONNULL_END
