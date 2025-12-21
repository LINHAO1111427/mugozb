//
//  FocusTextAdBanner.h
//  ShortVideo
//
//  Created by klc_sl on 2021/5/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FocusTextAdBanner : UIView


///显示广告文字
- (void)showAdText:(NSString *)adText;

///是否滚动
- (void)adBannerisScroll:(BOOL)scroll;


@end

NS_ASSUME_NONNULL_END
