//
//  LiveUserInfoView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/26.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveUserInfoView : UIView

+ (void)showUserInfo:(int64_t)userId outLiveRoom:(BOOL)outLiveRoom;

///显示其他房间的用户信息
+ (void)showOtherRoomUserInfo:(int64_t)uid roomId:(int64_t)roomId showId:(NSString *)showId;


@end

NS_ASSUME_NONNULL_END
