//
//  PlatformBanTreatyView.h
//  LibProjView
//
//  Created by klc_sl on 2021/4/7.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlatformBanTreatyView : UIView

+ (void)showTreaty:(void(^)(void))agreeBlock;

@end

NS_ASSUME_NONNULL_END
