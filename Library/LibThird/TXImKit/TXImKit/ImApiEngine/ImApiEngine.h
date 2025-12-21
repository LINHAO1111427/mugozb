//
//  ImApiEngine.h
//  IMSocket
//
//  Created by wy on 2020/7/15.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMReceiver.h"



NS_ASSUME_NONNULL_BEGIN
@import ImSDK_Plus;

@interface ImApiEngine : NSObject

+(ImApiEngine*)getIns;


/// 初始化
/// @param uid 用户ID
-(void)initIns:(int64_t)uid;


/// 接收socket消息
/// @param dicMsg 消息体
-(void)onReceivedMsg:(V2TIMMessage*)dicMsg;


/// 添加监听，并归类到组
/// @param groupID 分组ID
/// @param receiver 接收者
-(void)addReceiver:(NSString*)groupID  receiver:(id<IMReceiver>)receiver;


/// 移除监听
/// @param groupID 分组ID
-(void)removeReceiverByGroupID:(NSString*)groupID;


/// 移除所有监听
-(void)removeAllReceiver;

@end

NS_ASSUME_NONNULL_END
