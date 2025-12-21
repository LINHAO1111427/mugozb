//
//  ChatFamilyMsgSocketTool.m

//  MessageInfo
//
//  Created by klc_sl on 2021/8/10.
//

#import "ChatFamilyMsgSocketTool.h"
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "MsgTopMessageView.h"
#import <LibProjModel/AppFamilyChatroomInfoVOModel.h>
#import "FamilyNoticeTipView.h"
#import <LibProjView/ScreenfloatForRichmanJoinObj.h>
#import <LibProjView/PLayVIPJoinObj.h>


@interface ChatSendSocketBgView : UIView
@end
@implementation ChatSendSocketBgView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}

@end


@interface ChatFamilyMsgSocketTool ()<MsgTopMessageDelegate>

@property (nonatomic, weak)ChatSendSocketBgView *showBgView;
///置顶
@property (nonatomic, weak)MsgTopMessageView *topView;
///VIP
@property (nonatomic, copy)PLayVIPJoinObj *playVIPObj;
///土豪进场
@property (nonatomic, copy)ScreenfloatForRichmanJoinObj *richJionObj;

@property (nonatomic, assign)int64_t groupId;

@end

@implementation ChatFamilyMsgSocketTool

- (void)chatSocketToolParInit:(UIView *)superView groupId:(int64_t)groupId{
    {
        ChatSendSocketBgView *showBgView = [[ChatSendSocketBgView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, superView.height-kNavBarHeight)];
        [superView addSubview:showBgView];
        self.groupId = groupId;
        self.showBgView = showBgView;
    }
    [[IMSocketIns getIns] addReceiver:socketGroupMessage receiver:self];
}

- (void)setChatGroupInfo:(AppFamilyChatroomInfoVOModel *)chatGroupInfo{
    _chatGroupInfo = chatGroupInfo;
    
    
}


- (void)removeMessageSocket{
    [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupMessage];
}


/**
 更换置顶消息
 @param appChatFamilyMsgTopVO null
 */
- (void)sendTopMsgToFamily:(AppChatFamilyMsgTopVOModel* )appChatFamilyMsgTopVO{
    self.topView.msgModel = appChatFamilyMsgTopVO;
}



/**
 聊天家族发送进场消息
 @param appJoinRoomMsgVO null
 */
- (void)sendJoinRoomMsg:(AppJoinChatRoomMsgVOModel* )appJoinRoomMsgVO{
    if (appJoinRoomMsgVO.familyId == self.groupId) {
        [self.playVIPObj playVIJoinMsgInfo:appJoinRoomMsgVO];
    }
}



/**
 聊天家族发送土豪进场消息
 @param appJoinRoomMsgVO null
 */
- (void)sendLocalTyrantJoinRoomMsg:(AppJoinChatRoomMsgVOModel* )appJoinRoomMsgVO{
    if (appJoinRoomMsgVO.familyId == self.groupId) {
        [self.richJionObj playRichManJoinMsgView:appJoinRoomMsgVO];
    }
}


///更新第一名
- (void)sendFamilyFirstUser:(int64_t)familyId contributionFirstAvatar:(NSString *)contributionFirstAvatar{
    if (self.delegate && self.groupId == familyId) {
        [self.delegate chatFamilyMsg:self updateTopUser:contributionFirstAvatar];
    }
}


#pragma mark - MsgTopMessageDelegate -
- (void)msgTopMessageForUserInfoClick:(MsgTopMessageView *)topMsg{
    ///点击用户头像
    if (self.delegate) {
        [self.delegate chatFamilyMsg:self userInfoClick:topMsg.msgModel];
    }
}


#pragma mark - handle -
- (void)showJoinInfo:(AppFamilyChatroomInfoVOModel *)joinModel{
    _chatGroupInfo = joinModel;
    self.topView.msgModel = joinModel.appChatFamilyMsgTopVO;
    
    if (joinModel.isShowProclamation == 0 && joinModel.familyProclamation.length > 0) {
        [FamilyNoticeTipView show:joinModel.familyProclamation];
    }
    
}



#pragma mark - lazy -
- (MsgTopMessageView *)topView{
    if (!_topView) {
        MsgTopMessageView *topV = [[MsgTopMessageView alloc] init];
        topV.hidden = YES;
        [self.showBgView addSubview:topV];
        _topView = topV;
        [topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.showBgView);
            make.left.right.equalTo(self.showBgView);
        }];
    }
    return _topView;
}

- (PLayVIPJoinObj *)playVIPObj{
    if (!_playVIPObj) {
        _playVIPObj = [[PLayVIPJoinObj alloc] initWithSuperView:self.showBgView];
    }
    return _playVIPObj;
}

- (ScreenfloatForRichmanJoinObj *)richJionObj{
    if (!_richJionObj) {
        _richJionObj = [[ScreenfloatForRichmanJoinObj alloc]initWithSuperView:self.showBgView];
    }
    return _richJionObj;
}

@end
