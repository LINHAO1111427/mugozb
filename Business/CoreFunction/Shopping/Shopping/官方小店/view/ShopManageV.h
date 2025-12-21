//
//  ShopManageV.h
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShopManageVDelegate <NSObject>
@optional
- (void)shopManageVFunctionBtnClick:(NSInteger)index;
@end
@interface ShopManageV : UIView

@property(nonatomic,weak)id<ShopManageVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
