//
//  ChatGiftSocketTool.m
//  Message
//
//  Created by klc_tqd on 2020/5/21.
//  Copyright © 2020 . All rights reserved.
//

#import "ChatGiftSocketTool.h"

#import <LibTools/LibTools.h>

#import <LibProjView/ChoiceGiftView.h>
#import <LibProjView/GiftUserModel.h>
#import <LibProjView/PLayGiftAnimationObj.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/OOOReturnModel.h>
#import <libProjModel/HttpApiHttpLive.h>
#import <libProjModel/HttpApiHttpLive.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/ApiBaseEntityModel.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <TXImKit/TXImKit.h>
#import <LibProjView/ShowGiftAnimationView.h>

@interface ChatGiftSocketTool ()
// 动画礼物
@property(nonatomic, weak)ShowGiftAnimationView *playView;
///送礼人
@property (nonatomic, copy)NSArray<GiftUserModel *> *currentGiftUsers;
//选择礼物视图
@property (nonatomic, weak)ChoiceGiftView *giftV;
///送礼ID
@property (nonatomic, assign)int64_t sendMsgId;
///聊天类型
@property (nonatomic, assign)ConversationChatForType chatType;

@end

@implementation ChatGiftSocketTool

- (void)chatSocketToolParInit:(UIView *)superView sendMsgId:(int64_t)sendMsgId chatType:(ConversationChatForType)chatType{
    [self showGiftView:superView];
    self.sendMsgId = sendMsgId;
    self.chatType = chatType;
    [[IMSocketIns getIns] addReceiver:socketGroupMessage receiver:self];
}


// MARK: - Socket
// MARK: 收到送礼物消息
/**
 全直播间飘屏信息
 @param apiGiftSender null
 */
- (void)onGiftMsgAll:(ApiGiftSenderModel *)apiGiftSender {
    if (self.chatType == ConversationChatForSignle) { ///单聊
        if (apiGiftSender.anchorId == KLCUserInfo.getUserId || apiGiftSender.userId == KLCUserInfo.getUserId) {
            [self.playView playAnimationEffect:apiGiftSender];
        }
    }else{ ///群聊
        if (apiGiftSender.roomId == self.sendMsgId) {
            [self.playView playAnimationEffect:apiGiftSender];
        }
    }
}

///单聊
- (void)onGiveGiftUser:(ApiGiftSenderModel *)apiGiftSender {
    if (apiGiftSender.anchorId == self.sendMsgId || apiGiftSender.userId == self.sendMsgId) {
        if (apiGiftSender.giftswf.length > 0) {
            [self.playView playAnimationEffect:apiGiftSender];
        }
        [self.playView showGiftBanner:apiGiftSender];
    }
}

/**
 群聊送礼物发送socket
 @param apiGiftSender null
 */
-(void) onGroupGiveGift:(ApiGiftSenderModel* )apiGiftSender{
    if (apiGiftSender.roomId == self.sendMsgId) {
        if (apiGiftSender.giftswf.length > 0) {
            [self.playView playAnimationEffect:apiGiftSender];
        }
        [self.playView showGiftBanner:apiGiftSender];
    }
}



-(void)removeMessageSocket{
    [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupMessage];
}


-(void)showGiftView:(UIView *)superView{
    if (!_playView) {
        ShowGiftAnimationView *playV = [[ShowGiftAnimationView alloc] initWithFrame:superView.frame];
        [superView addSubview:playV];
        _playView = playV;
    }
}


@end
