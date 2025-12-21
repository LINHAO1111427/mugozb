//
//  VoiceRecord.h
//  LibProjBase
//
//  Created by klc_sl on 2021/4/5.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VoiceRecord;

@protocol VoiceRecordDelegate <NSObject>
@optional

///音频权限
- (void)voiceRecord:(VoiceRecord *)record audioAuthState:(AVAuthorizationStatus)status;
///录制时长
- (void)voiceRecord:(VoiceRecord *)record didRecoringTime:(NSTimeInterval)time;


@end

@interface VoiceRecord : NSObject


/** 录音对象 */
@property (nonatomic, strong) AVAudioRecorder *recorder;

/** 更新音量参数的代理 */
@property (nonatomic, assign) id<VoiceRecordDelegate> delegate;

///录制的音频文件地址
@property (nonatomic, copy) NSString *recordPath;

@property (nonatomic, assign)NSInteger minTime;
@property (nonatomic, assign)NSInteger maxTime;

/** 开始录音 */
- (void)startRecording;
/** 停止录音 */
- (void)stopRecording;
- (void)stopRecording:(void(^_Nullable)(NSTimeInterval recordTime, NSString *recordPath))recordBlock;

/** 播放录音文件 */
- (void)playRecording:(NSString *)playUrl complete:(void(^)(void))complete;
/** 停止播放录音文件 */
- (void)stopPlaying;
/** 暂停播放录音文件 */
- (void)pausePlaying;
/** 继续播放录音文件 */
- (void)resumePlaying;

///销毁
-(void)destruction;



@end

NS_ASSUME_NONNULL_END
