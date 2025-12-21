//
//  HostOrderListVC.h
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostOrderListVC : UIViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, assign)HostOrderStatus status;
///商户还是用户
@property (nonatomic, assign)OrderType type;

@property (nonatomic, copy)void(^reloadNumBlick)(void);

@end

NS_ASSUME_NONNULL_END
