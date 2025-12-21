//
//  ChatHeaderView.h
//  Message
//
//  Created by klc_sl on 2021/7/28.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatGuardView.h"
#import <LibProjView/WishShowFlowView.h>
#import "ConversationBaseInfo.h"

@class ApiUserInfoModel;
@class OOOLiveTextChatDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface ChatHeaderView : UIView


- (instancetype)initWithFrame:(CGRect)frame chatType:(ConversationChatForType)chatType;


///更新用户数据
@property (nonatomic, strong)ApiUserInfoModel *userInfo;
///更新两人私聊信息
@property (nonatomic, strong)OOOLiveTextChatDataModel *chatDataInfo;
///心愿单列表
@property (nonatomic, copy)NSArray *wishList;


@end

NS_ASSUME_NONNULL_END
