//
//  SelectLocationNearByView.h
//  LibProjView
//
//  Created by klc_sl on 2021/7/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class LocationInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationNearByView : UIView

@property (nonatomic, assign)CLLocationCoordinate2D currentCC2d;

@property (nonatomic, copy)void(^selectLocationBlock)(LocationInfoModel *selectLocation);

- (void)searchLocation:(CLLocationCoordinate2D)cc2d;



@end

NS_ASSUME_NONNULL_END
