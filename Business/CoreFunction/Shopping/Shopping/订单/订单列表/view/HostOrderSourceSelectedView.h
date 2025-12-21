//
//  HostOrderMoreSelectedView.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HostOrderSourceSelectedView;
NS_ASSUME_NONNULL_BEGIN
typedef void(^OrderMoreSelectedBlock)(BOOL success,NSInteger clickIndex,HostOrderSourceSelectedView *moreView);
@interface HostOrderSourceSelectedView : UIView
+ (void)showInSuperView:(UIView *)superV callBack:(OrderMoreSelectedBlock)callBack;
@end

NS_ASSUME_NONNULL_END
