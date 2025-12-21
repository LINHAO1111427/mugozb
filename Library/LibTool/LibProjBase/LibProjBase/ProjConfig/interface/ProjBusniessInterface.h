//
//  ProjBusniessInterface.h
//  LibProjBase
//
//  Created by klc_sl on 2020/8/7.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///业务配置
@protocol ProjBusniessInterface <NSObject>

///支付 ///1.支付宝 2.微信  param 参数
+ (void)paymentType:(int)type param:(NSString *)param resultBlock:(void (^)(BOOL, NSString *))block;
///展示认证alert
+ (void)showAuthAlertView:(UIView*)onView role:(int)role;

///用户详情页面功能分类
+ (NSArray *)getUserInfoClassfiyArray;

///用户信息中用户资料数组
+ (NSArray *)getUserInfoContentArray;

///用户信息中底部信息
+ (NSArray *)getUserInfoBottomFunctionArray;

///动态分类
+ (NSArray *)getDynamicClassfiyTypeArray;

///广场分类
+ (NSArray *)getSquareClassfiyArray;

///消息中心分类
+ (NSArray *)getMessageCenterClassfiyArray;

///短视频看点中的分类
+ (NSArray *)getShortVideoLookPointArray;

///获取短视频分类标题
+ (NSArray *)getShortVideoClassfiyArray;

///获取单聊所有功能按钮
+ (NSArray *)getSingleChatFuncTypeArray;

///获取群聊所有功能按钮
+ (NSArray *)getGroupChatFuncTypeArray;

///单人聊天功能设置
+ (NSArray *)getSingleChatSetupArray;

///系统弹窗
+ (NSArray *)getAppSystemAlertArray;

///特权设置显示内容
+ (NSArray *)getPrivilegeSettingTitleArray;

///设置列表
+ (NSArray *)getSettingTitleArray;

///获取编辑资料基本列表
+ (NSArray *)getEditProfileBaseArray;
///隐私设置
+ (NSArray *)getSafeAndPrivacyListArray;

///获得主播中心第一组功能
+ (NSArray *)getAnchorFuncOneArray;

///获得主播中心第二组功能
+ (NSArray *)getAnchorFuncTwoArray;

///获得个人中头部显示功能
+ (NSArray *)getMineCenterHeaderShowArray;

///获得个人中心第一组功能
+ (NSArray *)getMineCenterFuncOneArray;

///获得个人中心第二组功能
+ (NSArray *)getMineCenterFuncTwoArray;

///获得排行榜类型
+ (NSArray *)getRankClassfiyArray;

///获得家族分类类型
+ (NSArray *)getFamilyClassfiyArray;

///获取消息设置的开关
+ (NSArray *)getNotifyMessageSettingArray;

///获取消息中心的功能
+ (NSArray *)getMessageCenterArray;
/// 获取支持的语言列表
+ (NSArray *)getAppLanguageList;
@end

NS_ASSUME_NONNULL_END
