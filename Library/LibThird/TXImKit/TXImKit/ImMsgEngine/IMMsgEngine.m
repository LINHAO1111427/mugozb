//
//  IMMsgEngine.m
//  IMSocket
//
//  Created by wy on 2020/7/15.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ImMsgEngine.h"
#import "ImDataBase.h"
#import "ImMessage.h"
#import "NSDictionary+Json.h"
#import "ImSendResult.h"

#define kLocalizationMsg(key) NSLocalizedString(key, nil)
@import ImSDK_Plus;

static ImMsgEngine* _msgEngine = nil;
static id<ImMsgHander>  _imHander = nil;

///IMMsg消息接收
@interface ImMsgEngine ()
@property (nonatomic, strong)ImDataBase *db;
@property (nonatomic, assign) int64_t  uid;
@property (nonatomic, assign) Boolean  isPostReLoad;
@property (nonatomic, assign) int64_t  postReLoadCount;
 
@end

@implementation ImMsgEngine

+(ImMsgEngine*)getIns{
    return _msgEngine;
}

+(void)setImHandle:(id<ImMsgHander>)hander{
    _imHander=hander;
    if(hander==nil){
        return;
    }
}

- (void)initIns:(int64_t)uid{
    _msgEngine=self;
    _postReLoadCount=0;
    _isPostReLoad=NO;
    _uid = uid;
    _db = [[ImDataBase alloc] init];
    [_db createDB:uid];
    
}

-(void)closeDb{
    if(_db!=nil){
        [_db closeDB];
    }
}


-(void)onReceivedMsg:(V2TIMMessage*)dicMsg{
    if (dicMsg != nil) {
        ImMessage *msg = [[ImMessage alloc]initWith:dicMsg];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(_imHander!=nil){
                [_imHander onReceiveImMsg:msg];
            }
        });
    }
}

///收到回撤消息
- (void)onRecvRevokedMsg:(NSString *)msgID{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_imHander!=nil)
        {
            [_imHander onRecvRevokedMsg:msgID];
        }
    });
}
///消息已读通知
- (void)onRecvSingleChatReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_imHander!=nil)
        {
            [_imHander onRecvSingleChatReadReceipt:receiptList];
        }
    });
}
/// 收到群事件消息
/// @param groupID 群组ID
/// @param data 数据
- (void)onReceiveGrupEventData:(NSString *)groupID data:(NSData *)data{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_imHander!=nil){
            [_imHander onReceiveGrupEventData:groupID data:data];
        }
    });
}
 
/// 发送自定义IM消息
/// @param groupOrUid 用户或者群组ID
/// @param isGroupMsg 是否是群组
/// @param jsonMsgContent 消息内容
/// @param isUnreadCountMsg 是否计入已读未读数
/// @param Priority 消息优先级
-(ImSendResult*)sendImMsg:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg jsonMsgContent:(NSDictionary*)jsonMsgContent isUnreadCountMsg:(Boolean)isUnreadCountMsg Priority:(GroupMsgPriority)Priority{
    NSString *strMsgContent=nil;
    if (jsonMsgContent != nil) {
        strMsgContent=   [jsonMsgContent toStr];
    }
    
    if ( [strMsgContent length] > 4000) {
        ImSendResult* result= [[ImSendResult alloc] init];
        result.code=2;
        result.err=kLocalizationMsg(@"信息最长4000个字节");
        return result;
    }
    
    if(strMsgContent==nil || [strMsgContent length]==0){
        ImSendResult* result=[ImSendResult new];
        result.code=3;
        result.err=kLocalizationMsg(@"不能发送空消息！");
        return result;
    }
    
    if(isGroupMsg==NO && _uid==groupOrUid){
        ImSendResult* result=[ImSendResult new];
        result.code=5;
        result.err=kLocalizationMsg(@"不能给自己发消息！");
        return result;
    }
    
     
    NSError *parseError;
    NSDictionary*mapMsg = jsonMsgContent;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mapMsg options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
        ImSendResult *result =  [[ImSendResult alloc] init];
        result.code = 0;
        result.err = kLocalizationMsg(@"消息解析失败");
        return result;
    }
    
    __block V2TIMMessage *msg = [[V2TIMManager sharedInstance] createCustomMessage:jsonData];
    msg.isExcludedFromUnreadCount = !isUnreadCountMsg;
    NSString *userId = @"";
    NSString *groupId = @"";
    if (isGroupMsg) {
        groupId = [NSString stringWithFormat:@"%lld",groupOrUid];
    }else{
        userId = [NSString stringWithFormat:@"%lld",groupOrUid];
    }
    
    [[V2TIMManager sharedInstance]  sendMessage:msg receiver:userId groupID:groupId priority:Priority onlineUserOnly:NO offlinePushInfo:nil progress:nil succ:^{
        if(_imHander!=nil){
            [_imHander onImMsgStatusChange:1 message:msg groupOrUid:groupOrUid isGroupMsg:isGroupMsg note:@""];
        }
    } fail:^(int code, NSString *desc) {
       // NSLog(@"过滤文字####【TXImKit】#### - 消息发送失败 desc == %@"),desc);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(_imHander!=nil){
                [_imHander onImMsgStatusChange:0 message:msg groupOrUid:groupOrUid isGroupMsg:isGroupMsg note:desc];
            }
        });
    }];
        
    ImSendResult* result= [[ImSendResult alloc] init];
    result.code = 1;
    result.msg = msg;
    result.err = @"";
    return result;
}

@end
