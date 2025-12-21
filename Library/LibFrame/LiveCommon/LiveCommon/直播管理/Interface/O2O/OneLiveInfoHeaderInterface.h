//
//  OneLiveInfoHeaderInterface.h
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUsersLiveWishModel;
@protocol OneLiveInfoHeaderInterface <NSObject>


+ (instancetype)registerView;

///更新数据
- (void)reloadRoomData;

///更新金币数
- (void)updateDataCoin:(double)coin;

///更新主播的魅力值
- (void)updateGiftNumber:(double)coin;

///更新主播心愿单
- (void)updateAnchorWishList:(NSArray<ApiUsersLiveWishModel *> *)wishList;



@end

NS_ASSUME_NONNULL_END
