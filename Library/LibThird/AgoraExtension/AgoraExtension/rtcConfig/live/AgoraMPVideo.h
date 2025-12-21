//
//  AgoraMPVideo.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraBase.h>
#import <MPVideoProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraMPVideo : AgoraBase<MPVideoProtocol>

+ (instancetype)registerObj;

@end

NS_ASSUME_NONNULL_END
