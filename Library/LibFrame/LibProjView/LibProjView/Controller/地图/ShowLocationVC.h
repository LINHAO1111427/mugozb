//
//  ShowLocationVC.h
//  LibProjView
//
//  Created by klc_sl on 2021/7/15.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowLocationVC : UIViewController

///显示具体坐标
@property (nonatomic, assign)double lat;
@property (nonatomic, assign)double lng;

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *address;

@end

NS_ASSUME_NONNULL_END
