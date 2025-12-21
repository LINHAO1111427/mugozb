//
//  BusinessBaseObj.m
//  KLCProjConfig
//
//  Created by kalacheng on 2020/9/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "BusinessBaseObj.h"
#import <UIKit/UIKit.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/OooLiveConfigVOModel.h>
#define kLocalizationMsg(key) NSLocalizedString(key, nil)
@implementation BusinessBaseObj

+ (void)paymentType:(int)type param:(NSString *)param resultBlock:(void (^)(BOOL, NSString * _Nonnull))block{
   // NSLog(@"过滤文字支付除了苹果支付都没有配置"));
}

+ (NSArray *)getUserInfoBottomFunctionArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if ([ProjConfig isContain1v1]) {
        [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_chat",@"title":kLocalizationMsg(@"私信"),@"type":@"201",@"bigPic":@(0)}];  ///私信
        if ([[ProjConfig shareInstence].baseConfig isContainUserGuard]) {
            [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_guard",@"title":kLocalizationMsg(@"守护"),@"type":@"202",@"bigPic":@(0)}];  ///守护
        }
        [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_gift",@"title":kLocalizationMsg(@"礼物"),@"type":@"203",@"bigPic":@(0)}]; ///礼物
        switch ([[ProjConfig shareInstence].baseConfig getOtoType]) {
            case 1: {
                [muArr addObject:@{@"imgStr":@"O2O_shipin_white",@"title":kLocalizationMsg(@"视频通话"),@"type":@"211",@"bigPic":@(1)}];
            }   break;
            case 2: {
                [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_call",@"title":kLocalizationMsg(@"语音通话"),@"type":@"212",@"bigPic":@(1)}];
            }   break;
            default: {
                [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_call",@"title":kLocalizationMsg(@"语音/视频"),@"type":@"210",@"bigPic":@(1)}];
            }   break;
        }
    }else{
        [muArr addObject:@{@"imgStr":@"icon_userinfo_attent_normal",@"title":kLocalizationMsg(@"关注"),@"type":@"204",@"bigPic":@(0)}];  ///关注
        if ([[ProjConfig shareInstence].baseConfig isContainUserGuard]) {
            [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_guard",@"title":kLocalizationMsg(@"守护"),@"type":@"202",@"bigPic":@(0)}];  ///守护
        }
        [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_gift",@"title":kLocalizationMsg(@"礼物"),@"type":@"203",@"bigPic":@(0)}]; ///礼物
        [muArr addObject:@{@"imgStr":@"icon_userinfo_btn_message",@"title":kLocalizationMsg(@"私信Ta"),@"type":@"201",@"bigPic":@(1)}];
    }
    return muArr;
}

///用户详情页面功能分类
+ (NSArray *)getUserInfoClassfiyArray{
    
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    BOOL contain1v1 = [ProjConfig isContain1v1];
    BOOL containShortV = [ProjConfig isContainShortVideo];
    [muArr addObject:@{@"id":@0,@"title":kLocalizationMsg(@"资料")}];
    if (containShortV) {
        [muArr addObject:@{@"id":@1,@"title":kLocalizationMsg(@"视频")}];
    }
    if ([ProjConfig getAppType] != 4) {
        [muArr addObject:@{@"id":@2,@"title":kLocalizationMsg(@"动态")}];
    }
    if (contain1v1) {
        [muArr addObject:@{@"id":@3,@"title":kLocalizationMsg(@"评价")}];
    }
    return [NSArray arrayWithArray:muArr];
}

///用户信息中用户资料数组
+ (NSArray *)getUserInfoContentArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    [muArr addObject:@{@"id":@"0",@"title":kLocalizationMsg(@"个人信息"),}];
    [muArr addObject:@{@"id":@"1",@"title":kLocalizationMsg(@"标签")}];
    
    //    [muArr addObject:@{@"id":@"5",@"title":kLocalizationMsg(@"动态")}];
    
    [muArr addObject:@{@"id":@"2",@"title":kLocalizationMsg(@"勋章墙")}];
    if ([[ProjConfig shareInstence].baseConfig isContainUserGuard]) {
        [muArr addObject:@{@"id":@"3",@"title":kLocalizationMsg(@"守护")}];
    }
    if ([[ProjConfig shareInstence].baseConfig showUserGiftWall]) {
        [muArr addObject:@{@"id":@"4",@"title":kLocalizationMsg(@"礼物墙")}];
    }
    return muArr;
}


///动态分类
+ (NSArray *)getDynamicClassfiyTypeArray{
    NSArray *typeArr =  @[
        @{@"type":@"0",@"title":kLocalizationMsg(@"最新")},
        @{@"type":@"2",@"title":kLocalizationMsg(@"关注")},
    ];
    return typeArr;
    
}

///动态看点中的分类
+ (NSArray *)getShortVideoLookPointArray{
    NSArray *arr = @[
        @{@"funcId":@"1",@"image":@"focus_most_look",@"title":kLocalizationMsg(@"最多观看")},
        @{@"funcId":@"2",@"image":@"focus_most_comment",@"title":kLocalizationMsg(@"最多评论")},
        @{@"funcId":@"3",@"image":@"focus_most_like",@"title":kLocalizationMsg(@"最多点赞")},
        @{@"funcId":@"4",@"image":@"focus_most_pay",@"title":kLocalizationMsg(@"最多付费")},
    ];
    return arr;
}

///获取消息中心的功能
+ (NSArray *)getMessageCenterArray{
    NSArray *arr = @[
        @{@"funcId":@"6",@"image":@"message_service",@"title":kLocalizationMsg(@"求聊")},
        @{@"funcId":@"1",@"image":@"message_news_comment",@"title":kLocalizationMsg(@"评论")},
        @{@"funcId":@"2",@"image":@"message_news_notification",@"title":kLocalizationMsg(@"系统通知")},
        @{@"funcId":@"3",@"image":@"message_news_official",@"title":kLocalizationMsg(@"官方消息")},
//        @{@"funcId":@"4",@"image":@"message_news_comment",@"title":kLocalizationMsg(@"在线客服")},
//        @{@"funcId":@"5",@"image":@"message_tousu",@"title":kLocalizationMsg(@"投诉")},
    ];
    return arr;
}

///获取单聊功能按钮
+ (NSArray *)getSingleChatFuncTypeArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    [muArr addObject:@{@"id":@"0",@"title":kLocalizationMsg(@"音频"),@"image":@"message_liaotian_yuyinxiaoxi"}];
    if ([ProjConfig isContain1v1]) {
        int otoType = [[ProjConfig shareInstence].baseConfig getOtoType];
        if (otoType == 0 || otoType == 1) {
            [muArr addObject:@{@"id":@"2",@"title":kLocalizationMsg(@"1v1视频"),@"image":@"message_liaotian_shipintonghua"}];
        }
        if (otoType == 0 || otoType == 2) {
            [muArr addObject:@{@"id":@"1",@"title":kLocalizationMsg(@"1v1电话"),@"image":@"message_liaotian_yuyintonghua"}];
        }
    }
    [muArr addObject:@{@"id":@"3",@"title":kLocalizationMsg(@"图片"),@"image":@"message_liaotian_fasongtupian"}];
    [muArr addObject:@{@"id":@"4",@"title":kLocalizationMsg(@"礼物"),@"image":@"message_liaotian_zengsongliwu"}];
    
    if ([[ProjConfig shareInstence].baseConfig isContainWishList]) {
        [muArr addObject:@{@"id":@"5",@"title":kLocalizationMsg(@"心愿单"),@"image":@"add_wish_xinyuandan"}];
    }
    if ([KLCAppConfig appConfig].adminLiveConfig.privateShowRedPack == 0) {
        [muArr addObject:@{@"id":@"6",@"title":kLocalizationMsg(@"红包"),@"image":@"message_liaotian_redPack"}];
    }
    if (![KLCAppConfig appConfig].oooLiveConfigVO.chatRoomAnchorContact && [ProjConfig isContain1v1]) {
        [muArr addObject:@{@"id":@"7",@"title":kLocalizationMsg(@"联系信息"),@"image":@"message_liaotian_lianxifangshi"}];
    }
    return [NSArray arrayWithArray:muArr];
}


///获取群聊功能按钮
+ (NSArray *)getGroupChatFuncTypeArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    [muArr addObject:@{@"id":@"0",@"title":kLocalizationMsg(@"音频"),@"image":@"message_liaotian_yuyinxiaoxi"}];
    [muArr addObject:@{@"id":@"3",@"title":kLocalizationMsg(@"图片"),@"image":@"message_liaotian_fasongtupian"}];
    [muArr addObject:@{@"id":@"4",@"title":kLocalizationMsg(@"礼物"),@"image":@"message_liaotian_zengsongliwu"}];
    if ([[ProjConfig shareInstence].baseConfig isContainWishList]) {
        [muArr addObject:@{@"id":@"5",@"title":kLocalizationMsg(@"心愿单"),@"image":@"add_wish_xinyuandan"}];
    }
    if ([KLCAppConfig appConfig].adminLiveConfig.groupShowRedPack == 0) {
        [muArr addObject:@{@"id":@"6",@"title":kLocalizationMsg(@"红包"),@"image":@"message_liaotian_redPack"}];
    }
    return [NSArray arrayWithArray:muArr];
}


///单人聊天功能设置
+ (NSArray *)getSingleChatSetupArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    [muArr addObject:@{@"id":@"4",@"name":kLocalizationMsg(@"个人资料"),@"type":@"0"}];
    [muArr addObject:@{@"id":@"3",@"name":kLocalizationMsg(@"设置备注"),@"type":@"0"}];
    [muArr addObject:@{@"id":@"0",@"name":kLocalizationMsg(@"加入黑名单"),@"type":@"1"}];
    if ([ProjConfig isContain1v1]) {
        int otoType = [[ProjConfig shareInstence].baseConfig getOtoType];
        if (otoType == 0 || otoType == 1) {
            [muArr addObject:@{@"id":@"2",@"name":kLocalizationMsg(@"不接受TA的视频通话"),@"type":@"1"}];
        }
        if (otoType == 0 || otoType == 2) {
            [muArr addObject:@{@"id":@"1",@"name":kLocalizationMsg(@"不接受TA的语音通话"),@"type":@"1"}];
        }
    }
    return [NSArray arrayWithArray:muArr];
}


+ (NSArray *)getAppSystemAlertArray{
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    [muArr addObject:@{@"title":kLocalizationMsg(@"生日闪屏"),@"type":@100}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"版本更新"),@"type":@105}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"禁令条约"),@"type":@108}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"新手大礼包"),@"type":@102}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"连续登陆奖励"),@"type":@103}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"签到"),@"type":@107}];
    if ([ProjConfig isContain1v1]) {
        [muArr addObject:@{@"title":kLocalizationMsg(@"赠送通话提示"),@"type":@106}];
    }
    [muArr addObject:@{@"title":kLocalizationMsg(@"首充奖励"),@"type":@109}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"系统公告"),@"type":@104}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"绑定上下级"),@"type":@101}];
    return [NSArray arrayWithArray:muArr];
    
}

///特权设置显示内容
+ (NSArray *)getPrivilegeSettingTitleArray{
    
    NSMutableArray *oneListArr = [[NSMutableArray alloc] init];
    
    [oneListArr addObject:@{@"tag":@101,@"title":kLocalizationMsg(@"贡献榜隐身"),@"tip":kLocalizationMsg(@"开启后，您将会在贡献榜中隐身"),@"type":@1}];
    if ([ProjConfig isContainMPVideo] || [ProjConfig isContainMPVoice]) {
        [oneListArr addObject:@{@"tag":@102,@"title":kLocalizationMsg(@"进入直播间隐身"),@"tip":kLocalizationMsg(@"开启后，您进入直播间将会隐身，其他人将看不到您的入场信息"),@"type":@1}];
    }
    [oneListArr addObject:@{@"tag":@103,@"title":kLocalizationMsg(@"充值隐身"),@"tip":kLocalizationMsg(@"开启后，将不会提示您的充值飘屏"),@"type":@1}];
    
    NSMutableArray *twoListArr = [[NSMutableArray alloc] init];
    [twoListArr addObject:@{@"tag":@201,@"title":kLocalizationMsg(@"直播间发消息全站广播"),@"tip":kLocalizationMsg(@"关闭后，贵族发言将不会全站飘屏广播！"),@"type":@0}];
    
    ///分组标题
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if (oneListArr.count > 0) {
        [muArr addObject:@{@"section":@0,@"title":kLocalizationMsg(@"隐身特权设置"),@"list":[NSArray arrayWithArray:oneListArr]}];
    }
    if (twoListArr.count > 0) {
        [muArr addObject:@{@"section":@1,@"title":kLocalizationMsg(@"全站广播设置"),@"list":[NSArray arrayWithArray:twoListArr]}];
    }
    return [NSArray arrayWithArray:muArr];
}

// 602 阿拉伯语 ｜ 603 土耳其
+ (NSArray *)getAppLanguageList{
    NSArray *languageArr = @[
        @{@"tag":@601,@"title":@"English",@"mark":@"en"},
        @{@"tag":@602,@"title":@"بالعربية",@"mark":@"ar"},
        @{@"tag":@603,@"title":@"Türkçe",@"mark":@"tr"},
        @{@"tag":@605,@"title":kLocalizationMsg(@"简体中文"),@"mark":@"zh-Hans"},
    ];
    return languageArr;
}

/// setting
+ (NSArray *)getSettingTitleArray{
    NSArray *arr = @[
        @{@"section":@0,@"list":@[
                  @{@"tag":@3010,@"title":kLocalizationMsg(@"隐私设置"),@"type":@1},
                  @{@"tag":@3001,@"title":kLocalizationMsg(@"消息设置"),@"type":@1},
                  @{@"tag":@3002,@"title":kLocalizationMsg(@"关于我们"),@"type":@1},
                  @{@"tag":@3003,@"title":kLocalizationMsg(@"清理缓存"),@"type":@3},
                  @{@"tag":@3004,@"title":kLocalizationMsg(@"手机号"),@"type":@3},
                  @{@"tag":@3005,@"title":kLocalizationMsg(@"登录密码修改"),@"type":@3},
                  @{@"tag":@3006,@"title":kLocalizationMsg(@"账号注销"),@"type":@3},
                  @{@"tag":@3007,@"title":kLocalizationMsg(@"当前版本"),@"type":@3},
                  @{@"tag":@3020,@"title":kLocalizationMsg(@"语言"),@"type":@3}
        ]},
        @{@"section":@1,@"list":@[
                  @{@"tag":@3008,@"title":kLocalizationMsg(@"退出登录"),@"type":@0}
        ]}
    ];
    return arr;
}


+ (NSArray *)getAnchorFuncOneArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if ([[ProjConfig shareInstence].baseConfig isContainWishList]) {
        [muArr addObject:@{@"title":kLocalizationMsg(@"心愿单"), @"imageName":@"mine_anchor_wish", @"item_id":@102}];
    }
    [muArr addObject:@{@"title":kLocalizationMsg(@"收益明细"), @"imageName":@"mine_anchor_income", @"item_id":@100}];
    [muArr addObject:@{@"title":kLocalizationMsg(@"提现"), @"imageName":@"", @"item_id":@101}];
    return muArr;
}


+ (NSArray *)getAnchorFuncTwoArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if ([ProjConfig isContain1v1]) {
        int otoType = [[ProjConfig shareInstence].baseConfig getOtoType];
        if (otoType == 0 || otoType == 1) {
            [muArr addObject:@{@"title":kLocalizationMsg(@"视频接听收费"), @"imageName":@"mine_icon_anchor_video", @"item_id":@202}];
        }
        if (otoType == 0 || otoType == 2) {
            [muArr addObject:@{@"title":kLocalizationMsg(@"语音接听收费"), @"imageName":@"mine_icon_anchor_voice", @"item_id":@201}];
        }
        [muArr addObject:@{@"title":kLocalizationMsg(@"状态设置"), @"imageName":@"mine_icon_anchor_status", @"item_id":@203}];
        [muArr addObject:@{@"title":kLocalizationMsg(@"形象展示设置"), @"imageName":@"mine_icon_anchor_cover", @"item_id":@204}];
    }
    if ([ProjConfig isContainMPVideo] || [ProjConfig isContainMPVoice]) {
        [muArr addObject:@{@"title":kLocalizationMsg(@"直播数据"), @"imageName":@"mine_icon_live_data", @"item_id":@205}];
    }
    if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
        [muArr addObject:@{@"title":kLocalizationMsg(@"粉丝团"), @"imageName":@"mine_icon_anchor_fans_group", @"item_id":@206}];
    }
    [muArr addObject:@{@"title":kLocalizationMsg(@"贡献榜"),@"imageName":@"mine_icon_anchor_contribute", @"item_id":@207}];
    if ([ProjConfig isContain1v1]) {
        if ([KLCAppConfig appConfig].oooLiveConfigVO.takeAnchorContact == 0) {   ///开启
            [muArr addObject:@{@"title":kLocalizationMsg(@"付费设置"), @"imageName":@"mine_icon_anchor_fee_set", @"item_id":@209}];
        }
        [muArr addObject:@{@"title":kLocalizationMsg(@"通话记录"), @"imageName":@"mine_icon_anchor_callrecords", @"item_id":@210}];
    }
    return [NSArray arrayWithArray:muArr];
}


///获取短视频分类标题
+ (NSArray *)getShortVideoClassfiyArray{
    return @[
        @{@"id":@"0",@"title":kLocalizationMsg(@"关注"),@"logicType":@"1"},
        @{@"id":@"1",@"title":kLocalizationMsg(@"推荐"),@"logicType":@"0"},
        @{@"id":@"2",@"title":kLocalizationMsg(@"看点"),@"logicType":@"2"}
    ];
}

///获取消息设置的开关
+ (NSArray *)getNotifyMessageSettingArray{
    return @[@{@"tag":@9031,@"title":kLocalizationMsg(@"消息提示音"),@"type":@2},
             @{@"tag":@9032,@"title":kLocalizationMsg(@"消息推送"),@"type":@2}];
}

///获得个人中头部显示功能
+ (NSArray *)getMineCenterHeaderShowArray{
    // 保留社交核心：关注 / 粉丝
    return @[
        @{@"type":@"1", @"title":kLocalizationMsg(@"关注")},
        @{@"type":@"2", @"title":kLocalizationMsg(@"粉丝")},
    ];
}

///获得个人中心第一组功能
+ (NSArray *)getMineCenterFuncOneArray{
    // 隐藏非核心功能入口
    return @[];
}
 

///获得个人中心第二组功能
+ (NSArray *)getMineCenterFuncTwoArray{
    // 仅保留设置
    return @[
        @{@"title":kLocalizationMsg(@"设置"), @"imageName":@"mine_icon_setting_down", @"item_id":@2016},
    ];
}
+ (NSArray *)getEditProfileBaseArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    [muArr addObject:@{@"type":@"100",@"title":kLocalizationMsg(@"昵称"),@"placeholder":kLocalizationMsg(@"请输入您的昵称")}];
    [muArr addObject:@{@"type":@"101",@"title":kLocalizationMsg(@"个性签名"),@"placeholder":kLocalizationMsg(@"请输入您的签名")}];
    [muArr addObject:@{@"type":@"102",@"title":kLocalizationMsg(@"生日"),@"placeholder":kLocalizationMsg(@"请选择您的生日")}];
    [muArr addObject:@{@"type":@"103",@"title":kLocalizationMsg(@"星座"),@"placeholder":kLocalizationMsg(@"请选择您的星座")}];
    [muArr addObject:@{@"type":@"104",@"title":kLocalizationMsg(@"职业"),@"placeholder":kLocalizationMsg(@"请输入您的职业")}];
    [muArr addObject:@{@"type":@"105",@"title":kLocalizationMsg(@"身高"),@"placeholder":kLocalizationMsg(@"请选择您的身高")}];
    [muArr addObject:@{@"type":@"106",@"title":kLocalizationMsg(@"体重"),@"placeholder":kLocalizationMsg(@"请选择您的体重")}];
    [muArr addObject:@{@"type":@"107",@"title":kLocalizationMsg(@"三围"),@"placeholder":kLocalizationMsg(@"请选择您的三围")}];
    return [NSArray arrayWithArray:muArr];
}
///展示认证alert
+ (void)showAuthAlertView:(UIView*)onView role:(int)role{
    return;
}

///广场分类
+ (NSArray *)getSquareClassfiyArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if ([ProjConfig getAppType] != 2) {
        [muArr addObject:@{@"type":@"0",@"title":kLocalizationMsg(@"附近的人")}];
    }
    [muArr addObject:@{@"type":@"1",@"title":kLocalizationMsg(@"动态")}];
    return [NSArray arrayWithArray:muArr];
}

///消息中心分类
+ (NSArray *)getMessageCenterClassfiyArray{
    return @[@{@"id":@"1",@"title":kLocalizationMsg(@"聊天")}];
}

///获得排行榜类型
+ (NSArray *)getRankClassfiyArray{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:1];
    [muArr addObject:@{@"type":@"1",@"title":kLocalizationMsg(@"收益榜")}];
    [muArr addObject:@{@"type":@"2",@"title":kLocalizationMsg(@"贡献榜")}];
    if ([[ProjConfig shareInstence].baseConfig hasAnchorConference]) {
        [muArr addObject:@{@"type":@"3",@"title":kLocalizationMsg(@"公会榜")}];
    }
    if ([[ProjConfig shareInstence].baseConfig hasFamilyGroup]) {
        [muArr addObject:@{@"type":@"4",@"title":kLocalizationMsg(@"家族榜")}];
    }
    return muArr;
}

+ (NSArray *)getFamilyClassfiyArray{
    return @[@{@"type":@"1",@"title":kLocalizationMsg(@"同城")},
             @{@"type":@"2",@"title":kLocalizationMsg(@"附近")},
             @{@"type":@"3",@"title":kLocalizationMsg(@"日榜")},
             @{@"type":@"4",@"title":kLocalizationMsg(@"周榜")},];
}

///隐私设置
+ (NSArray *)getSafeAndPrivacyListArray{
    return @[
             @{@"tag":@4001,@"title":kLocalizationMsg(@"位置是否保密"),@"content":kLocalizationMsg(@"打开后，将对所有人隐藏你的具体位置"),@"type":@1},
             @{@"tag":@4002,@"title":kLocalizationMsg(@"送礼是否全局广播"),@"content":kLocalizationMsg(@"关闭后，您发送的所有礼物都不会全局显示"),@"type":@1}
            ];
}

@end
