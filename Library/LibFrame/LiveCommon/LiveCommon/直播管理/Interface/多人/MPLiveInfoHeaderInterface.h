//
//  MPLiveInfoHeaderInterface.h
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class ApiUserBasicInfoModel;
@class ApiUsersLiveWishModel;
@class GuardUserVOModel;

NS_ASSUME_NONNULL_BEGIN

@protocol MPLiveInfoHeaderInterface <NSObject>

+ (instancetype)register;


- (void)attentionAnchor:(BOOL)isAtten;

/// 刷新房间数据
- (void)reloadRoomData;

///更新房间人数
- (void)reloadAudienceNumber:(NSArray<ApiUserBasicInfoModel *> *)audienceListModel userWatchNumber:(int)userWatchNumber;

///更新主播的魅力值
- (void)updateAnchorVotesNumber:(double)coin;

///更新房间的魅力值
- (void)updateRoomVotesNumber:(double)coin;

///更新主播心愿单
- (void)reloadAnchorWishList:(NSArray<ApiUsersLiveWishModel *> *)wishList;

///更新守护人
- (void)reloadGuardUserList:(NSArray<GuardUserVOModel *> *)guardList;

///更新贵宾席
- (void)reloadVipSeat:(NSDictionary *)vipSeatDic;

@end

NS_ASSUME_NONNULL_END
