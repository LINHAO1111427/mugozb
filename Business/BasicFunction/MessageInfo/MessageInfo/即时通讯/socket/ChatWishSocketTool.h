//
//  ChatWishSocketTool.h
//  Message
//
//  Created by klc_tqd on 2020/5/27.
//  Copyright © 2020 . All rights reserved.
//
#import <Foundation/Foundation.h>
#import <LibProjModel/IMRcvLiveWishSend.h>
#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <TXImKit/TXImKit.h>


NS_ASSUME_NONNULL_BEGIN
 
@interface ChatWishSocketTool : IMRcvLiveWishSend
@property (nonatomic,copy)void(^ChatWishListBlock)(NSMutableArray<ApiUsersLiveWishModel*>* list);
- (void)chatSocketToolParInit;
- (void)removeMessageSocket;

@end

NS_ASSUME_NONNULL_END
