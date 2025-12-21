//
//  CoinInsufficientTipView.h
//  OneVideoLive
//
//  Created by CH on 2019/12/31.
//  Copyright © 2019 Orely. All rights reserved.
//
// 用户金币不足 结算 提示窗

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinInsufficientTipView : UIView

///剩余多少分钟
+ (void)showLastTime:(int)second;

@end

NS_ASSUME_NONNULL_END
