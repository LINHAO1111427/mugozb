//
//  LiveGiftComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/25.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveGiftComponent.h"

#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentInterface.h>

#import <TXImKit/TXImKit.h>
#import <LiveCommon/LiveManager.h>
 
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgListener.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiPkResultModel.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <LibProjView/AddWishGiftView.h>
 
#import <LibProjView/ChoiceGiftView.h>
#import <LibProjView/GiftUserModel.h>
#import <LibProjView/PLayGiftAnimationObj.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <LibProjView/ShowGiftAnimationView.h>

@interface LiveGiftComponent()<LiveComponentInterface,LiveComponentMsgListener>

/// 第三层
@property(nonatomic,weak) UIView *thirdView;
/// 第四层
@property(nonatomic,weak) UIView *fourthView;

@property (nonatomic, weak) ShowGiftAnimationView *showGiftV;  ///显示礼物视图

@property (nonatomic, copy) NSArray<GiftUserModel *> *currentGiftUsers;   ///送礼人
@property (nonatomic, weak) ChoiceGiftView *giftV;  //选择礼物视图

@end

@implementation LiveGiftComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
    [_showGiftV removeFromSuperview];
    _showGiftV = nil;
}

// MARK: - Init
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    _thirdView = views[2];
    _fourthView = views[3];
    
    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
            
        case LM_ShowGiftView:{
            [self showGiftSelectView];
        }
            break;
            
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{
            _currentGiftUsers = nil;
            [_showGiftV removeAllSubViews];
            _showGiftV = nil;
        }
            break;
        case LM_AddSendGiftUser:   ///添加送礼人
        {
            [self updateGiftUser:msgDic[@"model"] isAdd:YES];
        }
            break;
        case LM_RemoveSendGiftUser:   ///删除送礼人
        {
            [self updateGiftUser:msgDic[@"model"] isAdd:NO];
        }
            break;
        case LM_LiveRoomInfo:
        {
            [self addAnchorSend];
        }
            break;
            ///变更送礼人
        case LM_ChangeAllSendGiftUser:
        {
            [self changeGiftUser:msgDic[@"models"]];
        }
            break;
        case LM_UserAskGift:
        {
            [self userAskGift];
        }
            break;
        default:
            break;
    }
}


- (void)addAnchorSend{
    if ([LiveManager liveInfo].anchorId > 0) {
        GiftUserModel *model = [[GiftUserModel alloc] init];
        model.userId = [LiveManager liveInfo].anchorId;
        model.userName = [LiveManager liveInfo].anchorName;
        model.userIcon = [LiveManager liveInfo].anchorIcon;
        model.isAnchor = YES;
        model.roomId = [LiveManager liveInfo].roomId;
        model.anchorId = [LiveManager liveInfo].anchorId;
        model.showId = [LiveManager liveInfo].serviceShowId;
        [LiveComponentMsgMgr sendMsg:LM_AddSendGiftUser msgDic:@{@"model":model}];
    }
}

///求赏
- (void)userAskGift{
    [AddWishGiftView addWishGift:NO sureTitle:kLocalizationMsg(@"求赏") selectGiftBack:^(NobLiveGiftModel * _Nonnull giftModel, int selectNum) {
        [HttpApiNobLiveGift sendAskForAReward:1 nobGiftId:giftModel.id_field roomId:[LiveManager liveInfo].roomId toUserId:0 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
}

// MARK: - Socket
// MARK: 收到送礼物消息
/**
 全直播间飘屏信息
 @param apiGiftSender null
 */
- (void)onGiftMsgAll:(ApiGiftSenderModel *)apiGiftSender {
    if (apiGiftSender.anchorId == [LiveManager liveInfo].anchorId) {
        [LiveComponentMsgMgr sendMsg:LM_AnchorGiftNumber msgDic:@{@"votes":@(apiGiftSender.votes)}];
    }
    
    if (apiGiftSender.roomId == [LiveManager liveInfo].roomId) {
        [self.showGiftV playAnimationEffect:apiGiftSender];
    }
}

- (void)onGiveGift:(ApiGiftSenderModel *)apiGiftSender{
   // NSLog(@"过滤文字收到礼物socket回调 %s"),__func__);
   // NSLog(@"过滤文字魅力值 %0.0lf"),apiGiftSender.votes);
    if (apiGiftSender.anchorId == [LiveManager liveInfo].anchorId) {
        [LiveComponentMsgMgr sendMsg:LM_AnchorGiftNumber msgDic:@{@"votes":@(apiGiftSender.votes)}];
    }
    
    [self.showGiftV showGiftBanner:apiGiftSender];
    [self.showGiftV playAnimationEffect:apiGiftSender];
}

// MARK: 收到礼物的消息
- (void)onSimpleGiftMsgRoom:(ApiSimpleMsgRoomModel *)apiSimpleMsgRoom {
    if (apiSimpleMsgRoom.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_MessageForOther msgDic:@{@"model":apiSimpleMsgRoom}];
}


- (void)onGiftPKResult:(ApiPkResultModel *)apiPKResult{
    [LiveComponentMsgMgr sendMsg:LM_ChangePKValue msgDic:@{@"model":apiPKResult}];
}


- (void)showGiftSelectView{
    [ChoiceGiftView showGift:[LiveManager liveInfo].serviceLiveType users:_currentGiftUsers hasContinue:YES sendSuccess:nil];
}

- (void)updateGiftUser:(GiftUserModel *)userModel isAdd:(BOOL)add{
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    if (add) {
        [muArr addObject:userModel];
    }
    for (GiftUserModel *subModel in _currentGiftUsers) {
        if (subModel.userId != userModel.userId) {
            [muArr addObject:subModel];
        }
    }
    _currentGiftUsers = muArr;
    
}

- (void)changeGiftUser:(NSArray<GiftUserModel *> *)users{
    _currentGiftUsers = users;
}

- (ShowGiftAnimationView *)showGiftV{
    if (!_showGiftV) {
        ShowGiftAnimationView *showGiftV = [[ShowGiftAnimationView alloc] initWithFrame:_thirdView.bounds];
        showGiftV.bannerSuperV = _fourthView;
        [_thirdView addSubview:showGiftV];
        _showGiftV = showGiftV;
    }
    return _showGiftV;
}

@end
