//
//  RoomAudienceFlowShowView.h
//  LiveCommon
//
//  Created by admin on 2020/1/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUserBasicInfoModel;

@interface RoomAudienceFlowShowView : UIView

- (void)showUserInfo:(NSArray<ApiUserBasicInfoModel *> *)listModel userWatchNumber:(int)userWatchNumber;

@end

NS_ASSUME_NONNULL_END
