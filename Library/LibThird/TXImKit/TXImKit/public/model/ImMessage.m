//
//  ImMessage.m
//  IMSocket
//
//  Created by wy on 2020/7/14.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ImMessage.h"
#import "ImDataBase.h"

@implementation ImMessage
- (instancetype)initWith:(V2TIMMessage *)message{
    self = [super init];
    if (self) { 
        self.tx_message = message;
        self.isCancelMsg = message.status == V2TIM_MSG_STATUS_LOCAL_REVOKED ? 1:0;
        self.readStatus = message.isRead;
        self.msgIsRead = message.isPeerRead;
        if (message.status == V2TIM_MSG_STATUS_SENDING) {
            self.sendStatus = 999;
        }else if(message.status == V2TIM_MSG_STATUS_SEND_SUCC){
            self.sendStatus = 1;
        }else{
            self.sendStatus = 0;
        }
        
        ImExtraInfo *info;
        ImExtraInfo *senderInfo = [[ImDataBase getIns] getExtraInfo:[message.sender intValue]];
        if (message.groupID.length > 0) {
            info = [[ImDataBase getIns] getExtraInfo:[message.groupID intValue]];
        }else{
            info = [[ImDataBase getIns] getExtraInfo:[message.userID intValue]];
        }
        
        if (info) {
            self.userInfo_updateTime = info.extraInfoUpdateTime;
            self.userInfo = info.extraInfo;
        }
        
        if (senderInfo) {
            self.senderUserInfo_updateTime = senderInfo.extraInfoUpdateTime;
            self.senderInfo = senderInfo.extraInfo;
        }
         
    }
    return self;
}
@end
 
