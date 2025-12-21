//
//  AgoraO2OVideo.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/11.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraBase.h>
#import <O2OVideoProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraO2OVideo : AgoraBase<O2OVideoProtocol>

+ (instancetype)registerObj;

@end

NS_ASSUME_NONNULL_END
