//
//  LiveInViolationHintView.h
//  LibProjView
//
//  Created by ssssssss on 2020/11/9.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveInViolationHintView : UIView

+ (void)showForbidTipView:(NSString *)hint showTime:(int)time;

@end

NS_ASSUME_NONNULL_END
