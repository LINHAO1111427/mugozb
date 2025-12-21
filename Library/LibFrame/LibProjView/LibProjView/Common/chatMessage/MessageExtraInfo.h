//
//  MessageExtraInfo.h
//  LibProjView
//
//  Created by klc_sl on 2021/9/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//
//typedef NS_ENUM(NSUInteger, IMessageFailType) {
//    
//    ///家族已经解散
//    IMMessageFailForFamilyDissolve   = 404,
//    ///已被踢出家族
//    IMMessageFailForFamilyKicked     = 405,
//    ///发送已被禁言
//    IMMessageFailForSilenced         = 701,
//    ///发送语音消息检测中
//    IMMessageFailForVoiceCheck       = 998,
//};

@interface MessageExtraInfo : NSObject


///发送消息失败的状态和提示文字
@property (nonatomic, assign) int failType;   ///失败类型
@property (nonatomic, assign) int failReason; ///失败提示文字
@property (nonatomic, assign)BOOL msgNotSend; ///失败消息是否可再次发送


///红包未读已读
@property (nonatomic, assign)int redPtStatus;


@end

NS_ASSUME_NONNULL_END
