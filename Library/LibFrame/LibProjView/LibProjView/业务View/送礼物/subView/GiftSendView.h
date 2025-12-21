//
//  GiftSendView.h
//  MPVideoLive
//
//  Created by admin on 2019/8/5.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface GiftSendView : UIView

@property (nonatomic, copy)void(^rechangeBtnClick)(BOOL isRechange);

@property (nonatomic, copy)void(^sendBtnClick)(int giftCount);


@property (nonatomic, assign)BOOL isContinue; ///是否可以连发


///选择某一个礼物
- (void)selectOneGift:(int)giftType;

///发送礼物的结果
- (void)sendGiftResult:(BOOL)success;


- (void)reShowPackTotalCoin:(double)totalCoin lastCoin:(double)lastCoin giftType:(int)giftType;

@end

NS_ASSUME_NONNULL_END
