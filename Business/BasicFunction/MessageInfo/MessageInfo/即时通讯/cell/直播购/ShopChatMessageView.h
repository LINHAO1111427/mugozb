//
//  CoversationShopChatView.h
//  Message
//
//  Created by ssssssss on 2020/11/19.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define shopViewWidth (kScreenWidth*487/750.0 + 30)

@class ShopMessageModel;

@protocol ShopChatMessageViewDeleagte <NSObject>
@optional
- (void)commodityDetailInfo:(ShopMessageModel *)model;

@end
@interface ShopChatMessageView : UIView


@property (nonatomic, weak)id<ShopChatMessageViewDeleagte> delegate;


- (void)showShopMessageInfo:(ShopMessageModel *)shopModel isOwner:(BOOL)isOwner;


+ (CGFloat)getViewHeight:(ShopMessageModel *)shopMsg isOwner:(BOOL)isOwner;


@end

NS_ASSUME_NONNULL_END
