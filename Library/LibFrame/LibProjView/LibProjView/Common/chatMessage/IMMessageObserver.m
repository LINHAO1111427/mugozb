//
//  IMMessageObserver.m
//  LibProjView
//
//  Created by klc_sl on 2021/7/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "IMMessageObserver.h"
#import <TXImKit/TXImKit.h>
#import <LibProjBase/ProjBaseData.h>
#import <LibProjBase/PlayAudio.h>

@interface IMMessageObserver ()<ImMsgHander,ImConversationHander>

@property (nonatomic, copy) NSDictionary<NSString *, id<IMObserverDelegate>> *delegateDic;

@end

@implementation IMMessageObserver

+ (instancetype)share{
    static IMMessageObserver *_imObserver = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_imObserver) {
            _imObserver = [[IMMessageObserver alloc] init];
        }
    });
    return _imObserver;
}


+ (void)onImHandle{
    [IMSocketIns addImHander:[IMMessageObserver share]];
    [[IMSocketIns getIns] addConversantionHander:[IMMessageObserver share]];
}

+ (void)addDelegate:(id<IMObserverDelegate>)delegate{
    [[IMMessageObserver share] handleDelegate:delegate addOrRemove:YES];
}

+ (void)removeDelegate:(id<IMObserverDelegate>)delegate{
    [[IMMessageObserver share] handleDelegate:delegate addOrRemove:NO];
}

- (void)handleDelegate:(id<IMObserverDelegate>)delegate addOrRemove:(BOOL)isAdd{
    NSString *observerKey = [NSString stringWithFormat:@"%@_%zi",NSStringFromClass(delegate.class),delegate.hash];
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    [muDic addEntriesFromDictionary:self.delegateDic];
    
    if (isAdd) { ///添加
        [muDic setObject:delegate forKey:observerKey];
    }else{ ///删除
        [muDic removeObjectForKey:observerKey];
    }
    self.delegateDic = [muDic copy];
}


#pragma mark  - ImMsgHander -
///接受消息
-(void)onReceiveImMsg:(ImMessage*)imMsg{
    if ([ProjBaseData share].enableNotifyVoice) {
        [[PlayAudio share] callMSGPlay];
        [[PlayAudio share] callMsgShark];
    }
    [self.delegateDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<IMObserverDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(onReceiveMessage:)]) {
            [obj onReceiveMessage:imMsg];
        }
    }];
}

- (void)onRecvRevokedMsg:(NSString *)msgId{
    if (msgId.length > 0) {
        [self.delegateDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<IMObserverDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:@selector(onUpdateRevokMessage:)]) {
                [obj onUpdateRevokMessage:msgId];
            }
        }];
    }
}
- (void)onRecvSingleChatReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList{
    if ([[ProjConfig shareInstence].baseConfig msgHasReadInfo]) {
        NSString *userOrGroupId;
        for (V2TIMMessageReceipt *receipt in receiptList) {
            if (receipt.groupID.length > 0) {
                userOrGroupId = receipt.groupID;
            }else{
                userOrGroupId = receipt.userID;
            }
            [self.delegateDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<IMObserverDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([obj respondsToSelector:@selector(onUpdateReadMessage:)]) {
                    [obj onUpdateReadMessage:userOrGroupId];
                }
            }];
        }
 
        
    }
}
- (void)onReceiveGrupEventData:(NSString *)groupID data:(NSData *)data{
   // NSLog(@"过滤文字####【IM警告】####  群事件未处理 groupID == %@ data == %@"),groupID,data.jsonValue);
    [self.delegateDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<IMObserverDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
         
    }];
     
}
- (void)onImMsgStatusChange:(int)code message:(V2TIMMessage *)message groupOrUid:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg note:(NSString *)note{
    if (code == 0) {
        [SVProgressHUD showErrorWithStatus:note];
    }
    [self.delegateDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<IMObserverDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(onSendMessageResponse:)]) {
            ImMessage *msg = [[ImMessage alloc]initWith:message];
            [obj onSendMessageResponse:msg];
        }
    }];
}
 
 
 
 

#pragma mark - ImConversationHander
/// 有新的会话
/// @param conversationList 会话列表
- (void)ImNewConversationIn:(NSArray<V2TIMConversation*> *) conversationList{
    [self.delegateDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<IMObserverDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(onConversationChanged:)]) {
            [obj onConversationChanged:conversationList];
        }
    }];
}


/// 会话消息发生改变
/// @param conversationList 会话列表
- (void)ImConversationChanged:(NSArray<V2TIMConversation*> *) conversationList{
    [self.delegateDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<IMObserverDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(onConversationChanged:)]) {
            [obj onConversationChanged:conversationList];
        }
    }];
}
@end
