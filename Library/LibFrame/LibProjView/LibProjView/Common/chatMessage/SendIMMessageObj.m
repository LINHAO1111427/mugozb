//
//  SendIMMessageObj.m
//  LibProjView
//
//  Created by klc_sl on 2021/7/22.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SendIMMessageObj.h"
#import <TXImKit/TXImKit.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjModel/HttpApiChatRoomController.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/TipAlertView.h>
#import "IMMessageObserver.h"
#import <LibTools/LibTools.h>

@interface SendIMMessageObj ()<IMObserverDelegate>

///群组就是群组ID  单聊就是对方用户ID
@property (nonatomic, assign)int64_t messageId;

@property (nonatomic, assign)BOOL isGroup; ///当前消息是否是群组
/**
 如果是用户  UGID   =userId*2;
 如果是群组  UGID   =group*2+1;
 */
@property (nonatomic, assign)int64_t UGID;  ///用户或群组的

@end

@implementation SendIMMessageObj

- (void)dealloc
{
     
}

- (void)addMonitor:(int64_t)messageId isGroup:(BOOL)isGroup {
    _messageId = messageId;
    _isGroup = isGroup;
    if (_isGroup) {
        _UGID = messageId*2+1;
    }else{
        _UGID = messageId*2;
    }
    [IMMessageObserver addDelegate:self];
}

- (void)removeMonitor{
    [IMMessageObserver removeDelegate:self];
}


///发私信消息
- (void)sendMessageType:(IMMessageType)messageType customDict:(NSDictionary *)customDict muteMsg:(BOOL)muteMsg sendResult:(SendIMMessageBlock)resultBlock {
    if (self.messageId == 0) {
        return;
    }
    
    kWeakSelf(self);
    if (self.isGroup) {
        [SendIMMessageObj sendPrivateChatMessage:self.messageId messageType:messageType isGroup:YES customDict:customDict resultBlock:^(int code, NSString *strMsg) {
            [weakself sendContentForCustomDict:customDict messageType:messageType muteMsg:muteMsg sendResult:resultBlock];
        }];
        
    }else{
        [SendIMMessageObj sendPrivateChatMessage:self.messageId messageType:messageType isGroup:NO customDict:customDict resultBlock:^(int code, NSString *strMsg) {
            
            if (code == 1) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself sendContentForCustomDict:customDict messageType:messageType muteMsg:muteMsg sendResult:resultBlock];
                });
                 
            }else{
                ///处理其他信息
                if(code == 2){
                    //余额不足
                    [CustomPopUpAlert showLiveTypeForBalanceInsufficient];
                }else if(code == 3){
                    //贵族才能
                    [TipAlertView showTitle:kLocalizationMsg(@"您还不是贵族") subTitle:^(UILabel * _Nonnull subTitleL) {
                        subTitleL.text = kLocalizationMsg(@"无法进行私聊");
                    } sureBtnTitle:kLocalizationMsg(@"开通贵族") btnClick:^{
                        [RouteManager routeForName:RN_User_buyVIP currentC:[ProjConfig currentVC] parameters:nil];
                    } cancel:^{
                    }];
                }else if(code == 7300){ ///svip
                    [RouteManager routeForName:RN_center_svip currentC:[ProjConfig currentVC]];
                }else{
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
                
                if (resultBlock) {
                    resultBlock(NO);
                }
                
            }
        }];
    }
}


#pragma mark - 处理临时消息 -
///处理临时消息
- (void)handleTempMsg:(ImMessage *)imMsg isShow:(BOOL)isShow sendResult:(SendIMMessageBlock)resultBlock{
    if (isShow) {
        self.onSendIMMessage?self.onSendIMMessage(imMsg):nil;
        resultBlock?resultBlock(YES):nil;
    }else{
       // NSLog(@"过滤文字im 临时消息处理未实现"));
//        [[IMSocketIns getIns] deleteImMsg:imMsg.msgCId];
    }
}

///先保存临时消息
- (V2TIMMessage *)getTempMessage:(IMMessageType)messageType customDict:(NSDictionary *)customContentDict{
    NSDictionary *sendDic = [SendIMMessageObj getSendDict:messageType param:customContentDict];
   // NSLog(@"过滤文字###IM注意##### 保存临时消息未实现 == %@"),sendDic);
    
    /*
    ImSendResult *sendResult = [[IMSocketIns getIns] saveImMsg:self.messageId isGroupMsg:self.isGroup jsonMsgContent:sendDic updateLastMsg:NO];
    ImMessage *imMsg = sendResult.msg;

    ///保存扩充消息
    NSString *extMsg = [@{@"sendStatus":@(IMMessageSendStatusForCheck),@"hint":kLocalizationMsg(@"语音消息审核中，审核完成自动发出")} convertToJsonData];
    [[IMSocketIns getIns] setMsgExtraInfo:imMsg.msgCId msgExtraInfo:extMsg];
    imMsg.msgExtraInfo = extMsg;
    return imMsg;
     */
    return  nil;
}

#pragma mark - 发送自定义消息 -
-(void)sendContentForCustomDict:(NSDictionary *)customContentDict messageType:(IMMessageType)messageType muteMsg:(BOOL)muteMsg sendResult:(SendIMMessageBlock)resultBlock{
    
    NSDictionary *sendDic = [SendIMMessageObj getSendDict:messageType param:customContentDict];
    NSUInteger priority = 0;
    if (messageType == 1 || messageType == 4 || messageType == 5 || messageType == 6) {
        priority = 1;
    }
    ImSendResult *sendResult = [[IMSocketIns getIns] sendImMsg:self.messageId isGroupMsg:self.isGroup jsonMsgContent:sendDic isUnreadCountMsg:YES Priority:priority];
    V2TIMMessage *imMsg = sendResult.msg;
    ImMessage *message = [[ImMessage alloc]initWith:imMsg];
    if (message) {
        self.onSendIMMessage?self.onSendIMMessage(message):nil;
    }
    
    resultBlock?resultBlock((sendResult.code == 1)?YES:NO):nil;
 
}



#pragma mark - 类文件 -

//消息 付费判断
+ (void)sendPrivateChatMessage:(int64_t)messageId messageType:(IMMessageType)messageType isGroup:(BOOL)isGroup customDict:(NSDictionary *)customContentDict resultBlock:(void(^)(int code, NSString *strMsg))resultBlock{
    int msgType = 0;
    NSString *inputText = @"";
    switch (messageType) {
        case IMMessageTypeForPicture:
            inputText = customContentDict[@"picUrlStr"];
            msgType = 2;
            break;
        case IMMessageTypeForAudio:
            inputText = customContentDict[@"recordUrl"];
            msgType = 3;
            break;
        case IMMessageTypeForVideo:
            msgType = 2;
            break;
        case IMMessageTypeFor1v1Voice:
        case IMMessageTypeFor1v1Video:
        {
            ///0- 接通了  time  时长 1 - 取消  2 - 被挂断   3 - 未接
            NSString *otoStatusStr = @"";
            switch ([customContentDict[@"status"] intValue]) {
                case 0:
                    otoStatusStr = [NSString stringWithFormat:kLocalizationMsg(@"通话时长%@"),customContentDict[@"time"]];
                    break;
                case 1:
                    otoStatusStr = kLocalizationMsg(@"已取消");
                    break;
                case 2:
                    otoStatusStr = kLocalizationMsg(@"已被挂断");
                    break;
                case 3:
                    otoStatusStr = kLocalizationMsg(@"无人接听");
                    break;
                default:
                    break;
            }
            inputText = [NSString stringWithFormat:@"%@:%@",customContentDict[@"title"],otoStatusStr];
            msgType = 4;
            break;
        }
        case IMMessageTypeForText:
            msgType = 1;
            inputText = customContentDict[@"txt"];
            break;
        case IMMessageTypeForGift:
            msgType = 5;
            inputText = [NSString stringWithFormat:kLocalizationMsg(@"送TA%d个%@"),[customContentDict[@"giftNumber"] intValue],customContentDict[@"giftName"]];
            break;
        case IMSystemMsgTypeForGroupRedPt:
        case IMMessageTypeForRedPack:
            msgType = 6;
            inputText = [NSString stringWithFormat:kLocalizationMsg(@"送TA%0.0lf%@"),[customContentDict[@"redEnvelopeValue"] doubleValue],kUnitStr];
            break;
        default:
            msgType = 0;
            break;
    }
    ///1文本，2单张图片，3语音，4语音视频通话
    int64_t touid = isGroup?0:messageId;
    NSString *content = inputText.length?inputText:@"";
    int64_t msgCid = [customContentDict[@"msgCid"] longLongValue];
    int voiceTime = [customContentDict[@"time"] intValue];
    int64_t groupId = isGroup?messageId:0;
    [HttpApiChatRoomController sendChatMsg:content groupId:groupId msgCid:msgCid msgType:msgType touid:touid voiceTime:voiceTime callback:^(int code, NSString *strMsg, SingleStringModel *model) {
        if (resultBlock) {
            resultBlock(code, strMsg);
        }
    }];
}


///将要发送的信息转换成可读发送信息
+ (NSDictionary *)getSendDict:(IMMessageType)messageType param:(NSDictionary *)param{
    ///集合参数
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [muDic setObject:kStringFormat(@"%zi",messageType) forKey:@"messageType"];
    if (param.count > 0) {
        NSString *jsonString = [self dataToString:param];
        [muDic setObject:jsonString forKey:@"messageContent"];
        [muDic setObject:@"1" forKey:@"isChatRecord"];
    }
    return [muDic copy];
}

+ (NSString*)dataToString:(id)objct
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objct options:0 error:&error];
    if (!jsonData) {
       // NSLog(@"过滤文字sorry you get an error:%@"),error);
    }
    else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


#pragma mark  - IMObserverDelegate -

/// 发送消息结果返回回调
- (void)onSendMessageResponse:(ImMessage *)message{
    if (self.onUpdateIMMessage) {
        self.onUpdateIMMessage(IMMessageUpDateTypeForStatus, @"", message);
    }
}

/// 接收消息(服务器端下发的)回调
- (void)onReceiveMessage:(ImMessage *)message{
    if (self.onReceiveIMMessage) {
        self.onReceiveIMMessage(message);
    }
}

- (void)onUpdateMessage:(ImMessage *)message {
    if (self.onUpdateIMMessage) {
        self.onUpdateIMMessage(IMMessageUpDateTypeForOther, @"", message);
    }
    
}
- (void)onUpdateReadMessage:(NSString *)userOrGroupId{
    if (self.onUpdateIMMessage) {
        self.onUpdateIMMessage(IMMessageUpDateTypeForRead, userOrGroupId, nil);
    }
}
- (void)onUpdateRevokMessage:(NSString *)msgId{
    if (self.onUpdateIMMessage) {
        self.onUpdateIMMessage(IMMessageUpDateTypeForRevoke, msgId, nil);
    }
}
@end







@implementation IMInfoManager


///删除某个用户的信息
+ (void)deleteUserExtraInfo:(int64_t)userId{
    ///如果是用户  UGID   =userId*2;
    [[IMSocketIns getIns] delExtraInfo:userId*2];
}

///删除家族群组信息
+ (void)deleteFamilyGroupExtraInfo:(int64_t)groupId{
    ///如果是群组  UGID   =group*2+1;
    [[IMSocketIns getIns] delExtraInfo:groupId*2+1];
}

///删除粉丝团群组信息
+ (void)deleteFansGroupExtraInfo:(int64_t)anchorId{
   ///粉丝团 UGID（5亿+粉丝团ID）*2+1;
    [[IMSocketIns getIns] delExtraInfo:(500000000+anchorId)*2+1];
}

@end
