//
//  AgoraO2OVideo.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/11.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import "AgoraO2OVideo.h"
#import "AgoraBeautyView.h"
#import "VideoSession.h"
#import "AgoraVideoSourceObj.h"
#import "AgoraVideoSnasshot.h"
#import <LibTools/LibTools.h>

@interface AgoraO2OVideo ()<AgoraRtcEngineDelegate>

@property (nonatomic, weak) UIImageView *anchorV;           //主播视图

@property (nonatomic, copy) NSDictionary *otherUserDic;      ///除了自己外的其他用户

@property (nonatomic, weak) AgoraBeautyView *agoraBeauty;         //自带美颜视图

@property (nonatomic, copy) AgoraVideoSourceObj *beautyObj;  ///美颜

@property (nonatomic, copy) AgoraVideoSnasshot *videoSnasshot;   ///视频监控

@property (nonatomic, strong) AgoraRtcVideoCanvas *ownCanvas;  ///自己的画面

///用户进入直播中回调
@property (nonatomic, copy)void (^userInOrOutRoom)(BOOL, int64_t, UIImageView *);

//模式设置-------------------------------------------------------------------------------------

@property (nonatomic, assign)BOOL isAgoraBeauty;   //是否使用自带美颜

//模式设置-------------------------------------------------------------------------------------


@end

@implementation AgoraO2OVideo

#pragma mark - 初始化

- (void)dealloc
{
    [self leaveRoom];
   // NSLog(@"过滤文字一对一视频文件销毁"));
    AgoraManager.rtcEngine.delegate = nil;
    [AgoraManager destroy];
    _agoraBeauty = nil;
}


+ (instancetype)registerObj{
    return [[AgoraO2OVideo alloc] init];
}



/// 初始化基础信息
/// @param role 用户角色                       主播=1 // 副播=2 // 观众(默认) =3
- (void)initO2OVideoRole:(int)role{
    AgoraManager.rtcEngine.delegate = self;
    self.clientRole = (role == 3)?AgoraClientRoleAudience:AgoraClientRoleBroadcaster;
    self.channelProfile = AgoraChannelProfileLiveBroadcasting;
    _isAgoraBeauty = (AgoraManager.beautyCls?NO:YES);
}

- (void)setSnasshotTime:(int)time videoFrame:(void (^)(UIImage * _Nonnull))videoFrame{
    if (time > 0 && !_videoSnasshot) {
        _videoSnasshot = [[AgoraVideoSnasshot alloc] initWithSnasshotForSecond:time];
        _videoSnasshot.snasshotBlock = ^(UIImage * _Nonnull image) {
            if (videoFrame) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    videoFrame(image);
                });
            }
        };
    }
}

- (void)preview:(UIImageView *)preview{
    _anchorV = preview;
    [AgoraManager setVideoAgoraBase:self.channelProfile];
    [AgoraManager.rtcEngine setClientRole:self.clientRole];
    
    AgoraRtcVideoCanvas *ownCanvas = [[AgoraRtcVideoCanvas alloc] init];
    ownCanvas.uid = (NSUInteger)AgoraManager.userID;
    ownCanvas.view = _anchorV;
    ownCanvas.renderMode = AgoraVideoRenderModeHidden;
    ownCanvas.mirrorMode = AgoraVideoMirrorModeAuto;
    [AgoraManager.rtcEngine setupLocalVideo:ownCanvas];
    
    [preview layoutIfNeeded];
    
    if (_isAgoraBeauty) {
        AgoraBeautyView *beautyV = [[AgoraBeautyView alloc] init];
        self.agoraBeauty = beautyV;
        [self setBeautyRednessLevel:0.5 smoothnessLevel:0.5 lighteningContrastLevel:0.5];
    }else{
        _beautyObj = [[AgoraVideoSourceObj alloc] init];
        [AgoraManager.rtcEngine setVideoSource:_beautyObj];
    }
    AgoraManager.previewStatus = YES;
}

/** 主播---创建直播房间配置基础数据 */
- (void)joinRoom:(int64_t)roomId{
    if (roomId == 0) {
        return;
    }
    [_videoSnasshot startMonitoring:AgoraManager.rtcEngine];
    [self joinRoom:roomId didJoinSuccess:nil];
    
}


/** 主播---设置用户的连麦视图 */
- (void)addConnectMicV:(UIImageView *)showV otherUid:(int64_t)uid{
    NSString *uidKey = [NSString stringWithFormat:@"%lld",uid];
    UIImageView *hasImage = _otherUserDic[uidKey];
    
    if (!hasImage) {
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        [muDic setObject:showV forKey:uidKey];
        [muDic addEntriesFromDictionary:_otherUserDic];
        _otherUserDic = [NSDictionary dictionaryWithDictionary:muDic];
    }
}


/** 副播进出房间---回调的信息 */
- (void)userInfoBlock:(void (^)(BOOL, int64_t, UIImageView * _Nullable))userBlock{
    _userInOrOutRoom = userBlock;
}


/** 关闭其中一个用户 */
- (void)closeUser:(int64_t)userId{
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithCapacity:_otherUserDic.count];
    [muDic removeObjectForKey:[NSString stringWithFormat:@"%lld",userId]];
    _otherUserDic = [NSDictionary dictionaryWithDictionary:muDic];
}

///断开链接
- (void)disconnect{
    [self leaveRoom:0 didLeaveSuccess:nil];
}

/** 离开 */
- (void)leaveRoom{
    [_videoSnasshot stopMonitoring];
    // 关闭网络监控
    [self leaveRoom:0 didLeaveSuccess:nil];
    _beautyObj = nil;
    AgoraManager.previewStatus = NO;
    [AgoraManager destroy];
    _otherUserDic = nil;
    _anchorV = nil;
    
}

///反转摄像头
- (void)switchCamera{
    if (_isAgoraBeauty) {
        int code = [AgoraManager.rtcEngine switchCamera];
       // NSLog(@"过滤文字code:%d"),code);
    }else{
        [self.beautyObj switchCamera:^(BOOL isFront) {
            [AgoraManager.rtcEngine setLocalRenderMode:AgoraVideoRenderModeHidden mirrorMode:isFront?AgoraVideoMirrorModeEnabled:AgoraVideoMirrorModeDisabled];
        }];
    }
}


/** 美颜 */
- (void)showBeautyInView:(UIView *)superV complete:(void (^)(void))complete{
    
    if (_isAgoraBeauty) {
        kWeakSelf(self);
        [self.agoraBeauty showWithSelectHandle:^(CGFloat redness, CGFloat smoothness, CGFloat bright) {
            [weakself setBeautyRednessLevel:redness smoothnessLevel:smoothness lighteningContrastLevel:bright];
        } complete:^{
            if (complete) {
                complete();
            }
        }];
    }else{
        [AgoraManager.beautyCls showBeautyInView:superV complete:^{
            if (complete) {
                complete();
            }
        }];
    }
}

///设置美颜
- (void)setBeautyRednessLevel:(CGFloat)redness smoothnessLevel:(CGFloat)smoothness lighteningContrastLevel:(CGFloat)lightening{
    AgoraBeautyOptions *options = [[AgoraBeautyOptions alloc] init];
    options.rednessLevel = redness;
    options.smoothnessLevel = smoothness;
    options.lighteningLevel = lightening;
    options.lighteningContrastLevel = AgoraLighteningContrastNormal;
    [AgoraManager.rtcEngine setBeautyEffectOptions:_isAgoraBeauty?YES:NO options:options];
}


///设置远程视图
- (void)videoSessionOfUid:(NSUInteger)uid AndHostingView:(UIView *)hostingView{
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.view = hostingView;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [AgoraManager.rtcEngine setupRemoteVideo:videoCanvas];
}


#pragma mark - AgoraRtcEngineDelegate
///远端用户已加入频道
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    
   // NSLog(@"过滤文字didJoinedOfUid==%lu"),(unsigned long)uid);
    
    if (self.clientRole == AgoraClientRoleBroadcaster) {
        if (AgoraManager.userID == uid) {
            ///自己不管
        }else{  ///他人
            UIImageView *userV = _otherUserDic[[NSString stringWithFormat:@"%zi",uid]];
            if (!userV) {
                
                userV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                userV.contentMode = UIViewContentModeScaleAspectFill;
                [self addConnectMicV:userV otherUid:uid];
                
                if (self.userInOrOutRoom) {
                    self.userInOrOutRoom(NO, uid, userV);
                }
                
            }
            [self videoSessionOfUid:uid AndHostingView:userV];
        }
    }else{
        ///观众  ----- 一对一视频无此身份
    }
}

///远端用户已离开频道
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
   // NSLog(@"过滤文字uid==%lu"),(unsigned long)uid);
   // NSLog(@"过滤文字reason==%lu"),(unsigned long)reason);
    
    if (self.userInOrOutRoom) {
        self.userInOrOutRoom(YES, uid, nil);
    }
    
    [self closeUser:uid];
}


@end
