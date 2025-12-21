//
//  ApplyUserListCell.h
//  LiveCommon
//
//  Created by CH on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>

NS_ASSUME_NONNULL_BEGIN


@class ApiLineVoiceModel,AppUserDtoModel;

@interface ApplyUserListCell : UITableViewCell
 
@property(nonatomic, weak) KlcAvatarView *avaterImageView;// 用户头像
@property(nonatomic, weak) UILabel *userNameLb;// 用户名
@property(nonatomic, weak) UIImageView *level1ImgV;//用户等级
@property(nonatomic, weak) UIImageView *level2ImgV;//用户等级
@property(nonatomic, weak) UIImageView *userGenderImgV;//用户性别
@property (nonatomic, weak) UIView *funcBgView; ///功能View


@property (nonatomic, assign)int64_t userId;

/// 设置用户基本信息
/// @param index 排序
/// @param username 用户名
/// @param avatar 头像
/// @param frame 头像框
/// @param age 年龄
/// @param gender 性别
/// @param levelImage 等级图标
- (void)showIndex:(NSInteger)index userName:(NSString *)username avatar:(NSString *)avatar iconFrame:(NSString *)frame age:(int)age gender:(int)gender weathLevel:(NSString *)weathLevel nobleLevel:(NSString *)nobleLevel;



///显示用户连麦样式
- (void)showUserLinkList:(int)mikePrivilege;

///显示在线用户的样式  1在麦  0 不在麦
- (void)showOnlineMicStatus:(int)isInAssistant inviteBlock:(void(^)(void))invite;

///显示上麦申请样式
- (void)showApplyUser:(int)mikePrivilege handle:(void(^)(BOOL isAgree))handle;

///显示连麦管理的样式
- (void)showLinkUserMicStatus:(int)micStatus micHandle:(void(^)(void))micHandle below:(void(^)(void))belowHandle;

@end

NS_ASSUME_NONNULL_END
