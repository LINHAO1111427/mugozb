//
//  SelectLocationInputView.h
//  LibProjView
//
//  Created by klc_sl on 2021/7/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class LocationInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationInputView : UIView

@property (nonatomic, copy)NSString *selectCity;

@property (nonatomic, copy)void(^selectLocationBlock)(LocationInfoModel *selectLocation);

@end

NS_ASSUME_NONNULL_END
