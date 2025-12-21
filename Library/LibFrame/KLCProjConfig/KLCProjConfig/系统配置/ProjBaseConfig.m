//
//  ProjBaseConfig.m
//  emo
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 . All rights reserved.
//

#import "ProjBaseConfig.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import "ProjPublicMethod.h"
#import <LibProjView/AccountDisabledHud.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
#import <LibProjModel/OooLiveConfigVOModel.h>

@interface ProjBaseConfig()

@end

@implementation ProjBaseConfig

+ (NSString *)baseUrl{
    return @"";
}

//启动图
+ (NSString *)getLanuchImageName{
    return @"launch_image";
}

//app基础颜色
+ (UIColor *)normalColors{
    return  kRGB_COLOR(@"#FF5EC6");
}

//coin
+ (UIImage *)getDefaultCoinImage{
    return [KLCAppConfig getCoinImage];
}
//默认icon
+ (NSString *)getUserDefaultIcon{
    return @"project_app_logo";
}

//iconname
+ (NSString *)getAppIconName{
    return @"project_app_logo";
}

//封面图
+ (NSString *)getAppThumbName{
    return @"project_app_logo";
}

//导航栏字体颜色
+ (UIColor *)getNavTitleColor{ 
    return kRGB_COLOR(@"#333333");
}


+ (UIColor *)projTintColor{
    return [UIColor blackColor];
}

+ (UIColor *)projBgColor{
    return [UIColor whiteColor];
}

///AVLayerVideoGravityResizeAspect 按比例自适应  AVLayerVideoGravityResizeAspectFill 平铺
+ (NSString *)getVerticalVideoGravity{
    return @"AVLayerVideoGravityResizeAspectFill";
}

+ (BOOL)isUserLogin{
    if ([KLCUserInfo getUserId] > 0  && [KLCUserInfo getUserToken].length > 0) {
        return YES;
    }else{
        return NO;
    }
}

//性别/年龄图标
+ (NSString *)getGenderImage:(int)index hasAge:(BOOL)hasAge{
    NSString *imageName;
    if (hasAge) {
        if (index == 1) {
            imageName = @"icon_gender_boy_white";
        }else{
            imageName = @"icon_gender_girl_white";
        }
    }else{
        if (index == 1) {
            imageName = @"icon_gender_boy_normal";
        }else{
            imageName = @"icon_gender_girl_normal";
        }
    }
    return imageName;
}

//直播背景
+ (NSString *)getLiveBgImageName{
    return @"live_default_bg";
}

+ (NSString *)getRechangeCenterBgImgName{
    return @"icon_account_bg";
}

+ (NSString *)getLoginBgImageName{
    return @"login_bg";
}

+ (BOOL)hasGenderPicAge{
    return YES;
}

+ (void)showHomeMainVC{
   // NSLog(@"过滤文字此处应该显示主页面"));
}

+ (void)accountDisable:(NSString *)str{
    [AccountDisabledHud shareDisable:str];
}

///是否显示用户的礼物墙
+ (BOOL)showUserGiftWall{
    return YES;
}

+ (int64_t)userId{
    int64_t userId = [KLCUserInfo getUserId];
    if (userId == 0 && [[ProjConfig shareInstence].baseConfig hasNoLoginShow] && [KLCAppConfig appConfig].loginSwitch.touristMode==1) {
        userId = [KLCAppConfig tempUid];
    }
    return userId;
}

+ (NSString *)userToken{
    NSString *userToken = [KLCUserInfo getUserToken];
    if (userToken.length == 0 && [[ProjConfig shareInstence].baseConfig hasNoLoginShow] && [KLCAppConfig appConfig].loginSwitch.touristMode==1) {
        userToken = [KLCAppConfig tempUToken];
    }
    return userToken.length>0?userToken:@"";
}
 
 
+ (void)tokenInvalid{
    [ProjPublicMethod tokenInvalid];
}

+ (void)logined{
    [ProjPublicMethod logined];
}

+ (void)logout{
    [ProjPublicMethod logout];
}

///第一次登录
+ (void)firstLogin{
    [ProjPublicMethod firstLogin];
}

+ (void)connectSocketSuccessBlock:(void (^)(void))addAllMonitorBlock{
    [ProjPublicMethod connectSocket:addAllMonitorBlock];
}
 
+ (NSArray *)getSexSelectedArray{
    return nil;
}

+ (NSString *)getSexNameStr:(int)gender{
    NSString *genderStr = kLocalizationMsg(@"不限");
    switch (gender) {
        case -1:
            genderStr = kLocalizationMsg(@"不限");
            break;
        case 0:
            genderStr = kLocalizationMsg(@"其他");
            break;
        case 1:
            genderStr = kLocalizationMsg(@"男");
            break;
        case 2:
            genderStr = kLocalizationMsg(@"女");
            break;
        default:
            break;
    }
    return genderStr;
}

+ (NSString *)getAppSchemeUrl{
    return @"youMengLive201121";
}

/**获取app类型
 1:一对多
 2:一对一
 3:语音
 4:短视频
 5.直播购物
 12:一对多+一对一
 13:一对多_语音
 23:一对一+语音
 123:以此类推
 */
+ (int)getAppType{
    return 0;
}

///链接socket
+ (void)connectSocket{
}

///消息是否有已读通知
+ (BOOL)msgHasReadInfo{
    return YES;
}

+ (int)messageCenterItem{
    return 3;
}


+ (void)showSuspenPublish{
   // NSLog(@"过滤文字～～～～～～～～～～～～～～系统配置文件中，没有配置此功能"));
}

+ (NSString *)getAnchorTipsStr{
    if ([KLCAppConfig appConfig].adminLiveConfig.isFunctionTurnOn) {
        return kLocalizationMsg(@"你还未认证，快去认证开始赚钱吧！");
    }else{
        return kLocalizationMsg(@"你还未认证，快去认证吧！");
    }
}

+ (int)liveRoomAttenTipTime{
    return 120;
}

+ (int)liveRoomFansTipTime{
    return 180;
}

+ (BOOL)liveAdvancedFunctions{
    return YES;
}

+ (BOOL)hasVoipNotification{
    if ([ProjConfig isContain1v1]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)whetherSetUserProfile{
    ApiUserInfoModel *usermodel = KLCUserInfo.getUserInfo;
 
    if (usermodel.avatar.length == 0  || usermodel.username.length == 0 || usermodel.birthday.length == 0 || usermodel.sex < 1 ) {
        return YES;
    }else{
        return NO;
    }
}

///女方聊场是否显示距离
+ (BOOL)otoWomanSquareShowDistance{
    return YES;
}

///用户认证时长
+ (CGFloat)userAuthTime{
    return 5;
}

///用户认证显示的文字
+ (NSString *)userAuthShowString{
    return kLocalizationMsg(@"拍摄时请保持您的本人正脸及上半身入镜，并录制清晰的视频!");
}

+ (BOOL)otoHomeDefaultShowBigView{
    return [KLCAppConfig appConfig].oooLiveConfigVO.homePageSwitch?NO:YES;
}

+ (BOOL)appAllShowAddressAndDistance{
    return YES;
}

///连送礼物时长
+ (int)sendGiftContinueTime{
    return 5;
}

///根据用户性别和年龄返回图片
+ (UIImage *)imageGender:(int)gender age:(int)age role:(int)role{
    
    UIView *genderBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    genderBgV.alpha = 1;
    // Background Code
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = genderBgV.bounds;
    gl.startPoint = CGPointMake(0.93, 0.94);
    gl.endPoint = CGPointMake(0.07, 0.12);
    if (gender == 2) {
        gl.colors = @[
        (__bridge id)[UIColor colorWithRed:255/255.0 green:108/255.0 blue:246/255.0 alpha:1.00].CGColor,
        (__bridge id)[UIColor colorWithRed:255/255.0 green:84/255.0 blue:160/255.0 alpha:1.00].CGColor,
        ];
    }else{
        gl.colors = @[
        (__bridge id)[UIColor colorWithRed:0/255.0 green:255/255.0 blue:244/255.0 alpha:1.00].CGColor,
        (__bridge id)[UIColor colorWithRed:75/255.0 green:201/255.0 blue:255/255.0 alpha:1.00].CGColor,
        ];
    }
    gl.locations = @[@(0),@(1.0f)];
    [genderBgV.layer addSublayer:gl];

    UILabel *genderLab = [[UILabel alloc] initWithFrame:genderBgV.bounds];
    genderLab.font = [UIFont systemFontOfSize:12];
    genderLab.textAlignment = NSTextAlignmentCenter;
    genderLab.textColor = [UIColor whiteColor];
    [genderBgV addSubview:genderLab];

    UIImage *genderImg = [UIImage imageNamed:[self getGenderImage:gender hasAge:YES]];
    genderLab.attributedText = [[NSString stringWithFormat:@"%d",age] attachmentForImage:genderImg bounds:CGRectMake(0, -1.5, 12, 12) before:YES];
    
    return [UIImage imageConvertFromView:genderBgV];
}

+ (BOOL)liveUnionShowJoinBtn{
    return YES;
}

///是否包含粉丝团
+ (BOOL)isContainFansGroup{
    return YES;
}

+ (Class)getBeautyViewClass{
   // NSLog(@"过滤文字error 未设置美颜文件"));
    return nil;
}

///是否包含心愿单
+ (BOOL)isContainWishList{
    return YES;
}

///一对一类型 0全部 1视频
+ (int)getOtoType{
    return 0;
}

///是否显示守护特权
+ (BOOL)isShowGuardPrivilege{
    return YES;
}

///是否包含守护
+ (BOOL)isContainUserGuard{
    return YES;
}

///是否外部提现
+ (BOOL)externalWithdrawal{
    return NO;
}

///仅发布动态的作者可查看用户评论
+ (BOOL)onlyDynamicAuthorShowComment{
    return NO;
}

///动态是否有评论
+ (BOOL)hasDynamicComment{
    return YES;
}

///显示用户&主播等级图标
+ (BOOL)showUserLevelImage{
    return YES;
}

///显示财富等级图标
+ (BOOL)showWeathLevelImage{
    return YES;
}

///验证用户的手机号
+ (BOOL)verifyUserPhoneNumber:(NSString *)phone{
    if (phone.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入手机号码")];
        return NO;
    }
    if (![phone valiMobile]) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入正确的手机号码")];
        return NO;
    }
    return YES;
}

///接受验证码平台 1:国内 2:国外
+ (void)getInternationalVerifyCode:(void (^)(int))platformBlock{
    if (platformBlock) {
        platformBlock(1);
    }
}

///一对一视频速配的时间
+ (int)otoVideoMatchingTime{
    return 10;
}


+ (BOOL)hasAppleLogin{
    return YES;
}

///是否有主播公会
+ (BOOL)hasAnchorConference{
    return YES;
}

///是否有家族
+ (BOOL)hasFamilyGroup{
    return NO;
}

///是否为不登录显示
+ (BOOL)hasNoLoginShow{
    return NO;
}

///发送礼物是否是隐藏选择礼物UI
+ (BOOL)whetherHiddenViewAtSendGift{
    return NO;
}

///是否包含粉丝团IM
+ (BOOL)hasFansIMGroup{
    return YES;
}

///检黄检测时间
+ (int)getLiveSnasshotTime{
    int monitoring = [KLCAppConfig appConfig].monitoringInterval;
    return monitoring>0?monitoring:60;
}

///使用openinstall做为推广
+ (BOOL)makeOpenInstall{
    return YES;
}

///是否显示主播分类
+ (BOOL)userSelectAnchorClassfiy{
    return NO;
}

///根据广告宽度获取广告的高度
+ (CGFloat)adHomeBannerHeightScaleToWidth:(CGFloat)width{
    return width/3.0;
}

///根据广告宽度获取动态广告的高度
+ (CGFloat)adDynamicBannerHeightScaleToWidth:(CGFloat)width{
    return width/3.0;
}

///显示用户形象设置的声音
+ (BOOL)showUserVoice{
    return YES;
}

///主播标识是否可点击
+ (BOOL)roleImageCanClick{
    return NO;
}













@end
