//
//  AddWishView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUsersLiveWishModel;
@interface AddWishView : UIView


+ (void)addMineWishAndRoomId:(int64_t)roomId touid:(int64_t)touid hasCover:(BOOL)has Block:(void(^ __nullable)(NSArray<ApiUsersLiveWishModel *> *wishList))block;



+ (void)getMineWishBlock:(void(^)(NSArray<ApiUsersLiveWishModel *> *__nullable wishList))block;




@end

NS_ASSUME_NONNULL_END
