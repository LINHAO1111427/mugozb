//
//  HostOrderListHeaderView.h
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopUserOrderDTOModel.h>

@class HostOrderListHeaderView;
NS_ASSUME_NONNULL_BEGIN

@protocol HostOrderListHeaderViewDelegate <NSObject>
@optional
- (void)HostOrderListHeaderView:(HostOrderListHeaderView *)header shopBtnClickWith:(ShopUserOrderDTOModel *)shopModel;
@end
@interface HostOrderListHeaderView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(OrderType)type;
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, strong)ShopUserOrderDTOModel *shopModel;
@property (nonatomic, weak)id<HostOrderListHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
