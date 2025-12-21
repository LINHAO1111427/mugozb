//
//  OpenRedPacketResultView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class RedPacketVOModel;

@interface OpenRedPacketResultView : UIView

///抽奖显示的结果
- (void)showResult:(RedPacketVOModel *)voModel;



///要调用接口显示的结果
+ (void)showRedPtInfo:(int64_t)redPtID resultHandle:(void(^)(int isReceive))resultHandle;


@end

NS_ASSUME_NONNULL_END
