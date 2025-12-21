//
//  GiftListShowView.h
//  MPVideoLive
//
//  Created by admin on 2019/8/5.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryListContainerView.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiNobLiveGiftModel;
@class NobLiveGiftModel;
@class GiftListShowView;

@protocol GiftListShowViewDelegate  <NSObject>

- (void)giftListView:(GiftListShowView *)listView selectGift:(NobLiveGiftModel *_Nullable)gift giftType:(int)giftType;

@end


@interface GiftListShowView : UIView <JXCategoryListContentViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame defaultGiftId:(int64_t)giftId;

///某一类型的所有礼物
@property (nonatomic, strong)ApiNobLiveGiftModel *giftListModel;
///是否为选择心愿单（如果是就不显示限制）
@property (nonatomic, assign)BOOL selectWish;

@property (nonatomic, weak)id<GiftListShowViewDelegate> delegate;

@property (nonatomic, assign)int64_t anchorId;


//清理数据
- (void)clearData;

///刷新背包数据
- (void)reloadPackData;

@end

NS_ASSUME_NONNULL_END
 
