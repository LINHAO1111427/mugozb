//
//  TimeCountDownView.h
//  TCDemo
//
//  Created by admin on 2019/9/27.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeCountDownView : UIView

+ (void)showInView:(UIView *)superV times:(int)times complete:(void (^)(void))complete;
- (void)removeAnimationNow;
@end

NS_ASSUME_NONNULL_END
