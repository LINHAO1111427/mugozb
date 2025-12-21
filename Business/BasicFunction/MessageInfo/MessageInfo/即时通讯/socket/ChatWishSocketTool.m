//
//  ChatWishSocketTool.m
//  Message
//
//  Created by klc_tqd on 2020/5/27.
//  Copyright © 2020 . All rights reserved.
//

#import "ChatWishSocketTool.h"
#import <LibTools/LibTools.h>
 
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/OOOReturnModel.h>
#import <libProjModel/HttpApiHttpLive.h>
#import <libProjModel/HttpApiHttpLive.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/ApiBaseEntityModel.h>
#import <LibProjModel/HttpApiNobLiveGift.h>

@implementation ChatWishSocketTool

- (void)chatSocketToolParInit{
    [[IMSocketIns getIns] addReceiver:socketGroupMessage receiver:self];
}

/** 心愿单设置成功推给房间 */
-(void) onSendWish:(NSMutableArray<ApiUsersLiveWishModel *> *)awList{
    if (self.ChatWishListBlock) {
        self.ChatWishListBlock(awList);
    }
}


/** 心愿单设置成功推给单聊 */
-(void) onSendWishUser:(NSMutableArray<ApiUsersLiveWishModel *> *)awList{
    if (self.ChatWishListBlock) {
        self.ChatWishListBlock(awList);
    }
}
  

/**
 主播收到心愿单礼物后推送给群成员
 @param list null
 */
-(void) onUserAddWishMsg:(NSMutableArray<ApiUsersLiveWishModel*>* )list{
    if (self.ChatWishListBlock) {
        self.ChatWishListBlock(list);
    }
}

/**
 主播收到心愿单礼物后推送给用户 
 @param list null
 */
-(void) onUserAddWishMsgUser:(NSMutableArray<ApiUsersLiveWishModel*>* )list{
    if (self.ChatWishListBlock) {
        self.ChatWishListBlock(list);
    }
}


-(void)removeMessageSocket{
    [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupMessage];
}
@end
