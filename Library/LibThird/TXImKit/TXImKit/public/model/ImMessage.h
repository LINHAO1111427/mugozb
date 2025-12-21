//
//  ImMessage.h
//  IMSocket
//
//  Created by wy on 2020/7/14.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
 

NS_ASSUME_NONNULL_BEGIN
@import ImSDK_Plus;

@interface ImMessage : NSObject
 
@property (nonatomic, assign)  int msgIsRead;//消息是否已读
@property (nonatomic, assign)  int sendStatus;//发送状态
@property (nonatomic, assign)  int readStatus;//阅读状态
@property (nonatomic, assign)  int isCancelMsg;//是否是回撤消息

///消息实体
@property (nonatomic, strong) V2TIMMessage * tx_message;

///用户信息
@property (nonatomic, strong) NSDictionary* userInfo;//用户信息
@property (nonatomic, strong) NSDictionary* senderInfo;//发送者信息
@property (nonatomic, strong) NSDate* userInfo_updateTime;//用户更新时间
@property (nonatomic, strong) NSDate* senderUserInfo_updateTime;//发送者信息更新时间


/// 初始化immessage
/// @param message 信息
- (instancetype)initWith:(V2TIMMessage*)message;
@end

NS_ASSUME_NONNULL_END
