//
//  TXMapManager.m
//  LibProjBase
//
//  Created by ssssssss on 2020/1/13.
//  Copyright © 2020 . All rights reserved.
//

#import "TXMapManager.h"
#import <TencentLBS/TencentLBS.h>
#import <QMapKit/QMapKit.h>
#import <LibProjBase/HttpClient.h>
#define kLocalizationMsg(key) NSLocalizedString(key, nil)

static TXMapManager *_singleInstance = nil;
@interface TXMapManager()<TencentLBSLocationManagerDelegate>
@property(nonatomic,strong)TencentLBSLocationManager *manager;
@end
@implementation TXMapManager

- (TencentLBSLocationManager *)manager{
    if (!_manager) {
        _manager = [[TencentLBSLocationManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_singleInstance == nil) {
            _singleInstance = [[self alloc]init];
        }
    });
    return _singleInstance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance = [super allocWithZone:zone];
    });
    return _singleInstance;
}

-(id)copyWithZone:(NSZone *)zone{
    return _singleInstance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return _singleInstance;
}

- (void)initWithApiKey:(NSString *)key{
    [self.manager setApiKey:key];
    [QMapServices sharedServices].APIKey = key;
    
    self.appkey = key;
    //权限
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.manager requestWhenInUseAuthorization];
    }
}

// 单次定位
- (void)startSingleLocation:(void (^)(BOOL, LocationInfoModel * _Nullable))locationResult {
    [self.manager requestLocationWithCompletionBlock:^(TencentLBSLocation *location, NSError *error) {
        if (error) {
            if (locationResult) {
                locationResult(NO, nil);
            }
        }else{
            NSString *city = location.city;
            LocationInfoModel *infoModel = [[LocationInfoModel alloc] init];
            if ([city hasSuffix:kLocalizationMsg(@"市")]) {
                city =[city substringToIndex:city.length-1];
            }
            infoModel.city = city;
            infoModel.coordinate = location.location.coordinate;
            infoModel.province = location.province;
            infoModel.address = location.address;
            infoModel.name = location.name;
            if (locationResult) {
                locationResult(YES, infoModel);
            }
        }
    }];
}
/**
 地理编码
 */
- (void)klcGeocoderWith:(NSString *)address completeResult:(CLGeocodeCompleteResult)result{
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    NSString *addressStr = address;
    [geocoder geocodeAddressString:addressStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        result(NO,nil);
    }];
    
}
/**
 地理反编码
 */
- (void)ReverseGeocoderWith:(CLLocationCoordinate2D)coordinate completeResult:(CLGeocodeCompleteResult)result{
    NSString *url = [NSString stringWithFormat:@"https://apis.map.qq.com/ws/geocoder/v1/?location=%f,%f&key=%@",coordinate.latitude,coordinate.longitude,self.appkey];
    [HttpClient requestGETWithPath:url Param:nil success:^(id  _Nonnull dataBody) {
        // NSLog(@"过滤文字dataBdy == %@"),dataBody);
        NSDictionary *resultDic = dataBody[@"result"];
        //城市
        NSDictionary *ad_infoDic = resultDic[@"ad_info"];
        //地标
        NSDictionary *address_referenceDic = resultDic[@"address_reference"];
        NSDictionary *landmark_l2Dic = address_referenceDic[@"landmark_l2"];

        LocationInfoModel *infoModel = [[LocationInfoModel alloc] init];
        infoModel.city = ad_infoDic[@"city"];
        infoModel.coordinate = coordinate;
        infoModel.province = ad_infoDic[@"province"];
        infoModel.address = resultDic[@"address"];
        infoModel.name = landmark_l2Dic[@"title"];
        
        if (result) {
            result(YES, infoModel);
        }
    } failed:^(NSString * _Nonnull error) {
        if (result) {
            result(NO, nil);
        }
    }];
}
@end
 


