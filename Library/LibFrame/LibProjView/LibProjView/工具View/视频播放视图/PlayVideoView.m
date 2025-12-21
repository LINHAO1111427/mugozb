//
//  PlayVideoView.m
//  TCDemo
//
//  Created by admin on 2019/11/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import "PlayVideoView.h"
#import <SDWebImage.h>
#import <LibTools/LibTools.h>

#import <TXLivePlayer.h>


@interface PlayVideoView () <TXLivePlayListener>

@property (nonatomic, strong) UIImageView *playVideoView;       //播放视图

@property (nonatomic, weak) UIImageView *bufferCoverV;       //封面图

@property (nonatomic, copy) NSString *playUrl;  ///播放视频的地址

@property (nonatomic, copy) TXLivePlayer *player;

@property (nonatomic, weak) UIImageView *pauseImgV;   ///暂停图标

@end

@implementation PlayVideoView

- (void)dealloc
{
    [self stop];
    [_playVideoView removeFromSuperview];
    _playVideoView = nil;
    [_bufferCoverV removeFromSuperview];
    _bufferCoverV = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (UIImageView *)bufferCoverV{
    if (!_bufferCoverV) {
        ///遮盖
        UIImageView *coverImgV = [[UIImageView alloc] init];
        coverImgV.clipsToBounds = YES;
        [self addSubview:coverImgV];
        [coverImgV sd_setImageWithURL:[NSURL URLWithString:self.preview] placeholderImage:[UIImage imageWithColor:[UIColor clearColor]]];
        _bufferCoverV = coverImgV;
        [coverImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [coverImgV layoutIfNeeded];
    }
    [self bringSubviewToFront:_bufferCoverV];
    return _bufferCoverV;
}

//初始视图
- (void)createUI{
    ///视频播放
    UIImageView *playVideoView = [[UIImageView alloc] init];
    [playVideoView sd_setImageWithURL:[NSURL URLWithString:_preview]];
    [self addSubview:playVideoView];
    self.playVideoView = playVideoView;
    [playVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [playVideoView layoutIfNeeded];
    
    self.bufferCoverV.image = [UIImage new];
}

///设置封面图
- (void)setPreview:(NSString *)preview{
    _preview = preview;
    ///遮盖
    self.bufferCoverV.contentMode = _imageModeAspectFill?UIViewContentModeScaleAspectFill:UIViewContentModeScaleAspectFit;
    if (preview.length && !self.player.isPlaying) {
        [self.bufferCoverV sd_setImageWithURL:[NSURL URLWithString:preview] placeholderImage:[UIImage imageWithColor:[UIColor clearColor]]];
    }
    else{
        self.bufferCoverV.image = [UIImage new];
    }
}

- (void)setImageModeAspectFill:(BOOL)imageModeAspectFill{
    _imageModeAspectFill = imageModeAspectFill;
    _player?[_player setRenderMode:imageModeAspectFill?RENDER_MODE_FILL_SCREEN:RENDER_MODE_FILL_EDGE]:nil;
}

- (UIImageView *)pauseImgV{
    if (!_pauseImgV) {
        UIImageView *playStatusImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 56, 56)];
        playStatusImgV.center = CGPointMake(self.width/2.0, self.height/2.0);
        playStatusImgV.image = [UIImage imageNamed:@"shorVideo_play"];
        playStatusImgV.userInteractionEnabled = YES;
        playStatusImgV.hidden = YES;
        [self addSubview:playStatusImgV];
        _pauseImgV = playStatusImgV;
    }
    [self bringSubviewToFront:_pauseImgV];
    return _pauseImgV;
}


///播放地址
- (void)playVideo:(NSString *)url{
    _playUrl = url;
    
    [self setPreview:_preview];
    
    if (!_player) {
        _player = [[TXLivePlayer alloc] init];
    }
    
    [self stopVideoPlay];
    [self startVideoPlay];
    
    self.pauseImgV.hidden = YES;
}


- (void)startVideoPlay{
    
    TX_Enum_PlayType playType = [self checkPlayUrl:_playUrl];
    [_player setDelegate:self];
    [_player setupVideoWidget:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) containView:self.playVideoView insertIndex:0];
    
    int ret = [_player startPlay:_playUrl type:playType];
    if (ret != 0) {
       // NSLog(@"过滤文字=====播放器启动失败====="));
        return;
    }
    // 播放参数初始化
    [_player showVideoDebugLog:NO];
    [_player setRenderRotation:HOME_ORIENTATION_DOWN];
    [_player setRenderMode:_imageModeAspectFill?RENDER_MODE_FILL_SCREEN:RENDER_MODE_FILL_EDGE];
    
    TXLivePlayConfig *config = _player.config;
    config.bAutoAdjustCacheTime = YES;
    config.minAutoAdjustCacheTime = 1.0f;
    config.maxAutoAdjustCacheTime = 5.0f;
    [_player setConfig:config];
    
}


- (void)stopVideoPlay{
    if (_player) {
        [_player setDelegate:nil];
        [_player removeVideoWidget];
        [_player stopPlay];
    }
}

- (BOOL)isPlaying{
    return _player.isPlaying;
}

- (void)pause{
    [_player pause];
    _pauseImgV.hidden = NO;
}

- (void)resume{
    [_player resume];
    _pauseImgV.hidden = YES;
}

- (void)seekTime:(float)time {
    [_player seek:time];
}

- (void)isMute:(BOOL)isMute{
    [_player setMute:isMute];
}

///内部播放暂停
- (void)internalStop{
    
}

///外部调用的暂停播放
- (void)stop{
    [self stopVideoPlay];
    _player = nil;
    self.bufferCoverV.hidden = NO;
}


#pragma mark - TXLivePlayListener


-(TX_Enum_PlayType)checkPlayUrl:(NSString*)playUrl {
    TX_Enum_PlayType playType = PLAY_TYPE_LIVE_RTMP_ACC;
    if ([playUrl hasPrefix:@"rtmp:"]) {
        playType = PLAY_TYPE_LIVE_RTMP;
    } else if (([playUrl hasPrefix:@"https:"] || [playUrl hasPrefix:@"http:"]) && ([playUrl rangeOfString:@".flv"].length > 0)) {
        playType = PLAY_TYPE_LIVE_FLV;
    } else if (([playUrl hasPrefix:@"https:"] || [playUrl hasPrefix:@"http:"]) && [playUrl rangeOfString:@".m3u8"].length > 0) {
        playType = PLAY_TYPE_VOD_HLS;
    } else if (([playUrl hasPrefix:@"https:"] || [playUrl hasPrefix:@"http:"]) && [playUrl rangeOfString:@".mp4"].length > 0) {
        playType = PLAY_TYPE_VOD_MP4;
    }  else{
        playType = PLAY_TYPE_VOD_MP4;
    }
    return playType;
}

/**
 * 直播事件通知
 * @param EvtID 参见 TXLiveSDKEventDef.h
 * @param param 参见 TXLiveSDKTypeDef.h
 */
- (void)onPlayEvent:(int)EvtID withParam:(NSDictionary *)param{
    
    NSDictionary *dict = param;
    ///传递进度
    (_delegate && [_delegate respondsToSelector:@selector(playVideoDuration:progress:)])?[_delegate playVideoDuration:[dict[EVT_PLAY_DURATION] floatValue] progress:[dict[EVT_PLAY_PROGRESS] floatValue]]:@"";
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (EvtID == PLAY_EVT_PLAY_BEGIN) {
//            if (weakself.bufferCoverV) {
////                    weakself.bufferCoverV.image = [UIImage new];
                    weakself.bufferCoverV.hidden = YES;
//            }
           
        } else if (EvtID == PLAY_ERR_NET_DISCONNECT || EvtID == PLAY_EVT_PLAY_END) {
            
            if (EvtID == PLAY_ERR_NET_DISCONNECT) {
                NSString *msg = (NSString*)[dict valueForKey:EVT_MSG];
               // NSLog(@"过滤文字========%@"),msg);
            }
            // 先停止，再重新播放
            [self stopVideoPlay];
            [self startVideoPlay];
            
        } else if (EvtID == PLAY_EVT_PLAY_LOADING){
            
            
        } else if (EvtID == PLAY_EVT_CONNECT_SUCC) {
            
            
        } else if (EvtID == PLAY_EVT_GET_MESSAGE) {
            NSData *msgData = param[EVT_GET_MSG];
            NSString *msg = [[NSString alloc] initWithData:msgData encoding:NSUTF8StringEncoding];
           // NSLog(@"过滤文字========%@"),msg);
        }
        
        ///7.2 新增
        else if (EvtID == PLAY_EVT_GET_FLVSESSIONKEY) {
            NSString *Msg = (NSString*)[dict valueForKey:EVT_MSG];
           // NSLog(@"过滤文字event PLAY_EVT_GET_FLVSESSIONKEY: %@"), Msg);
        }
        
    });
    
}


- (void)onNetStatus:(NSDictionary *)param{
    
}


@end
