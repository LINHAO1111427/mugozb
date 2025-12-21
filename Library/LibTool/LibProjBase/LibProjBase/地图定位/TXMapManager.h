//
//  TXMapManager.h
//  LibProjBase
//
//  Created by ssssssss on 2020/1/13.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <LibProjBase/LocationInfoModel.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^CLGeocodeCompleteResult)(BOOL success, LocationInfoModel  *_Nullable infoModel);


@interface TXMapManager : NSObject

@property (nonatomic, copy) NSString *appkey;

+(instancetype)shareInstance;

///初始化
- (void)initWithApiKey:(NSString *)key;


///单次定位
- (void)startSingleLocation:(CLGeocodeCompleteResult)locationResult;

/// 地理编码
/// @param address 地址
/// @param result 编码结果
- (void)klcGeocoderWith:(NSString *)address completeResult:(CLGeocodeCompleteResult)result;

/// 反地理编码
/// @param coordinate 经纬度
/// @param result 地址结果
- (void)ReverseGeocoderWith:(CLLocationCoordinate2D)coordinate completeResult:(CLGeocodeCompleteResult)result;


@end


NS_ASSUME_NONNULL_END
