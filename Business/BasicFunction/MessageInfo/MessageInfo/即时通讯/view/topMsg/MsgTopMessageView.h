//
//  MsgTopMessageView.h
//  Message
//
//  Created by klc_sl on 2021/8/6.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>

NS_ASSUME_NONNULL_BEGIN

@class MsgTopMessageView;
@class AppChatFamilyMsgTopVOModel;

@protocol MsgTopMessageDelegate <NSObject>

///点击用户置顶消息的头像
- (void)msgTopMessageForUserInfoClick:(MsgTopMessageView *)topMsg;

@end


@interface MsgTopMessageView : UIView


@property(nonatomic, weak)id<MsgTopMessageDelegate> delegate;


@property(nonatomic ,weak)UIImageView *bgImgV;

///头像
@property(nonatomic ,weak)KlcAvatarView *userIconV;

///用户名
@property(nonatomic ,weak)UILabel *usernameL;

///性别+年龄
@property(nonatomic ,weak)SWHTapImageView *genderImgV;

///等级
@property(nonatomic ,weak)UIImageView *levelImgV;

///内容
@property(nonatomic ,weak)UILabel *contentL;

///时间
@property(nonatomic ,weak)UILabel *timeL;

///当前发送置顶信息的用户ID
@property (nonatomic, assign)int64_t userId;


@property (nonatomic, strong)AppChatFamilyMsgTopVOModel *msgModel;


@end

NS_ASSUME_NONNULL_END
