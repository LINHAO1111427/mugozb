//
//  OrderStatusHeader.h
//  Shopping
//
//  Created by yww on 2020/11/12.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopUserOrderDetailDTOModel;

@interface OrderStatusHeader : UIView
@property (nonatomic, assign)int type;
@property (nonatomic, assign)BOOL isQuiterOrder;
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *detailModel;

- (void)stopTimer;

@end
 
NS_ASSUME_NONNULL_END
