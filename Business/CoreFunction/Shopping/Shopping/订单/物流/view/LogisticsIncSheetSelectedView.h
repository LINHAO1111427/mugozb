//
//  LogisticsIncSheetSelectedView.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopLogisticsDTOModel;
NS_ASSUME_NONNULL_BEGIN
typedef void(^LogisticsCallBack)(BOOL isSelected,NSInteger index);
@interface LogisticsIncSheetSelectedView : UIView
+ (void)showInSuperV:(UIView*)superV logisticsModel:(ShopLogisticsDTOModel*)model callBack:(LogisticsCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
