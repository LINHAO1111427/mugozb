//
//  KlcUnreadMessageManeger.h
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageNoReadSocketTool : NSObject


+ (instancetype)share;

///更新未读数
@property (nonatomic,copy) void(^unReadTotalNumBlock)(int64_t noReadNum);

///更新消息列表
@property (nonatomic,copy) void(^reloadMsgListBlock)(void);


- (void)MessageNoReadSocketToolParInit;


- (void)removeMessageSocket;

///获得所有未读信息
- (void)getAppSystemNoReadData;

///清楚已读信息
- (void)clearAllUnreadMessage;

///一键删除
- (void)deleteAllConversationAndMsgs;





@end

NS_ASSUME_NONNULL_END
