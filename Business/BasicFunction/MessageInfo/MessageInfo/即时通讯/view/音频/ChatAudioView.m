//
//  ChatAudioView.m
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "ChatAudioView.h"
#import "SpectrumView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/VoiceRecord.h>
#import <LibProjView/SkyDriveTool.h>

@interface ChatAudioView ()<VoiceRecordDelegate>

@property (strong, nonatomic) SpectrumView *spectrumView;
@property (strong, nonatomic) UIButton *recordButton;
@property (strong, nonatomic) UIButton *cancelButton;

@property (nonatomic,copy) VoiceRecord *voiceRecord;

@property (nonatomic,assign) BOOL isDelete;

@property (nonatomic, assign)NSTimeInterval recordTime; ///录制的时间

@end
@implementation ChatAudioView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor whi];
        [self creatSubView];
    }
    return self;
}
-(void)creatSubView{
    
    self.isDelete = NO;
    self.voiceRecord.minTime = 1;
    self.spectrumView = [[SpectrumView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-100,20,200, 20.0)];
    self.spectrumView.text = @"00:00";
    self.spectrumView.middleInterval = 20;
    __weak SpectrumView *weakSpectrum = self.spectrumView;
    kWeakSelf(self);
    self.spectrumView.itemLevelCallback = ^() {
        [weakself.voiceRecord.recorder updateMeters];
        //取得第一个通道的音频，音频强度范围是-160到0
        float power= [weakself.voiceRecord.recorder averagePowerForChannel:0];
        weakSpectrum.level = power;
        //          weakSpectrum.level = 0.1;
    };
    [self addSubview:self.spectrumView];
    
    [self addSubview:self.recordButton];
    UILongPressGestureRecognizer*longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(btnLong:)];
    
    longPress.minimumPressDuration = 0.3;//定义按的时间
    
    [self.recordButton addGestureRecognizer:longPress];
    [self.recordButton addTarget:self action:@selector(clickrecordButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
    
    
}


- (VoiceRecord *)voiceRecord{
    if (!_voiceRecord) {
        _voiceRecord = [[VoiceRecord alloc] init];
        _voiceRecord.delegate = self;
        _voiceRecord.minTime = 3;
    }
    return _voiceRecord;
}

-(UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 40, 80, 80, 80)];
        [_recordButton setImage:[UIImage imageNamed:@"center_huatong"] forState:UIControlStateNormal];
        
    }
    return _recordButton;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 90, 60, 60)];
        [_cancelButton setImage:[UIImage imageNamed:@"message_delete"] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}



#pragma mark-  开始录制声音
- (void)recordStart:(UIButton *)button{
    [self.voiceRecord startRecording];
}


#pragma mark-  取消录制声音
- (void)recordCancel:(UIButton *)button{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.voiceRecord stopRecording];
        [self.voiceRecord destruction];
        
    });
    
}
#pragma mark-  完成录制
- (void)recordFinish:(UIButton *)button
{
    [_recordButton setImage:[UIImage imageNamed:@"center_huatong"] forState:UIControlStateNormal];
    //************结束录制***********
    if (self.recordTime < 3) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"录制时间不能少于3秒")];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.voiceRecord stopRecording];
            [self.voiceRecord destruction];
        });
    } else if(self.recordTime > 30){
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"录制时间不能大于30秒")];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.voiceRecord stopRecording];
            
        });
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.voiceRecord stopRecording];
        });
        
    }
}

-(void)clickrecordButton{
    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"按住说话")];
}


#pragma mark-  VoiceRecordDelegate
- (void)voiceRecord:(VoiceRecord *)record audioAuthState:(AVAuthorizationStatus)status{
    
}

- (void)voiceRecord:(VoiceRecord *)record didRecoringTime:(NSTimeInterval)time{
    _recordTime = time;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.spectrumView.text = [self setSecond:time];
    });
}


-(void)btnLong:(UILongPressGestureRecognizer*)gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            _cancelButton.hidden = NO;
            [self.voiceRecord startRecording];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [gestureRecognizer locationInView:self];
            if (point.x > self.cancelButton.x && point.x < self.cancelButton.x + self.cancelButton.width && point.y > self.cancelButton.y && point.y < self.cancelButton.y + self.cancelButton.height) {
                
                _cancelButton.backgroundColor = [UIColor redColor] ;
                self.isDelete = YES;
            }else{
                self.isDelete = NO;
                
                _cancelButton.backgroundColor = [UIColor whiteColor] ;
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            if (self.isDelete) {
               // NSLog(@"过滤文字取消录制"));
                _cancelButton.backgroundColor = [UIColor whiteColor] ;
                self.recordTime = 0;
                self.spectrumView.text = @"00:00";
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [self.voiceRecord stopRecording];
                    [self.voiceRecord destruction];
                    
                });
            }else{
                if (self.recordTime < 1) {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"录制时间短了")];
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [self.voiceRecord stopRecording];
                        [self.voiceRecord destruction];
                        self.recordTime = 0;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.spectrumView.text = @"00:00";
                        });
                        
                    });
                } else{
                    kWeakSelf(self);
                    self.spectrumView.text = @"00:00";
                    [self.voiceRecord stopRecording:^(NSTimeInterval recordTime, NSString * _Nonnull recordPath) {
                        if (kStringIsEmpty(self.voiceRecord.recordPath)) {
                            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送失败，请重新发送")];
                            weakself.recordTime = 0;
                        }else{
                            [SVProgressHUD showWithStatus:kLocalizationMsg(@"发送中")];
                            [weakself uploadVoiceWithFile:[NSURL URLWithString:self.voiceRecord.recordPath]];
                        }
                    }];
                }
            }
            _cancelButton.hidden = YES;
        }
        default:
            break;
    }
    
}
#pragma mark - 录音上传
- (void)uploadVoiceWithFile:(NSURL*)fileUrl{
    kWeakSelf(self);
    [SkyDriveTool uploadFileFromScene:4 filePath:[fileUrl path] complete:^(BOOL success, NSString * _Nonnull url) {
        [SVProgressHUD dismiss];
        if (success) {
            if ([weakself.delegate respondsToSelector:@selector(sendMessageRecordUrlToOther:andTimeStr:)]) {
                [weakself.delegate sendMessageRecordUrlToOther:url andTimeStr:[NSString stringWithFormat:@"%0.0lf",weakself.recordTime]];
            }
            [weakself.voiceRecord destruction];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送失败，请重新发送")];
        }
    } progress:^(CGFloat uploadProgress) {
        [SVProgressHUD showProgress:uploadProgress];
    }];
}


-(NSString *)setSecond:(NSTimeInterval)second{
    
//    NSInteger hour = second/3600;
    NSInteger min = (NSInteger)(second / 60) % 60;
    NSInteger sec = (NSInteger)second % 60;
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    return timeStr;
}

@end
