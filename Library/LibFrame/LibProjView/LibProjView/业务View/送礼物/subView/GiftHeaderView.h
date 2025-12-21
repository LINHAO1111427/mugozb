//
//  GiftHeaderView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GiftHeaderView;
@protocol GiftHeaderViewDelegate <NSObject>

- (void)giftHeader:(GiftHeaderView *)headerV selectUsers:(NSArray *)users;

@end

@class GiftUserModel;
@interface GiftHeaderView : UIView

@property (nonatomic, copy)NSArray<GiftUserModel *> *userItems;

@property (nonatomic, weak)id<GiftHeaderViewDelegate> delegate;


- (NSArray *)getSelectUsers;

@end

NS_ASSUME_NONNULL_END
