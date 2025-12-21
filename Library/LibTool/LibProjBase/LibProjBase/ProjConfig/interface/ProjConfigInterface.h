//
//  ProjConfigInterface.h
//  LibProjBase
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 . All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/// 项目基本信息配置
@protocol ProjConfigInterface <NSObject>

+ (NSString *)baseUrl;

+ (UIColor *)normalColors;
 
+ (NSString *)getUserDefaultIcon;

+ (UIColor*)getNavTitleColor;

+ (UIColor *)projTintColor;

+ (UIColor *)projBgColor;

+ (NSString *)getAppIconName;

+ (UIImage *)getDefaultCoinImage;

+ (NSString *)getAppThumbName;

+ (NSString *)getLanuchImageName;

+ (NSString *)getLiveBgImageName;

+ (NSString *)getLoginBgImageName;

+ (NSString *)getVerticalVideoGravity;

+ (NSString *)getRechangeCenterBgImgName;

+ (NSString *)getAppSchemeUrl;

+ (int)getAppType;

+ (int64_t)userId;

+ (NSString *)userToken;

+ (BOOL)isUserLogin;

+ (void)tokenInvalid;

+ (void)accountDisable:(NSString *)str;

///获取性别获取图标的名称（有年龄的和没年龄有区别）
+ (NSString *)getGenderImage:(int)index hasAge:(BOOL)hasAge;

///显示主页面
+ (void)showHomeMainVC;

///链接socket
+ (void)connectSocket;
///第一次登录
+ (void)firstLogin;

+ (void)logined;

///检查用户账号是否需要形象设置
+ (BOOL)whetherSetUserProfile;

+ (void)logout;

@optional

///是否显示用户的礼物墙
+ (BOOL)showUserGiftWall;

///显示发布的功能选择框
+ (void)showSuspenPublish;

+ (BOOL)hasGenderPicAge;
///消息显示第在第几个按钮上
+ (int)messageCenterItem;
///认证提示文字
+ (NSString *)getAnchorTipsStr;
///直播间内关注提醒时间
+ (int)liveRoomAttenTipTime;
///直播间内粉丝团提醒时间
+ (int)liveRoomFansTipTime;
///是否有直播高级功能(用户连麦和PK功能)
+ (BOOL)liveAdvancedFunctions;
///女方聊场是否显示距离
+ (BOOL)otoWomanSquareShowDistance;
///用户认证时长
+ (CGFloat)userAuthTime;
///用户认证显示的文字
+ (NSString *)userAuthShowString;
///一对一默认显示大图模式
+ (BOOL)otoHomeDefaultShowBigView;
///获得美颜的Class文件
+ (Class)getBeautyViewClass;
///整个app是否显示地址和距离
+ (BOOL)appAllShowAddressAndDistance;
///获取选择性别列表
+ (NSArray *)getSexSelectedArray;
///获取性别名称
+ (NSString *)getSexNameStr:(int)gender;
///根据用户性别和年龄以及角色返回图片 角色是针对个别项目来说的
+ (UIImage *)imageGender:(int)gender age:(int)age role:(int)role;
///连送礼物时长
+ (int)sendGiftContinueTime;
///其他上传方法
+ (int)otherUploadFileType;
///直播工会是否显示加入按钮和金币
+ (BOOL)liveUnionShowJoinBtn;
///是否包含粉丝团
+ (BOOL)isContainFansGroup;
///是否包含守护
+ (BOOL)isContainUserGuard;
///是否包含心愿单
+ (BOOL)isContainWishList;
///一对一类型 0全部 1视频 2语音
+ (int)getOtoType;
///是否显示守护特权
+ (BOOL)isShowGuardPrivilege;
///是否外部提现
+ (BOOL)externalWithdrawal;
///仅发布动态的作者可查看用户评论
+ (BOOL)onlyDynamicAuthorShowComment;
///验证用户的手机号
+ (BOOL)verifyUserPhoneNumber:(NSString *)phone;
///接受验证码平台 1:国内 2:国外
+ (void)getInternationalVerifyCode:(void(^)(int platform))platformBlock;
///一对一视频速配的时间
+ (int)otoVideoMatchingTime;
///是否有苹果登录
+ (BOOL)hasAppleLogin;
///是否有主播公会
+ (BOOL)hasAnchorConference;
///是否有家族
+ (BOOL)hasFamilyGroup;
///是否包含粉丝团群组
+ (BOOL)hasFansIMGroup;
///是否有不登录显示的功能
+ (BOOL)hasNoLoginShow;
///发送礼物是否是隐藏选择礼物UI
+ (BOOL)whetherHiddenViewAtSendGift;
///直播视频检测时间(秒)
+ (int)getLiveSnasshotTime;
///使用openinstall做为推广
+ (BOOL)makeOpenInstall;
///设置横竖屏模式
+ (void)allowRotation:(UIInterfaceOrientationMask)orientation;
///主播认证是否显示主播分类
+ (BOOL)userSelectAnchorClassfiy;
///是否有Voip推送
+ (BOOL)hasVoipNotification;
///根据广告宽度获取首页广告的高度
+ (CGFloat)adHomeBannerHeightScaleToWidth:(CGFloat)width;
///根据广告宽度获取动态广告的高度
+ (CGFloat)adDynamicBannerHeightScaleToWidth:(CGFloat)width;
///显示用户形象设置的声音
+ (BOOL)showUserVoice;
///是否有动态评论功能
+ (BOOL)hasDynamicComment;
///显示用户&主播等级图标
+ (BOOL)showUserLevelImage;
///显示财富等级图标
+ (BOOL)showWeathLevelImage;
///消息是否有已读通知
+ (BOOL)msgHasReadInfo;
///主播标识是否可点击
+ (BOOL)roleImageCanClick;


@end

NS_ASSUME_NONNULL_END
