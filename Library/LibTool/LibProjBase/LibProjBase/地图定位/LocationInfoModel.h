//
//  LocationInfoModel.h
//  LibProjBase
//
//  Created by klc_sl on 2021/7/13.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationInfoModel : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy)NSString *city; ///城市
@property (nonatomic, copy)NSString *address; ///行政地址
@property (nonatomic, copy)NSString *province; //省
@property (nonatomic, copy)NSString *name; //具体位置名称

@end

NS_ASSUME_NONNULL_END
