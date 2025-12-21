//
//  LiveTradePreviewFooterView.h
//  Shopping
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LiveTradePreviewFooterView;
@protocol LiveTradePreviewFooterViewDelegate <NSObject>
@optional
- (void)LiveTradePreviewFooterViewAddPreviewBtnClick:(LiveTradePreviewFooterView *)footerView;
@end
@interface LiveTradePreviewFooterView : UIView
@property (nonatomic, weak)id superVc;
@property (nonatomic, weak)id<LiveTradePreviewFooterViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
