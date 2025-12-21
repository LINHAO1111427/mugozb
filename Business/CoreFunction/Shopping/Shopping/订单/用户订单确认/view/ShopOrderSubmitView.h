//
//  ShopOrderSubmitView.h
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShopOrderSubmitViewDelegate <NSObject>
@optional
- (void)ShopOrderSubmitViewSubmitBtnClick;

@end
@interface ShopOrderSubmitView : UIView

@property (nonatomic, weak)id<ShopOrderSubmitViewDelegate> delegate;
@property (nonatomic, strong)NSArray *dataArr;
@end

NS_ASSUME_NONNULL_END
