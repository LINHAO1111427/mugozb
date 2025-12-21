//
//  CommodityBuyNumView.h
//  LibProjView
//
//  Created by KLC on 2020/7/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^callBack)(int num);
@interface CommodityBuyNumView : UIView
@property (nonatomic, assign)int num;
@property (nonatomic, copy)callBack callBack;
@end

NS_ASSUME_NONNULL_END
