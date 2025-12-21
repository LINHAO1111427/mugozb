//
//  FansGroupShowView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/25.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FansGroupShowView : UIView

+ (void)showFansWith:(int64_t)userId hasBgColor:(BOOL)haBgColor showUserInfo:(void(^)(int64_t userId))userBack;

@end

NS_ASSUME_NONNULL_END
