//
//  MPAudioMiniView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/7/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPAudioMiniView : UIView

///显示视图
+ (void)showAudioMiniView:(UIView *)subViews recover:(void (^)(void))recover;


@end

NS_ASSUME_NONNULL_END
