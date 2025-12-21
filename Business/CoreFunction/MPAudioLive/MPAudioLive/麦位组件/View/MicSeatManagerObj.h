//
//  MicSeatManagerObj.h
//  MPAudioLive
//
//  Created by klc on 2020/6/10.
//  Copyright © 2020 klc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ApiUsersVoiceAssistanModel;

NS_ASSUME_NONNULL_BEGIN


@interface MicSeatManagerObj : NSObject

- (void)clickMicSeat:(ApiUsersVoiceAssistanModel *)model;

///显示对方房间信息
- (void)showOtherRoomUserInfo:(ApiUsersVoiceAssistanModel *)model;

@end

NS_ASSUME_NONNULL_END
