//
//  CloseMPLiveComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/17.
//  Copyright © 2019 CH. All rights reserved.
//

#import "CloseMPLiveComponent.h"

#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LiveCommon/LiveManager.h>
#import <LibProjBase/PopupTool.h>
#import <LibTools/LibTools.h>

#import <LibProjView/ForceAlertController.h>

#import <TXImKit/TXImKit.h>
#import <LibProjBase/LibProjBase.h>




@interface CloseMPLiveComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property(nonatomic,weak) UIView *firstView;
@property(nonatomic,weak) UIView *secondView;
@property(nonatomic,weak) UIView *thirdView;
@property(nonatomic,weak) UIView *fourthView;
@property(nonatomic,weak) UIView *fifthView;
@property(nonatomic,weak) UIView *sixthView;

@property (nonatomic, weak)UIViewController *superVC;

@end


@implementation CloseMPLiveComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    [LiveComponentMsgMgr addMsgListener:self];
    
    _superVC = superVC;
    
    _firstView = views[0];
    _secondView = views[1];
    _thirdView = views[2];
    _fourthView = views[3];
    _fifthView = views[4]; // 第五层
    _sixthView = views.lastObject;
}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
            
            // FIXME: 主播关播 （清空L2、L3、L4、L5视图层所有UI，然后显示关播信息）
        case LM_CloseLive:{             // 主播端关闭被点击
            [self closeSocket:msgDic];
        }
            break;
            
        case LM_AbnormalExit:{
            [self abnormalExit:msgDic];
        }
            break;
        case LM_LiveLeaveInfo:{
            
            [_secondView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_thirdView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_fourthView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_fifthView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_sixthView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            ///清空视图并且设置视图
            [LiveManager livePopViewClear:YES];
            [LiveManager livePopViewClear:NO];
            
            ApiCloseLiveModel *model = msgDic[@"model"];
            
            Class <MPLiveCloseInterface> objc= [[LiveManager liveInfo].mpViewConfig getCloseView];
            [objc showInView:_secondView isAnchor:([LiveManager liveInfo].anchorId == [ProjConfig userId])?YES:NO closeInfo:model];
        }
            break;
        default:
            break;
    }
}

// MARK: --- 关闭---
- (void)closeSocket:(NSDictionary *)dic{
    if ([LiveManager liveInfo].anchorId == [ProjConfig userId]) {
        [self anchorLevelRequest];
    }else{
        [self userLevelRequest];
        NSString *roomId = [NSString stringWithFormat:@"%lld",[LiveManager liveInfo].roomId];
        if (roomId.length > 0) {
            [[IMSocketIns getIns] quitGroupWithGroupId:roomId sucess:^{
               // NSLog(@"过滤文字####【IM回馈】#### 退出直播群成功"));
            } fail:^(int code, NSString * _Nonnull desc) {
               // NSLog(@"过滤文字####【IM回馈】#### 退出直播群失败"));
            }];
        }else{
           // NSLog(@"过滤文字####【IM回馈】#### 房间不存在"));
        }
    }
}

///异常退出
- (void)abnormalExit:(NSDictionary *)dic{
    if ([dic[@"anchorId"] integerValue] == [ProjConfig userId]) {
        if ([dic[@"liveType"] integerValue] == LiveTypeForMPAudioLive) { //语音
            [HttpApiHttpVoice closeVoiceLive:[dic[@"roomId"] longLongValue] callback:^(int code, NSString *strMsg, ApiCloseLiveModel *model) {
            }];
        }else{ ///直播和直播购
            [HttpApiHttpLive closeLive:[dic[@"roomId"] longLongValue] callback:^(int code, NSString *strMsg, ApiCloseLiveModel *model) {
            }];
        }
    }else{
        if ([dic[@"liveType"] integerValue] == LiveTypeForMPAudioLive) {
            [HttpApiHttpVoice leaveVoiceRoomOpt:[dic[@"roomId"] longLongValue] callback:^(int code, NSString *strMsg, ApiLeaveRoomModel *model) {
            }];
        }else{ ///直播和直播购
            [HttpApiHttpLive leaveRoomOpt:[dic[@"roomId"] longLongValue] callback:^(int code, NSString *strMsg, ApiLeaveRoomModel *model) {
            }];
        }
    }
}

///主播关播
- (void)anchorCloseLiveRoom{
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"正在关闭房间")];
    if ([LiveManager liveInfo].liveType == LiveTypeForMPAudioLive) { //语音
        [HttpApiHttpVoice closeVoiceLive:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiCloseLiveModel *model) {
            [SVProgressHUD dismiss];
            if (code == 7201) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
                [LiveComponentMsgMgr sendMsg:LM_LiveLeaveInfo msgDic:model ? @{@"model":model} : nil];
            }
        }];
    }else{ ///直播和直播购
        [HttpApiHttpLive closeLive:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiCloseLiveModel *model) {
            [SVProgressHUD dismiss];
            if (code == 7201) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
                [LiveComponentMsgMgr sendMsg:LM_LiveLeaveInfo msgDic:model ? @{@"model":model} : nil];
            }
        }];
    }
}

- (void)anchorLevelRequest{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:[NSString stringWithFormat:kLocalizationMsg(@"当前有%d位观众正在观看你的表演，是否结束直播？"),[LiveManager liveInfo].roomModel.watchNumber]];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
        [weakself anchorCloseLiveRoom];
    }];
    [_superVC presentViewController:alertVC animated:YES completion:nil];
}



///用户离开房间
- (void)userLevelRequest{
    if ([LiveManager liveInfo].liveType == LiveTypeForMPAudioLive) {
        [HttpApiHttpVoice leaveVoiceRoomOpt:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiLeaveRoomModel *model) {
            [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
        }];
    }else{ ///直播和直播购
        [HttpApiHttpLive leaveRoomOpt:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiLeaveRoomModel *model) {
            [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
        }];
    }
}

@end
