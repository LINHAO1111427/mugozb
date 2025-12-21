//
//  ChoiceGiftView.h
//  MPVideoLive
//
//  Created by admin on 2019/8/2.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/GiftUserModel.h>

NS_ASSUME_NONNULL_BEGIN

//观众选择礼物
@class NobLiveGiftModel;
@class ApiGiftSenderModel;

typedef void(^_Nullable SendGiftSuccess)(NSArray<ApiGiftSenderModel *> *giftModelList);

@interface ChoiceGiftView : UIView


/// 选择送礼+可选择送礼人
+ (void)showGift:(int)sendType users:(NSArray<GiftUserModel *> *)users hasContinue:(BOOL)has sendSuccess:(SendGiftSuccess)success;

///直接赠送某个礼物（不显示选择礼物选框）
+ (void)showGiftNoSelectAll:(int)sendType giftId:(int64_t)giftId users:(NSArray<GiftUserModel *> *)users sendSuccess:(SendGiftSuccess)success;

///选择送礼+不选择(不显示)送礼人
+ (void)showGiftNoSelectUser:(int)sendType users:(NSArray<GiftUserModel *> *)users hasContinue:(BOOL)has sendSuccess:(SendGiftSuccess)success;

///指定某一个类型的某一个礼物
+ (void)showGift:(int)sendType giftType:(int)giftType giftId:(int64_t)giftId users:(NSArray<GiftUserModel *> *)users hasContinue:(BOOL)has sendSuccess:(SendGiftSuccess)success;


@end

NS_ASSUME_NONNULL_END
