//
//  OpenRedPacketView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class OneRedPacketVOModel;
@interface OpenRedPacketView : UIView

/// openHandle 0:未领取 1:领到了(表示本次打开红包) 2:已经领过了 3:红包领取完了 4：红包过期了
+ (void)showRedPicket:(OneRedPacketVOModel *)voModel openType:(int)openType openHandle:(void(^_Nullable)(int isReceive))openHandle;



@end

NS_ASSUME_NONNULL_END
