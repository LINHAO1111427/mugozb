//
//  LiveGoodsBannerView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UserBuyDTOModel;

@interface LiveGoodsBannerView : UIView

/// 设置视图的显示内容
- (void)showGoodsModel:(UserBuyDTOModel *)goods;

@end

NS_ASSUME_NONNULL_END
