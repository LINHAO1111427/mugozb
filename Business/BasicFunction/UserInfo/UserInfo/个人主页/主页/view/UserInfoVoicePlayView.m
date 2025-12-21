//
//  UserInfoVoicePlayView.m
//  UserInfo
//
//  Created by shirley on 2021/12/22.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "UserInfoVoicePlayView.h"
#import <AVFoundation/AVFoundation.h>

@interface UserInfoVoicePlayView ()

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)id timeObserver;

@property (nonatomic, copy)NSString *playUrl;
@property (nonatomic, assign)int playTime;

@property (nonatomic, assign)BOOL isPlayingVoice;

@end

@implementation UserInfoVoicePlayView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self cornerRadii:CGSizeMake(self.height, self.height) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)];
    }
    return self;
}


- (void)dealloc{
    self.isPlayingVoice = NO;
}


- (void)stopPlay{
    self.isPlayingVoice = NO;
}

- (void)createUI{

    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    ///声音图标
    UIButton *bgV = [UIButton buttonWithType:0];
    bgV.layer.masksToBounds = YES;
    bgV.backgroundColor = [ProjConfig normalColors];
    [bgV addTarget:self action:@selector(playVoiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self).inset(2);
        make.width.mas_equalTo(bgV.mas_height);
    }];
    [bgV layoutIfNeeded];
    bgV.layer.cornerRadius = bgV.height/2.0;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [bgV addSubview:imageV];
    self.voiceImg = imageV;
    imageV.animationDuration = 1;
    imageV.animationRepeatCount = 0;
    imageV.image = [UIImage imageNamed:@"message_play"];
    imageV.animationImages = [self getNoRepeatRandomArrayWithMinNum:0 maxNum:9 count:5];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(bgV).multipliedBy(0.5);
        make.center.equalTo(bgV);
    }];
    ///秒数
    UILabel *secondL = [[UILabel alloc] init];
    secondL.textColor = [UIColor whiteColor];
    secondL.font = [UIFont systemFontOfSize:15];
    [self addSubview:secondL];
    self.secondL = secondL;
    [secondL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgV.mas_right).inset(5);
        make.right.equalTo(self).inset(5);
        make.centerY.equalTo(self);
    }];
}


- (void)playUrl:(NSString *)playUrl time:(int64_t)time {
    _playUrl = playUrl;
    _playTime = (int)time;
    self.secondL.text = kStringFormat(@"%d' ",_playTime);
}


#pragma mark - 播放声音 -
- (void)playVoiceBtnClick{
   // NSLog(@"过滤文字播放"));
    self.isPlayingVoice = !self.isPlayingVoice;
}

- (void)setIsPlayingVoice:(BOOL)isPlayingVoice{
    _isPlayingVoice = isPlayingVoice;
    if (!isPlayingVoice) {
        [self.voiceImg stopAnimating];
        self.voiceImg.image = [UIImage imageNamed:@"message_play"];
        [self.player pause];
        [self.player removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
        self.player = nil;
    }else{
        [self.voiceImg startAnimating];
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.playUrl]];
        self.player = [[AVPlayer alloc]initWithPlayerItem:item];
        [self.player play];
        __weak typeof(self) weakSelf = self;
        self.timeObserver =[self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0,1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            CMTime duration = weakSelf.player.currentItem.duration;
            float totalSeconds = CMTimeGetSeconds(duration);
            float currentSeconds = CMTimeGetSeconds(time);
            float rate = currentSeconds/totalSeconds;
            if (rate >= 0.99) {
                weakSelf.isPlayingVoice = NO;
            }
        }];
    }
}


//随机数组
- (NSMutableArray *)getNoRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger )max count:(NSInteger)count{
    NSMutableSet *set = [NSMutableSet setWithCapacity:count];
    while (set.count < count) {
        NSInteger value = arc4random() % (max-min+1) + min;
        [set addObject:[UIImage imageNamed:[NSString stringWithFormat:@"message_play_%ld",(long)value]]];
    }
    NSMutableArray *arr = [self getRandomArrFrome:set.allObjects];
    return arr;
}


-(NSMutableArray*)getRandomArrFrome:(NSArray*)arr{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        //生成随机数
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}



@end
