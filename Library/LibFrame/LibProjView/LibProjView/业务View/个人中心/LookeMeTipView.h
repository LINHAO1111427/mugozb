//
//  LookeMeTipView.h
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^LookeMeTipViewCallBack)(BOOL isClose);
@interface LookeMeTipView : UIView
+ (void)showLookeMeTipViewCallBack:(LookeMeTipViewCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
