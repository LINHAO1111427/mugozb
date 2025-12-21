//
//  AllUserBannerView.h
//  LiveCommon
//
//  Created by kalacheng on 2020/9/2.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiSimpleMsgRoomModel;

@interface AllUserBannerView : UIView

/// 设置视图的显示内容
- (void)showAllUserModel:(ApiSimpleMsgRoomModel *)msgRoomModel;

@end

NS_ASSUME_NONNULL_END
