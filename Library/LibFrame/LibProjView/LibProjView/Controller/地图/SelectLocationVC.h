//
//  SelectLocationVC.h
//  LibProjView
//
//  Created by klc_sl on 2021/7/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjBase/LocationInfoModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationVC : UIViewController

///显示哪一个城市
@property (nonatomic, copy)NSString *selectCity;


@property (nonatomic, copy)void(^sureLocationBlock)(LocationInfoModel *selectAddress);

@end

NS_ASSUME_NONNULL_END
