//
//  HomeLiveShoppingHeader.h
//  HomePage
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HomeLiveShoppingHeader,ShopLiveAnnouncementDetailDTOModel;
@protocol HomeLiveShoppingHeaderDelegate <NSObject>
@optional
- (void)HomeLiveShoppingHeader:(HomeLiveShoppingHeader *)header itemClick:(ShopLiveAnnouncementDetailDTOModel *)model;

@end
@interface HomeLiveShoppingHeader : UICollectionReusableView

@property (nonatomic, copy)NSArray<ShopLiveAnnouncementDetailDTOModel *> *arr;

@property (nonatomic, weak)id<HomeLiveShoppingHeaderDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
