//
//  TXLivePlayObj.m
//  AgoraExtension
//
//  Created by klc_sl on 2021/1/11.
//  Copyright © 2021 XTY. All rights reserved.
//

#import "TXLivePlayObj.h"
#import <TXLivePlayer.h>
#import <LibTools/LibTools.h>
#import <Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface TXLivePlayObj ()<TXLivePlayListener>

@property (nonatomic, copy) TXLivePlayer *player;      ///腾讯云播放器

@property (nonatomic, weak) UIImageView *bufferCoverV;       //封面图

@property (nonatomic, weak) UIView *anchorSuperV;

@end

@implementation TXLivePlayObj

- (void)dealloc
{
    [_player stopPlay];
    [_playVideoView removeFromSuperview];
    _anchorPullUrl = nil;
    [_player stopPlay];
    _player.delegate = nil;
    _player = nil;
    [_bufferCoverV removeFromSuperview];
    _bufferCoverV = nil;
}

- (instancetype)initShowInView:(UIView *)superView
{
    self = [super init];
    if (self) {
        _anchorSuperV = superView;
        ///遮盖
        UIImageView *coverImgV = [[UIImageView alloc] init];
        coverImgV.clipsToBounds = YES;
        coverImgV.contentMode = UIViewContentModeScaleAspectFill;
        [superView addSubview:coverImgV];
        self.bufferCoverV = coverImgV;
        [coverImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView);
        }];
    }
    return self;
}

- (void)setMute:(BOOL)mute{
    _mute = mute;
    [_player setMute:mute];
}

- (void)setThumb:(NSString *)thumb{
    _thumb = thumb;
    if (thumb.length > 0) {
        [self.bufferCoverV sd_setImageWithURL:[NSURL URLWithString:thumb]];
    }
}

- (void)setVideoPause:(BOOL)videoPause{
    _videoPause = videoPause;
    videoPause?[_player pause]:[_player resume];
}

- (void)startVideoPlay {
    
    [self.player setDelegate:self];
    if (!_playVideoView) {

        UIImageView *playVideoV = [[UIImageView alloc] init];
//        //先禁止 autoresizing 功能，设置要添加约束的控件的下面属性为 NO
        playVideoV.translatesAutoresizingMaskIntoConstraints = NO;
        playVideoV.contentMode = UIViewContentModeScaleAspectFill;
        playVideoV.clipsToBounds = YES;
        [_anchorSuperV addSubview:playVideoV];
        _bufferCoverV?[_anchorSuperV bringSubviewToFront:_bufferCoverV]:nil;
        _playVideoView = playVideoV;
        [_player setupVideoWidget:_playVideoView.bounds containView:_playVideoView insertIndex:0];
        
        NSLayoutConstraint *xConstraint = [NSLayoutConstraint constraintWithItem:playVideoV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_anchorSuperV attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:playVideoV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_anchorSuperV attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *maxXConstraint = [NSLayoutConstraint constraintWithItem:playVideoV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_anchorSuperV attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *maxYConstraint = [NSLayoutConstraint constraintWithItem:playVideoV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_anchorSuperV attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [_anchorSuperV addConstraints:@[xConstraint, yConstraint, maxXConstraint, maxYConstraint]];
        
    }
    int ret = [_player startPlay:_anchorPullUrl type:[self checkPlayUrl:_anchorPullUrl]];
    if (ret != 0) {
       // NSLog(@"过滤文字播放器启动失败"));
    }
    
    
}

- (void)reStartVideoPlay{
    if (_anchorPullUrl.length > 0) {
        [self stopVideoPlay];
        [self startVideoPlay];
    }
}

- (void)stopVideoPlay{
    if (_player) {
        [_playVideoView removeFromSuperview];
        _playVideoView = nil;
        [_player setDelegate:nil];
        [_player stopPlay];
    }
}


- (TXLivePlayer *)player{
    if (!_player) {
        _player = [[TXLivePlayer alloc] init];
        [_player showVideoDebugLog:NO];
        [_player setRenderRotation:HOME_ORIENTATION_DOWN];
        [_player setRenderMode:RENDER_MODE_FILL_SCREEN];
        ///硬件编码
//        _player.enableHWAcceleration = YES;
    }
    return _player;
}


-(TX_Enum_PlayType)checkPlayUrl:(NSString*)playUrl {
    
    playUrl = [playUrl lowercaseString];
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
        playType = PLAY_TYPE_LIVE_RTMP;
    }
    return playType;
}


#pragma mark  - TXLivePlayListener -
/**
 * 直播事件通知
 * @param EvtID 参见 TXLiveSDKEventDef.h
 * @param param 参见 TXLiveSDKTypeDef.h
 */
- (void)onPlayEvent:(int)EvtID withParam:(NSDictionary *)param{
    
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (EvtID == PLAY_EVT_PLAY_BEGIN) {
            if (weakself.bufferCoverV) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.bufferCoverV removeFromSuperview];
                    weakself.bufferCoverV = nil;
                });
            }
        }
        else if (EvtID == PLAY_ERR_NET_DISCONNECT || EvtID == PLAY_EVT_PLAY_END) {
            // 先停止，再重新播放
            [weakself stopVideoPlay];
            [weakself startVideoPlay];
            
        } else if (EvtID == PLAY_EVT_PLAY_LOADING){
            
        } else if (EvtID == PLAY_EVT_CONNECT_SUCC) {
            
        } else if (EvtID == PLAY_EVT_GET_MESSAGE) {
            //            NSData *msgData = param[@"EVT_GET_MSG"];
            //            NSString *msg = [[NSString alloc] initWithData:msgData encoding:NSUTF8StringEncoding];
            //           // NSLog(@"过滤文字%@"),msg);
        }
        /*
         7.2 新增
         else if (EvtID == PLAY_EVT_GET_FLVSESSIONKEY) {
         //NSString *Msg = (NSString*)[dict valueForKey:EVT_MSG];
         //[self toastTip:[NSString stringWithFormat:@"event PLAY_EVT_GET_FLVSESSIONKEY: %@", Msg]];
         }
         */
    });
}

/**
 * 网络状态通知
 * @param param 参见 TXLiveSDKTypeDef.h
 */
- (void)onNetStatus:(NSDictionary *)param{
    
}

@end
