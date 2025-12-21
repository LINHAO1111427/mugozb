//
//  GameGlobalBannerView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GameUserWinAwardsDTOModel;
///坐骑
@interface GameGlobalBannerView : UIView

/// 设置视图的显示内容
- (void)showPrizeModel:(GameUserWinAwardsDTOModel *)model;

@end

NS_ASSUME_NONNULL_END
