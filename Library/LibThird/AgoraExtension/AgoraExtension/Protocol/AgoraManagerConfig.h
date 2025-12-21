//
//  AgoraExtensionConfig.h
//  AgoraExtension
//
//  Created by shirley on 2020/4/17.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraExtension/LiveBeautyProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AgoraManagerConfig <NSObject>

///用户ID
+ (int64_t)getUserId;

///直播的key
+ (NSString *)getLiveKey;

///获得cdn的key
+ (NSString *)getCDNLiveKey;

///美颜开关
+ (int)getBeautySwitch;

///获得美颜等级
+ (int)getImageQualityNum;

///获取美颜文件
+ (Class<LiveBeautyProtocol>)getBeautyObj;


@end

NS_ASSUME_NONNULL_END
