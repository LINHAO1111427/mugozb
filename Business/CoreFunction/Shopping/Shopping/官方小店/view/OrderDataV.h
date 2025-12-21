//
//  OrderDataV.h
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopBusinessOrderInfoDTOModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OrderDataVDelegate <NSObject>
@optional
- (void)OrderDataVFunctionBtnClick:(NSInteger)index;
- (void)OrderDataVTimeSelected:(NSInteger)index;
@end
@interface OrderDataV : UIView
@property (nonatomic, strong)ShopBusinessOrderInfoDTOModel *model;
@property(nonatomic,weak)id<OrderDataVDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
