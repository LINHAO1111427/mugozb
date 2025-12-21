//
//  HostOrderListFootView.h
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopUserOrderDTOModel.h>
NS_ASSUME_NONNULL_BEGIN
@class HostOrderListFootView;
@protocol HostOrderListFootViewDelegate <NSObject>
@optional
- (void)HostOrderListFootView:(HostOrderListFootView *)footer withModel:(ShopUserOrderDTOModel *)model index:(NSInteger)index;

@end
@interface HostOrderListFootView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(OrderType)type;
@property (nonatomic, strong)ShopUserOrderDTOModel *shopModel;
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, weak)id<HostOrderListFootViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
