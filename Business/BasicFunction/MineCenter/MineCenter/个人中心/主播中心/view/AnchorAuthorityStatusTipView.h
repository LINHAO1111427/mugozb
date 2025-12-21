//
//  AnchorAuthorityStatusTipView.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AnchorAuthorityStatusTipView;
typedef  void (^AnchorAuthStatusTipCallBack)(BOOL isBtnClick,AnchorAuthorityStatusTipView *tipView);
@interface AnchorAuthorityStatusTipView : UIView
+ (void)showAnchorAuthStatusTipViewWith:(NSArray*)viewArray imageStr:(NSString *)imageStr callBack:(AnchorAuthStatusTipCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
