//
//  ShowGiftAnimationView.h
//  LibProjView
//
//  Created by klc_sl on 2021/6/3.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiGiftSenderModel;
@interface ShowGiftAnimationView : UIView

@property (nonatomic, weak)UIView *bannerSuperV;

///显示礼物飘飘屏
- (void)showGiftBanner:(ApiGiftSenderModel *)giftInfo;

///只显示动画效果
- (void)playAnimationEffect:(ApiGiftSenderModel *)giftInfo;

@end

NS_ASSUME_NONNULL_END
