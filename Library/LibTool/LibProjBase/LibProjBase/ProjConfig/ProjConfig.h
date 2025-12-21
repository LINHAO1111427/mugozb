//
//  ProjConfig.h
//  LibProjBase
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <LibProjBase/ProjConfigInterface.h>
#import <LibProjBase/ProjBusniessInterface.h>
#import <LibProjBase/KeyConfigInterface.h>


NS_ASSUME_NONNULL_BEGIN

@interface ProjConfig : NSObject

///------初始化------
+ (instancetype)shareInstence;

///公共配置
@property (nonatomic, copy)Class<ProjConfigInterface> baseConfig;
///项目业务配置
@property (nonatomic, copy)Class<ProjBusniessInterface> businessConfig;
///mob数据
@property (nonatomic, copy)Class<KeyConfigInterface> keyConfig;



#pragma mark - 项目基本配置 -

/**获取app类型
 1:视频直播
 2:一对一
 3:语音
 4:短视频
 5:直播购
 12:一对多+一对一
 13:一对多_语音
 23:一对一+语音
 123:以此类推
 */
+ (int)getAppType;

///获取app金币默认图
+ (UIImage *)getCoinImage;

///根据性别获得性别图标
+ (UIImage *)getAPPGenderImage:(int)index hasAge:(BOOL)hasAge;

///获得直播间默认背景图片
+ (UIImage *)getLiveBgImage;

///获取竖版视频的播放模式
+ (NSString *)getAppVerticalVideoGravity;

///获得默认性别的名称文字
+ (NSString *)getGenderName:(int)gender;

///是否包含年龄
+ (BOOL)hasGenderPicAge;

#pragma mark - 系统基本配置 -

///基础数据
+ (NSString *)baseUrl;
///链接socket
+ (void)connectSocket;
///直播与发短视频
+ (void)showSuspenPublish;
///用户是否登录(判断用户是否登陆成功了)
+ (BOOL)isUserLogin;
///登录成功
+ (void)userlogined;
///登出
+ (void)logout;
///用户id
+ (int64_t)userId;
///用户token
+ (NSString *)userToken;
 
///token失效
+ (void)tokenInvalid;
///账号禁用
+ (void)accountDisabled:(NSString *)showStr;
///显示登陆页面
+ (void)showLoginVC;
////封面图
+ (UIImage *)getAppThumb;
////启动图
+ (UIImage *)getLanuchImg;
///appicon
+ (UIImage *)getAppIcon;
/// 没有用户头像时候的占位视图
+ (UIImage *)getDefaultImage;
////登录背景图
+ (UIImage *)getLoginBgImage;
///获取appShceme
+ (NSString *)getAppSchemeUrl;

+ (NSString *)getZFBstring;

#pragma mark - 颜色设置 -
///导航栏字体颜色
+ (UIColor*)projNavTitleColor;

///默认颜色(偏紫色)
+ (UIColor *)normalColors;

///主题颜色
+ (UIColor *)projTintColor;

///页面主要背景颜色
+ (UIColor *)projBgColor;

///信息中心所有tabbar的第几个item
+ (int)messageCenterItem;

#pragma mark - 其他设置 -
///当前的viewcontroller
+ (UIViewController *)currentVC;

///获取当前的tabbar
+ (UITabBarController *)tabbarC;

///当前nvc中的vc的数组
+ (NSArray<UIViewController *> *)currentNVCList;



/**获取app类型
 1:视频直播
 2:一对一
 3:语音
 4:短视频
 5:直播购
 12:一对多+一对一
 13:一对多_语音
 23:一对一+语音
 123:以此类推
 */

///是否包含短视频
+ (BOOL)isContainShortVideo;

///是否包含1v1
+ (BOOL)isContain1v1;

///是否包含直播购物
+ (BOOL)isContainShopping;

///是否包含多人视频
+ (BOOL)isContainMPVideo;

///是否包含多人语音
+ (BOOL)isContainMPVoice;

@end


NS_ASSUME_NONNULL_END
