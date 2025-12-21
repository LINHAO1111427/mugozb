//
//  ScreenFloatForRichManObj.h
//  LiveCommon
//
//  Created by ssssssss on 2020/8/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ApiSimpleMsgRoomModel;
@class AppJoinChatRoomMsgVOModel;

@interface ScreenfloatForRichmanJoinObj : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)playRichManJoinView:(ApiSimpleMsgRoomModel *)model;

- (void)playRichManJoinMsgView:(AppJoinChatRoomMsgVOModel *)model;

@end

NS_ASSUME_NONNULL_END
