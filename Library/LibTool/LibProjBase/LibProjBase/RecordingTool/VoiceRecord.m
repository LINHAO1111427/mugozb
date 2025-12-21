//
//  VoiceRecord.m
//  LibProjBase
//
//  Created by klc_sl on 2021/4/5.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "VoiceRecord.h"

@interface VoiceRecord ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>

/** 播放器对象 */
@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, copy) NSString *recordFilePath;

@property (nonatomic, assign) NSInteger timeDu;
/** 定时器 */
@property (nonatomic, strong) NSTimer *updateVolumeTimer;


@property (nonatomic, copy)void (^completeBlock)(void);

@end

@implementation VoiceRecord

#pragma mark-  数据
-(NSTimer *)updateVolumeTimer{
    if (!_updateVolumeTimer) {
        _updateVolumeTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateVolume) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_updateVolumeTimer forMode:NSRunLoopCommonModes];
        [_updateVolumeTimer fire];
    }
    return _updateVolumeTimer;
}

- (void)updateVolume {
    [self.recorder updateMeters];
    if ([_delegate respondsToSelector:@selector(voiceRecord:didRecoringTime:)]) {
       // NSLog(@"过滤文字%0.3lf"),_recorder.currentTime);
        [_delegate voiceRecord:self didRecoringTime:_recorder.currentTime];
    }
}

///录制地址
- (NSString *)recordFilePath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:@"voiceRecord.caf"];
}

#pragma mark-  播放
- (void)playRecording:(NSString *)playUrl complete:(void (^)(void))complete{
    //*********** 播放时停止录音 ***********
    [self.recorder stop];
    /*****复位定时器******/
    [self resumeTimer];
    //*********** 正在播放就返回 ***********
    if ([self.player isPlaying]) return;
    /*****播放录音******/
    _completeBlock = complete;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:playUrl] error:NULL];
    self.player.delegate = self;
    self.player.enableRate = YES;
    [self.player prepareToPlay];
    [self.player play];
}

- (void)stopPlaying {
    _completeBlock = nil;
    [self.player stop];
}

- (void)pausePlaying {
    [self pauseTimer];
    [self.player pause];
}

- (void)resumePlaying{
    [self resumeTimer];
    self.player.currentTime = self.player.currentTime;
    [self.player play];
}

#pragma mark-  录音

- (BOOL)canRecord{
    __block BOOL bCanRecord = YES;
    __block AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (audioAuthStatus == AVAuthorizationStatusNotDetermined) {// 未询问用户是否授权
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                    audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(voiceRecord:audioAuthState:)]) {
                        [self.delegate voiceRecord:self audioAuthState:audioAuthStatus];
                    }
                }
            }];
        }
    } else if(audioAuthStatus == AVAuthorizationStatusRestricted || audioAuthStatus == AVAuthorizationStatusDenied) {
        // 未授权
        if (self.delegate && [self.delegate respondsToSelector:@selector(voiceRecord:audioAuthState:)]) {
            [self.delegate voiceRecord:self audioAuthState:audioAuthStatus];
        }
        bCanRecord = NO;
    }
    return bCanRecord;
}

/** 开始录音 */
- (void)startRecording{
        
    if (![self canRecord]) {
        return;
    }
    
    _recordPath = nil;
    
    /*******录音时停止播放 删除曾经生成的文件*********/
    [self stopPlaying];
    [self destructionRecordingFile:_recordFilePath];

    /*******定时器开始*********/

//    /*******如果不设置录音会话，播放录音的声音会很小*********/
    NSError*errorSession =nil;
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];//得到AVAudioSession单例对象
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &errorSession];//设置类别,表示该应用同时支持播放和录音
    [audioSession setActive:YES error: &errorSession];//启动音频会话管理,此时会阻断后台音乐的播放.
    
    if (self.maxTime > 0) {
        [self.recorder recordForDuration:self.maxTime];
    }
    [self.recorder record];
    
    [self resumeTimer];
    
}
/** 停止录音 */
- (void)stopRecording{
    [self stopRecording:nil];
}

- (void)stopRecording:(void (^)(NSTimeInterval, NSString * _Nonnull))recordBlock{
    
    if ([self.recorder isRecording]) {
        /*****暂停获取录音时间******/
        [self.recorder pause];
        /*****暂停计时器******/
        [self invalidateTimer];
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (self.recorder.currentTime >= self.minTime) {
            [self convetM4a:self.recorder.currentTime recordBlock:recordBlock];
        }
        /*****停止录音******/
        [self.recorder stop];
    }
}


- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        //***********获取沙盒地址***********
        
        self.recordFilePath = [self recordFilePath];
        //********设置录音的一些参数*********
        NSMutableDictionary *recordSettings = [NSMutableDictionary dictionary];
        //***********音频格式***********
        recordSettings[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
        //          setting[AVFormatIDKey] = @(kAudioFormatMPEGLayer3);
        //*****录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）****
        //        setting[AVSampleRateKey] = @(96000);
        //        setting[AVSampleRateKey] = @(22150);
        recordSettings[AVSampleRateKey] = @(44100.0f);
        //***********音频通道数 1 或 2***********
        //        setting[AVNumberOfChannelsKey] = @(1);
        recordSettings[AVNumberOfChannelsKey] = @(2);
        //***********线性音频的位深度  8、16、24、32***********
        //        setting[AVLinearPCMBitDepthKey] = @(8);
        recordSettings[AVLinearPCMBitDepthKey] = @(16);
        //***********录音的质量***********
        recordSettings[AVEncoderAudioQualityKey] = [NSNumber numberWithInt:AVAudioQualityHigh];
        
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.recordFilePath] settings:recordSettings error:NULL];
        _recorder.delegate = self;
        _recorder.meteringEnabled = YES;
        
        [_recorder prepareToRecord];
    }
    return _recorder;
}

///销毁录音文件
- (BOOL)destructionRecordingFile:(NSString *)path {
    if (path.length>0) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL success = [fileManager removeItemAtURL:[NSURL URLWithString:path] error:NULL];
        if (success) {
           // NSLog(@"过滤文字录音文件销毁成功"));
        }else{
           // NSLog(@"过滤文字录音文件销毁失败"));
        }
        return success;
    }
    return NO;
}

- (void)destruction{
    [self destructionRecordingFile:_recordPath];
    _recorder = nil;
    _recordPath = nil;
}


#pragma mark-  AVAudioRecorderDelegate
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag) {
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
    }
}

#pragma mark-  AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        /******播放成功，暂停定时器******/
        [self pauseTimer];
        if (_completeBlock){
            _completeBlock();
        }
    }
}

#pragma mark-  定时器
-(void)invalidateTimer{
    [self.updateVolumeTimer invalidate];
    self.updateVolumeTimer = nil;
}
-(void)pauseTimer{
    if (!self.updateVolumeTimer.isValid) {
        return;
    }
    [self.updateVolumeTimer setFireDate:[NSDate distantFuture]];
}
-(void)resumeTimer{
    if (!self.updateVolumeTimer.isValid) {
        return;
    }
    [self.updateVolumeTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}


#pragma mark-  音频转换
- (void)convetM4a:(NSTimeInterval)totaltime recordBlock:(void (^)(NSTimeInterval, NSString * _Nonnull))recordBlock{
    
    NSString *nowTime = [self getNowTimeTimestamp];
    NSString *fileName = [NSString stringWithFormat:@"/%@.m4a", nowTime];
    NSString *filePath = [[NSHomeDirectory() stringByAppendingFormat:@"/Documents/"] stringByAppendingPathComponent:fileName];
    
    __weak typeof(self) weakSelf = self;
    
    [self convetCafToM4a:_recordFilePath destUrl:filePath completed:^(NSError *error) {
        weakSelf.recordPath = filePath;
        if (recordBlock) {
            recordBlock(totaltime, filePath);
        }
    }];
    
}


/**
 把.caf转为.m4a格式
 @param cafUrlStr .m4a文件路径
 @param m4aUrlStr .caf文件路径
 @param completed 转化完成的block
 */
- (void)convetCafToM4a:(NSString *)cafUrlStr
               destUrl:(NSString *)m4aUrlStr
             completed:(void (^)(NSError *error)) completed {
    
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    //  音频插入的开始时间
    CMTime beginTime = kCMTimeZero;
    //  获取音频合并音轨
    AVMutableCompositionTrack *compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    //  用于记录错误的对象
    NSError *error = nil;
    //  音频原文件资源
    AVURLAsset *cafAsset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:cafUrlStr] options:nil];
    //  原音频需要合并的音频文件的区间
    CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, cafAsset.duration);
    
    NSArray<AVAssetTrack *> *assetArr = [cafAsset tracksWithMediaType:AVMediaTypeAudio];
    if (assetArr.count == 0) {
       // NSLog(@"过滤文字没有音频文件"));
    }else{
        BOOL success = [compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[cafAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:beginTime error:&error];
        if (!success) {
           // NSLog(@"过滤文字插入原音频失败: %@"),error);
        }else {
           // NSLog(@"过滤文字插入原音频成功"));
        }
    }
    
    // 创建一个导入M4A格式的音频的导出对象
    AVAssetExportSession* assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetAppleM4A];
    // 导入音视频的URL
    assetExport.outputURL = [NSURL fileURLWithPath:m4aUrlStr];
    // 导出音视频的文件格式
    assetExport.outputFileType = @"com.apple.m4a-audio";
    [assetExport exportAsynchronouslyWithCompletionHandler:^{
        // 分发到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            AVAssetExportSessionStatus exportStatus = assetExport.status;
            if (exportStatus == AVAssetExportSessionStatusCompleted) {
                // 合成成功
                completed(nil);
                NSError *removeError = nil;
                if([cafUrlStr hasSuffix:@"caf"]) {
                    // 删除老录音caf文件
                    if ([[NSFileManager defaultManager] fileExistsAtPath:cafUrlStr]) {
                        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:cafUrlStr error:&removeError];
                        if (!success) {
                           // NSLog(@"过滤文字删除老录音caf文件失败:%@"),removeError);
                        }else{
                           // NSLog(@"过滤文字删除老录音caf文件:%@成功"),cafUrlStr);
                        }
                    }
                }
                
            }else {
                completed(assetExport.error);
            }
        });
    }];
}



- (void)setMinTime:(NSInteger)minTime{
    _minTime = minTime;
}

- (NSString *)getNowTimeTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}


@end
