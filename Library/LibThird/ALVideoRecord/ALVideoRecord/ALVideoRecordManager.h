//
//  ALVideoRecordManager.h
//  ALVideoRecord
//
//  Created by swh_y on 2022/6/22.
//

#import <Foundation/Foundation.h>
 
NS_ASSUME_NONNULL_BEGIN

@class AliyunVideoCropParam;
@class AliyunVideoRecordParam;
@interface ALVideoRecordManager : NSObject<NSCopying,NSMutableCopying>

/// 单例对象
+ (instancetype)share;


/// 初始化sdk
- (void)registerAliRecordSdk;

///录制配置
- (AliyunVideoRecordParam *)getRecordConfig;

///裁剪配置
- (AliyunVideoCropParam *)getCropConfig;
@end

NS_ASSUME_NONNULL_END
