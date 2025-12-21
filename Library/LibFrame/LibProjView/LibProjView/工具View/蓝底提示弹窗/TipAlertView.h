//
//  TipAlertView.h
//  LibProjView
//
//  Created by klc on 2020/4/1.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface TipAlertView: UIView




/// 单按钮蓝紫色背景图
/// @param title 标题
/// @param subTitleBlock 副标题的label 自定义
/// @param btnTitle 按钮名称
/// @param clickBlock 点击按钮的返回
/// @param cancel 点击关闭按钮或者其他取消视图的地方
+ (void)showTitle:(NSString *)title
         subTitle:(void(^)(UILabel *subTitleL))subTitleBlock
     sureBtnTitle:(NSString *)btnTitle
         btnClick:(void(^ _Nullable)(void))clickBlock
           cancel:(void(^ _Nullable)(void))cancel;









/// 单按钮或双按钮 蓝色背景图
/// @param title 标题  可写可不写
/// @param iconUrl 用户头像
/// @param userName 用户名称
/// @param gender 用户性别
/// @param levelStr 等级图标
/// @param vipStr vip图标
/// @param subTitleBlock 副标题的label 自定义
/// @param sureTitle 确认按钮
/// @param sureBlock 确认按钮点击的回调
/// @param refuseTitle 拒绝
/// @param refuseBlock 拒绝按钮点击的回调
/// @param cancel 点击关闭按钮或者其他取消视图的地方
+ (void)showTitle:(NSString * _Nullable)title
         userIcon:(NSString * _Nullable)iconUrl
         userName:(NSString *)userName
           gender:(int)gender
         levelStr:(NSString *)levelStr
           vipStr:(NSString *)vipStr
         subTitle:(void(^)(UILabel *subTitleL))subTitleBlock
     sureBtnTitle:(NSString *)sureTitle
     sureBtnClick:(void(^ _Nullable)(void))sureBlock
   refuseBtnTitle:(NSString * _Nullable)refuseTitle
   refuseBtnClick:(void(^ _Nullable)(void))refuseBlock
           cancel:(void(^ _Nullable)(void))cancel;




+ (void)removeSelf;

@end

NS_ASSUME_NONNULL_END
