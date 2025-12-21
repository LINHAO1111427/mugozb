//
//  InviteUserView.h
//  LiveCommon
//
//  Created by admin on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUserInfoModel;
@interface InviteUserView : UIView


/// 初始化用户信息
/// @param userModel 用户信息
/// @param role 用户当前的角色 0用户 1主播
+ (instancetype)inviteUserInfoShow:(ApiUserInfoModel *)userModel userCurrentRole:(int)role;


- (void)setSureBtnTitle:(NSString *)sureTitle cancelBtnTitle:(NSString *)cancelTitle content:(NSString *)content;


- (void)clickRefuseBtn:(void(^)(void))refuse;


- (void)clickAgreeBtn:(void(^)(void))agree;



- (void)cancelDismiss;


- (void)agreeDismiss;


@end

NS_ASSUME_NONNULL_END
