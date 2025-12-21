//
//  WishShowFlowView.h
//  LiveCommon
//
//  Created by admin on 2020/1/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUsersLiveWishModel;

@interface WishShowFlowView : UIView


@property (nonatomic, copy) NSArray<ApiUsersLiveWishModel *> *wishList;

@property (nonatomic, copy) void(^reloadDataBlock)(NSArray *wishList);


- (void)loadWishList:(int64_t)userId;

- (void)loadWishList:(int64_t)userId block:(void(^)(BOOL success))block;

@end

NS_ASSUME_NONNULL_END
