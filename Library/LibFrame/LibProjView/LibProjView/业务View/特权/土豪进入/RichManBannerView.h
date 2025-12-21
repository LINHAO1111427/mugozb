//
//  RichManBannerView.h
//  LiveCommon
//
//  Created by ssssssss on 2020/8/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiSimpleMsgRoomModel;
@class AppJoinChatRoomMsgVOModel;

@interface RichManBannerView : UIView

- (void)showRichModel:(ApiSimpleMsgRoomModel *)userMsg;

- (void)showRichForMsgModel:(AppJoinChatRoomMsgVOModel *)model;


@end

NS_ASSUME_NONNULL_END
