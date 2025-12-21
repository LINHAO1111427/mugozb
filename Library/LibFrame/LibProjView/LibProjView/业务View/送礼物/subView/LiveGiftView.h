//
//  LiveGiftView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class NobLiveGiftModel;
@class LiveGiftView;
@class ApiGiftSenderModel;

@protocol LiveGiftViewDelegate <NSObject>

///去充值按钮
- (void)giftView:(LiveGiftView *)giftView gotoRechange:(BOOL)go;

///发送礼物
- (void)giftView:(LiveGiftView *)giftView sendGift:(NobLiveGiftModel *)gift Count:(int)giftCount giftType:(int)type selUsers:(NSArray *)users;

///赠送所有礼物
- (void)sendAllPackGift:(LiveGiftView *)giftView selUsers:(NSArray *)users;


@end


@interface LiveGiftView : UIView


@property (nonatomic, weak)id<LiveGiftViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame anchorId:(int64_t)anchorId hasContinueSend:(BOOL)has canSelectUser:(BOOL)can defaultGift:(NobLiveGiftModel *_Nullable)giftModel;


- (void)sendGiftSuccess:(BOOL)success senderModel:(ApiGiftSenderModel *)senderModel;


- (void)reloadUserItem:(NSArray *)users;

@end

NS_ASSUME_NONNULL_END
