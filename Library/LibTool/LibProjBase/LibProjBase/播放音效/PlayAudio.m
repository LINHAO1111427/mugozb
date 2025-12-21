//
//  PlayAudio.m
//  LibProjBase
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 . All rights reserved.
//

#import "PlayAudio.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

static PlayAudio *_playAudio = nil;

@interface PlayAudio ()
{
    dispatch_source_t timer;
}

@property (nonatomic ,strong) AVAudioPlayer *audioPlay;  ///音效播放

@property (nonatomic ,strong) AVAudioPlayer *messagePlay;  ///消息播放

@property (nonatomic, strong) AVAudioPlayer *blankPlay;  ///空白音乐播放

@property (nonatomic ,strong) CADisplayLink *displayLink;




@end

@implementation PlayAudio

+ (instancetype)share{
    if (_playAudio == nil) {
        _playAudio = [[PlayAudio alloc] init];
    }
    return _playAudio;
}

- (void)callPlay
{
    BOOL bAudioInputAvailable = FALSE;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bAudioInputAvailable    = [audioSession isInputAvailable];
    
    if (bAudioInputAvailable)
    {
        [self.audioPlay stop];
        self.audioPlay.currentTime = 0;//将播放的进度设置为初始状态
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"call" ofType:@"wav"];
        
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        //初始化播放器对象
        self.audioPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
        //设置声音的大小
        self.audioPlay.volume = 0.8;//范围为（0到1）；
        //设置循环次数，如果为负数，就是无限循环
        self.audioPlay.numberOfLoops =-1;
        //设置播放进度
        self.audioPlay.currentTime = 0;
        //准备播放
        [self.audioPlay prepareToPlay];
        [self.audioPlay play];
    }
}

- (void)cancelPlay
{
    BOOL    bAudioInputAvailable = FALSE;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bAudioInputAvailable    = [audioSession isInputAvailable];
    
    if (bAudioInputAvailable)
    {
        [self.audioPlay stop];
        self.audioPlay.currentTime = 0;//将播放的进度设置为初始状态
        
        NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"cancel" ofType:@"wav"];
        
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        //初始化播放器对象
        self.audioPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
        //设置声音的大小
        self.audioPlay.volume = 0.8;//范围为（0到1）；
        //设置循环次数，如果为负数，就是无限循环
        self.audioPlay.numberOfLoops = 0;
        //设置播放进度
        self.audioPlay.currentTime = 0;
        //准备播放
        [self.audioPlay prepareToPlay];
        [self.audioPlay play];
    }
}

- (void)stopPlay{
    [_audioPlay stop];
    _audioPlay = nil;
}

- (void)matchingCallPlay{
    BOOL    bAudioInputAvailable = FALSE;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bAudioInputAvailable = [audioSession isInputAvailable];
    
    if (bAudioInputAvailable)
    {
        [self.audioPlay stop];
        self.audioPlay.currentTime = 0;//将播放的进度设置为初始状态
        
        [self matchingPlay];
    }
}

- (void)matchingPlay {
    NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"matching" ofType:@"wav"];
    
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    //初始化播放器对象
    self.audioPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
    //设置声音的大小
    self.audioPlay.volume = 0.8;//范围为（0到1）；
    //设置循环次数，如果为负数，就是无限循环
    self.audioPlay.numberOfLoops = 0;
    //设置播放进度
    self.audioPlay.currentTime = 0;
    //准备播放
    [self.audioPlay prepareToPlay];
    [self.audioPlay play];
}

- (int)playTime
{
    return self.audioPlay.currentTime;
}


#pragma mark ---- 开始震动
- (void)startAlertSound
{
    //   // NSLog(@"过滤文字start button action"));
    //    //如果你想震动的提示播放音乐的话就在下面填入你的音乐文件
    //    self.displayLink = [CADisplayLink displayLinkWithTarget:self
    //                            selector:@selector(handleDisplayLink:)];
    //    interval = 5;
    //    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
    //                           forMode:NSDefaultRunLoopMode];
    
    dispatch_queue_t  queue = dispatch_get_global_queue(0, 0);
    
    // 创建一个 timer 类型定时器 （ DISPATCH_SOURCE_TYPE_TIMER）
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性（何时开始，间隔多久执行）
    // GCD 的时间参数一般为纳秒 （1 秒 = 10 的 9 次方 纳秒）
    // 指定定时器开始的时间和间隔的时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.5 * NSEC_PER_SEC, 0);
    
    // 任务回调
    dispatch_source_set_event_handler(timer, ^{
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    });
    
    // 开始定时器任务（定时器默认开始是暂停的，需要复位开启）
    dispatch_resume(timer);
}

#pragma mark ---- 结束震动
-(void)stopDisplayLink{
    if (timer) {
        dispatch_source_cancel(timer);
        timer = nil;
    }
}


/*********************************背景空白音乐**********************************/

- (void)playBgMusic{
    
    BOOL    bAudioInputAvailable = FALSE;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bAudioInputAvailable = [audioSession isInputAvailable];
    
    if (bAudioInputAvailable)
    {
        [self.blankPlay stop];
        self.blankPlay.currentTime = 0;//将播放的进度设置为初始状态
        
        NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"noAudio" ofType:@"wav"];
        
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        //初始化播放器对象
        self.blankPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
        //设置声音的大小
        self.blankPlay.volume = 0;//范围为（0到1）；
        //设置循环次数，如果为负数，就是无限循环
        self.blankPlay.numberOfLoops =-1;
        //设置播放进度
        self.blankPlay.currentTime = 0;
        //准备播放
        [self.blankPlay prepareToPlay];
        [self.blankPlay play];
    }

}

- (void)stopBgMusic{
    [_blankPlay stop];
    _blankPlay = nil;
}


/*********************************Message**********************************/

- (void)callMSGPlay
{
    BOOL    bAudioInputAvailable = FALSE;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bAudioInputAvailable    = [audioSession isInputAvailable];
    
    if (bAudioInputAvailable)
    {
        NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"msg" ofType:@"wav"];
        if (soundPath.length == 0) {
            return;
        }
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        //初始化播放器对象
        self.messagePlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
        //设置声音的大小
        self.messagePlay.volume = 1;//范围为（0到1）；
        //设置循环次数，如果为负数，就是无限循环
        self.messagePlay.numberOfLoops = 0;
        //设置播放进度
        self.messagePlay.currentTime = 0;
        //准备播放
        [self.messagePlay prepareToPlay];
        [self.messagePlay play];
    }
}

- (void)callMSGEndPlay
{
    BOOL  bAudioInputAvailable = FALSE;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bAudioInputAvailable    = [audioSession isInputAvailable];
    
    if (bAudioInputAvailable)
    {
        [self.messagePlay stop];
        self.messagePlay.currentTime = 0;//将播放的进度设置为初始状态
        
        [self messagePlay];
    }
    
    [_messagePlay stop];
    _messagePlay = nil;
}

- (void)callMsgShark{
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
