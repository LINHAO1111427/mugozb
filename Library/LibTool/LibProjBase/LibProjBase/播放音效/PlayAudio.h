//
//  PlayAudio.h
//  LibProjBase
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayAudio : UIView

//实例
+ (instancetype)share;


/*********************OTO******************/

//发起通话或对方邀请通话
- (void)callPlay;

//播放结束音效
- (void)cancelPlay;

///结束播放音乐
- (void)stopPlay;

///当前播放时间
- (int)playTime;

//开始震动
- (void)startAlertSound;

//结束震动
-(void)stopDisplayLink;

//匹配音效
- (void)matchingCallPlay;


/*********************背景空白音乐******************/

- (void)playBgMusic;

- (void)stopBgMusic;



/*********************Message******************/

///一次播放消息声音
- (void)callMSGPlay;

- (void)callMSGEndPlay;
///一次震动
- (void)callMsgShark;



@end

NS_ASSUME_NONNULL_END
