//
//  KLCUserInfo.h
//  TCDemo
//
//  Created by admin on 2020/9/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ApiUserInfoModel;
@class UserController_userUpdate;
@class ApiUserInfoLoginModel;


NS_ASSUME_NONNULL_BEGIN


@interface KLCUserInfo : NSObject

///登录成功后设置用户登陆信息
+ (void)setAppLoginedInfo:(ApiUserInfoLoginModel *)login;

///用户基本信息
+ (ApiUserInfoModel *)getUserInfo;
+ (void)setUserInfo:(ApiUserInfoModel *)userInfo;


///更新用户信息
+ (void)updateUserInfo:(void (^_Nullable)(void))complete;

/// 更新用户信息
+ (void)setServiceUserInfo:(UserController_userUpdate *)userInfo complete:(void (^_Nullable)(BOOL success, NSString *msg))complete;

///更新用户token
+ (void)updateUserToken:(NSString *)userToken;
///更新用户手机号
+ (void)updateUserPhone:(NSString *)UserPhone;
///清除用户信息
+ (void)removeUserInfo;
///uid
+ (int64_t)getUserId;
///token
+ (NSString *)getUserToken;
///性别
+ (int)getGender;
///昵称
+ (NSString *)getNikeName;
///头像
+ (NSString *)getAvatar;
///0普通用户1主播
+ (int)getRole;
///是否为SVIP
+ (int)getSvip;
///用户的贵族等级
+ (int)getNobleGrade;

///地址
+ (double)getLat;
+ (double)getLng;
+ (NSString *)getCity;
+ (NSString *)getAddress;





#pragma mark - 登录信息 -

///是否为第一次登陆
+ (BOOL)isFirstLogin;
///获取用户的头像ID
+ (int64_t)userAvatarId;

///是否显示首冲礼包
+ (BOOL)isFirstRechange;
+ (void)alreadyShowFirstRechange;

///新手大礼包
+ (NSArray *)packList;
+ (void)removePackList;

///保存已绑定
+ (BOOL)isNeedBind;
+ (void)saveBind;

@end

NS_ASSUME_NONNULL_END
