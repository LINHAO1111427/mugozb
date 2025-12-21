//
//  ShopMineAddAccountView.h
//  Shopping
//
//  Created by ssssssss on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopMineAddAccountView : UIView
@property (nonatomic,copy) void (^createSuccess)(void);

- (void)show;

@end

NS_ASSUME_NONNULL_END
