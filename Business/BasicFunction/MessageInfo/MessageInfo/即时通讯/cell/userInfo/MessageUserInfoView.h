//
//  MessageUserInfoView.h

//  MessageInfo
//
//  Created by klc_sl on 2021/8/23.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
 
@class SendMsgUserInfoObj;

NS_ASSUME_NONNULL_BEGIN

@interface MessageUserInfoView : UIView

///群聊或者私聊，信息显示的最高点-Y点
@property (nonatomic, assign)CGFloat msgY;
///左侧X点
@property (nonatomic, assign)CGFloat msgLeftX;

@property (nonatomic, weak)KlcAvatarView *avatarV;

@property (nonatomic, weak)UILabel *userNameL;

@property (nonatomic, weak)SWHTapImageView *sexImgV;

@property (nonatomic, weak)UIImageView *level1ImgV;

@property (nonatomic, weak)UIImageView *level2ImgV;

@property (nonatomic, copy)void(^userAvatarClick)(void);


- (void)showUserInfoIsOwner:(BOOL)isOwner isGroup:(BOOL)isGroup userInfo:(SendMsgUserInfoObj *)sendUserInfo;

@end

NS_ASSUME_NONNULL_END
