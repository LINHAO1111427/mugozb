//
//  AudioMicSeatView.h
//  MPAudioLive
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveManager.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUsersVoiceAssistanModel;
@class PkUserVoiceAssistanModel;

@interface AudioMicSeatView : UIView

- (void)setNormalSeatData:(NSArray <ApiUsersVoiceAssistanModel *> *)normalData;

///设置pk中的状态
- (void)setPKOwnData:(NSArray <PkUserVoiceAssistanModel *> *)ownModel otherData:(NSArray <PkUserVoiceAssistanModel *> *)otherModel;

///用户说话
- (void)userSpeaking:(NSInteger)volume uid:(int64_t)uid;


//麦位表情
- (void)addEmojiPicture:(NSString *)emojiCode withIndex:(NSInteger)index;


///改变PK中麦位状态
- (void)changePKViewFrame:(CGRect)frame showType:(LiveInfo_PKType)cellType;


///改变房间PK准备样式
- (void)changeRoomPerparePKFrame:(CGRect)frame ;


@end

NS_ASSUME_NONNULL_END
