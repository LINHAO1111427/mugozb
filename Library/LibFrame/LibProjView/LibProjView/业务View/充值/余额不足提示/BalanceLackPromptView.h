//
//  BalanceLackPromptView.h
//  LibProjView
//
//  Created by klc_sl on 2020/11/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BalanceLackPromptView : UIView

+ (void)gotoRecharge:(void(^_Nullable)(BOOL go))block;

@end

NS_ASSUME_NONNULL_END
