//
//  AppRouteName.m
//  LibProjBase
//
//  Created by admin on 2019/12/9.
//  Copyright © 2019 . All rights reserved.
//

#import "AppRouteName.h"

///通用
KLCAppRouteKey const RN_general_webView = @"RN_general_webView";

///登录组

KLCAppRouteKey const RN_login_welcome = @"RN_login_welcome";
KLCAppRouteKey const RN_login_losePassword = @"RN_login_losePassword";
KLCAppRouteKey const RN_login_changePassword = @"RN_login_changePassword";
KLCAppRouteKey const RN_login_userRegister = @"RN_login_userRegister";
KLCAppRouteKey const RN_login_userBindPhone = @"RN_login_userBindPhone";
KLCAppRouteKey const RN_login_setUserProfile = @"RN_login_setUserProfile";
KLCAppRouteKey const RN_login_userInterestLabel = @"RN_login_userInterestLabel";
KLCAppRouteKey const RN_login_ShowLoginVC = @"RN_login_ShowLoginVC";


KLCAppRouteKey const RN_base_searchAnchorVC = @"RN_base_searchAnchorVC";//搜索
KLCAppRouteKey const RN_base_userReportVC = @"RN_base_userReportVC";//举报
KLCAppRouteKey const RN_Base_BannedTheAppeal = @"RN_Base_BannedTheAppeal";//申诉

///直播间

// 1v1 视频
KLCAppRouteKey const RN_live_LaunchOneLive = @"RN_live_LaunchOneLive"; // 发起 1v1
KLCAppRouteKey const RN_live_otoLive = @"RN_live_otoLive"; // 1v1 直播和语音
KLCAppRouteKey const RN_live_launchScrambleChat = @"RN_live_launchScrambleChat";   ///抢聊
KLCAppRouteKey const RN_live_launchSeekChat = @"RN_live_launchSeekChat";   ///求聊

//语音
KLCAppRouteKey const RN_live_audioForAnchorVC = @"RN_live_audioForAnchorVC";
KLCAppRouteKey const RN_live_audioForAudienceVC = @"RN_live_audioForAudienceVC";

//视频
KLCAppRouteKey const RN_live_liveForAnchorVC = @"RN_live_liveForAnchorVC";
KLCAppRouteKey const RN_live_liveForAudienceVC = @"RN_live_liveForAudienceVC";
KLCAppRouteKey const RN_live_liveCloseVC = @"RN_live_liveCloseVC";

KLCAppRouteKey const RN_user_userInfoVC = @"RN_user_userInfoVC";
KLCAppRouteKey const RN_user_setUserRemark = @"RN_user_setUserRemark";//设置用户备注

KLCAppRouteKey const RN_User_UserRelationList = @"RN_User_UserRelationList"; ///用户相关的人员

///粉丝 关注 动态
KLCAppRouteKey const RN_activity_followAC = @"RN_activity_followAC";//关注
KLCAppRouteKey const RN_activity_fansAC = @"RN_activity_fansAC";//粉丝

////动态
KLCAppRouteKey const RN_dynamic_releaseDynamicVC = @"RN_dynamic_releaseDynamicVC";//发布动态
KLCAppRouteKey const RN_dynamic_playVideoVC = @"RN_dynamic_playVideoVC";//动态视频播放
KLCAppRouteKey const RN_dynamic_dynamicReportVC = @"RN_dynamic_dynamicReportVC";//动态举报
KLCAppRouteKey const RN_dynamic_topic = @"RN_dynamic_topic";//动态每个话题的动态列表

///短视频
KLCAppRouteKey const RN_shortVideo_release = @"RN_shortVideo_release";//发布短视频
KLCAppRouteKey const RN_shortVideo_sort_List = @"RN_shortVideo_sort_List";//短视频分类
KLCAppRouteKey const RN_shortVideo_play_List = @"RN_shortVideo_play_List";//短视频播放列表
KLCAppRouteKey const RN_shortVideo_mylist = @"RN_shortVideo_mylist";//我的短视频列表
KLCAppRouteKey const RN_shortVideo_report = @"RN_shortVideo_report";//短视频举报
KLCAppRouteKey const RN_shortVideo_payAlert = @"RN_shortVideo_payAlert";//短视频举报
KLCAppRouteKey const RN_shortVideo_aliRecord = @"RN_shortVideo_aliRecord";//阿里短视频拍摄
KLCAppRouteKey const RN_shortVideo_aliCrop = @"RN_shortVideo_aliCrop";//阿里短视频裁剪


KLCAppRouteKey const RN_activity_privilegeSetting = @"RN_activity_privilegeSetting";//特权设置
KLCAppRouteKey const RN_activity_fansGroupAC = @"RN_activity_fansGroupAC";//粉丝团
KLCAppRouteKey const RN_activity_MineFansGroupList = @"RN_activity_MineFansGroupList";//我的粉丝团列表

KLCAppRouteKey const RN_activity_fansContributionAC = @"RN_activity_fansContributionAC";//粉丝贡献榜
KLCAppRouteKey const RN_activity_LiveBroadcastDataAC = @"RN_activity_LiveBroadcastDataAC";//直播数据

 
KLCAppRouteKey const RN_activity_OBOCallSettingAC = @"RN_activity_OBOCallSettingAC";//1v1 付费通话
KLCAppRouteKey const RN_activity_PaymentSetAC = @"RN_activity_PaymentSetAC";//1v1 付费设置
KLCAppRouteKey const RN_activity_setUpBeautyAC = @"RN_activity_setUpBeautyAC";//1v1 美颜设置
KLCAppRouteKey const RN_activity_1v1UserMatch = @"RN_activity_1v1UserMatch";//1v1 匹配
KLCAppRouteKey const RN_activity_1v1UserMutiMatch = @"RN_activity_1v1UserMutiMatch";//1v1多人 匹配
KLCAppRouteKey const RN_activity_1v1ChatSquare = @"RN_activity_1v1ChatSquare";//1v1的30人列表聊场
KLCAppRouteKey const RN_activity_1v1AnchorMatch = @"RN_activity_1v1AnchorMatch";//1v1主播匹配
KLCAppRouteKey const RN_activity_1v1AnchorVideoPlay = @"RN_activity_1v1AnchorVideoPlay";//1v1播放
KLCAppRouteKey const RN_activity_otoCallRecord = @"RN_activity_otoCallRecord";//1v1 通话记录
KLCAppRouteKey const RN_activity_otoSeekChatOrder = @"RN_activity_otoSeekChatOrder";//选择发起求聊页面
KLCAppRouteKey const RN_activity_otoRobChatOrder = @"RN_activity_otoRobChatOrder";//进入抢聊页面

//aux
KLCAppRouteKey const RN_aux_personalContributionVC = @"RN_aux_personalContributionVC";

//center
KLCAppRouteKey const RN_center_editProfile = @"RN_center_editProfile";//编辑
KLCAppRouteKey const RN_center_editProfileUsername = @"RN_center_editProfileUsername";//修改昵称
KLCAppRouteKey const RN_center_youthMethod = @"RN_center_youthMethod";//青少年模式
KLCAppRouteKey const RN_center_giftWall = @"RN_center_giftWall";//礼物墙
KLCAppRouteKey const RN_center_allMedalWall = @"RN_center_allMedalWall";//勋章墙
KLCAppRouteKey const RN_center_userGuard = @"RN_center_userGuard";//ta的守护
KLCAppRouteKey const RN_center_myGuardAC = @"RN_center_myGuardAC";//守护中心
KLCAppRouteKey const RN_center_guardPrivilege = @"RN_center_guardPrivilege";//守护特权
KLCAppRouteKey const RN_center_buyGuard = @"RN_center_buyGuard";//购买守护
KLCAppRouteKey const RN_center_myAccountAC = @"RN_center_myAccountAC";//我的账号
KLCAppRouteKey const RN_center_myPropAC = @"RN_center_myPropAC";//我的道具
KLCAppRouteKey const RN_center_marketAC = @"RN_center_marketAC";//在线商城
KLCAppRouteKey const RN_center_activityCenterAC = @"RN_center_activityCenterAC";//活动中心
KLCAppRouteKey const RN_center_myGradeAC = @"RN_center_myGradeAC";//我的等级
KLCAppRouteKey const RN_center_Ranking = @"RN_center_Ranking";//排行榜
KLCAppRouteKey const RN_center_FamilyRanking = @"RN_center_FamilyRanking";//家族排行榜
KLCAppRouteKey const RN_center_lookMeMore = @"RN_center_lookMeMore";//谁看过我
KLCAppRouteKey const RN_center_anchorAuthAC = @"RN_center_anchorAuthAC";//主播认证
KLCAppRouteKey const RN_center_anchorAuthStatusTipAC = @"RN_center_anchorAuthStatusTipAC";//主播认证状态
KLCAppRouteKey const RN_center_lineExtensionAC = @"RN_center_lineExtensionAC";//在线推广
KLCAppRouteKey const RN_center_serviceAC = @"RN_center_serviceAC";//服务热线
KLCAppRouteKey const RN_center_settingAC = @"RN_center_settingAC";//设置
KLCAppRouteKey const RN_center_inviteCode = @"RN_center_inviteCode";//我的邀请码
KLCAppRouteKey const RN_center_InviteRecode = @"RN_center_InviteRecode";//记录
KLCAppRouteKey const RN_center_taskCenter = @"RN_center_taskCenter";//任务中心
KLCAppRouteKey const RN_center_incomeRank = @"RN_center_incomeRank";//收入排行榜
KLCAppRouteKey const RN_center_hostCenter = @"RN_center_hostCenter";//主播中心
KLCAppRouteKey const RN_center_timeActivity = @"RN_center_timeActivity";//我的时间轴
KLCAppRouteKey const RN_center_svip = @"RN_center_svip";//sVIP
KLCAppRouteKey const RN_center_SafeAndPrivacy = @"RN_center_SafeAndPrivacy";// 隐私设置
KLCAppRouteKey const RN_center_privilegeLevel = @"RN_center_privilegeLevel";//等级特权
KLCAppRouteKey const RN_center_pictureSharingAC = @"RN_center_pictureSharingAC";//图片分享
KLCAppRouteKey const RN_center_mineLike = @"RN_center_mineLike";//我的喜欢

//setting
KLCAppRouteKey const RN_center_setting_anchorProtocol = @"RN_center_setting_anchorProtocol";//主播协议
KLCAppRouteKey const RN_center_setting_changePassword = @"RN_center_setting_changePassword";//密码修改
KLCAppRouteKey const RN_center_setting_cancelAccount = @"RN_center_setting_cancelAccount";//注销用户
KLCAppRouteKey const RN_center_setting_verifyAccount = @"RN_center_setting_verifyAccount";//验证账户
KLCAppRouteKey const RN_center_setting_contactService = @"RN_center_setting_contactService";//联系客服
KLCAppRouteKey const RN_center_setting_onLineService = @"RN_center_setting_onLineService";//在线客服
KLCAppRouteKey const RN_center_setting_bindOrModifyPhone = @"RN_center_setting_bindOrModifyPhone";//手机号绑定与修改
KLCAppRouteKey const RN_center_setting_messageSet = @"RN_center_setting_messageSet";//消息设置



///消息中心 - 会话
KLCAppRouteKey const RN_Message_ConversationChatVC = @"RN_Message_ConversationChatVC";//会话
KLCAppRouteKey const RN_Message_MessageChatListVC = @"RN_Message_MessageChatListVC";//私信
///聊天设置
KLCAppRouteKey const RN_Message_ChatSettingsVC = @"RN_Message_ChatSettingsVC";
///聊天列表
KLCAppRouteKey const RN_Message_MessageList = @"RN_Message_MessageList";
///某一个系统通知的列表
KLCAppRouteKey const RN_Message_OneSystemNoticeList = @"RN_Message_OneSystemNoticeList";

KLCAppRouteKey const RN_Message_MyDynamicComment = @"RN_Message_MyDynamicComment";  ///我的动态列表
KLCAppRouteKey const RN_Message_SystemNotice = @"RN_Message_SystemNotice";  ///系统通知
KLCAppRouteKey const RN_Message_OfficialNotice = @"RN_Message_OfficialNotice";  ///官方消息
KLCAppRouteKey const RN_Message_OfficialDetailNotice = @"RN_Message_OfficialDetailNotice";  ///官方消息详情
KLCAppRouteKey const RN_Message_SquareUserList = @"RN_Message_SquareUserList"; ///群组成员
KLCAppRouteKey const RN_Message_FansGroupUserList = @"RN_Message_FansGroupUserList"; ///粉丝团成员
KLCAppRouteKey const RN_Message_MsgSquareList = @"RN_Message_MsgSquareList";  ///广场
///贵族（VIP）
KLCAppRouteKey const RN_User_buyVIP = @"RN_User_buyVIP";
///贵族（VIP）
KLCAppRouteKey const RN_User_MineBlackList = @"RN_User_MineBlackList";


///官方小店
KLCAppRouteKey const RN_Shopping_OfficialShopVC = @"RN_Shopping_OfficialShopVC";
KLCAppRouteKey const RN_Shopping_SubmitShopInfoVC = @"RN_Shopping_SubmitShopInfoVC";
KLCAppRouteKey const RN_Shopping_ShopContentVC = @"RN_Shopping_ShopContentVC";
KLCAppRouteKey const RN_Shopping_AddingGoodsVC = @"RN_Shopping_AddingGoodsVC";
KLCAppRouteKey const RN_Shopping_Commodity_ManagerVC = @"RN_Shopping_Commodity_ManagerVC";
KLCAppRouteKey const RN_Shopping_Commodity_DetailVC = @"RN_Shopping_Commodity_DetailVC";
KLCAppRouteKey const RN_Shopping_PurchaseCar_ListVC = @"RN_Shopping_PurchaseCar_ListVC";
KLCAppRouteKey const RN_Shopping_ShopOrder_ConfirmVC = @"RN_Shopping_ShopOrder_ConfirmVC";
KLCAppRouteKey const RN_Shopping_Address_EditeVC = @"RN_Shopping_Address_EditeVC";
KLCAppRouteKey const RN_Shopping_Address_ListVC = @"RN_Shopping_Address_ListVC";
KLCAppRouteKey const RN_Store_Home_DetailVC = @"RN_Store_Home_DetailVC";
KLCAppRouteKey const RN_Shopping_Order_ListVC = @"RN_Shopping_Order_ListVC";
KLCAppRouteKey const RN_Shopping_Order_DetailInfoVC = @"RN_Shopping_Order_DetailInfoVC";
KLCAppRouteKey const RN_Shopping_Order_DeliverVC = @"RN_Shopping_Order_DeliverVC";
KLCAppRouteKey const RN_Shopping_Order_LogisticDetailVC = @"RN_Shopping_Order_LogisticDetailVC";
KLCAppRouteKey const RN_Shopping_Order_MyShopIncomeVC = @"RN_Shopping_Order_MyShopIncomeVC";
KLCAppRouteKey const RN_Shopping_Order_myShopWithdrawVC = @"RN_Shopping_Order_myShopWithdrawVC";
KLCAppRouteKey const RN_Shopping_LiveTradePreviewFrameVC = @"RN_Shopping_LiveTradePreviewFrameVC";
 



///寻觅
KLCAppRouteKey const RN_Seek_InviteInfoVC = @"RN_Seek_InviteInfoVC";
KLCAppRouteKey const RN_Seek_InviteListVC = @"RN_Seek_InviteListVC";
KLCAppRouteKey const RN_Seek_OrderCancel = @"RN_Seek_OrderCancel";
KLCAppRouteKey const RN_Seek_OrderAppeal = @"RN_Seek_OrderAppeal";
KLCAppRouteKey const RN_Seek_OrderAddComment = @"RN_Seek_OrderAddComment";
KLCAppRouteKey const RN_Seek_OrderShowComment = @"RN_Seek_OrderShowComment";
KLCAppRouteKey const RN_Seek_QuickInviteVC = @"RN_Seek_QuickInviteVC";
KLCAppRouteKey const RN_Seek_ShowSkillInfoVC = @"RN_Seek_ShowSkillInfoVC";



///家族
KLCAppRouteKey const RN_Family_CommentListVC = @"RN_Family_CommentListVC";
KLCAppRouteKey const RN_Family_EditFamilyVC = @"RN_Family_EditFamilyVC";
KLCAppRouteKey const RN_Family_FamilySearchVC = @"RN_Family_FamilySearchVC";
KLCAppRouteKey const RN_Family_FamilyInfoVC = @"RN_Family_FamilyInfoVC";
KLCAppRouteKey const RN_Family_FamilyReportVC = @"RN_Family_FamilyReportVC";
KLCAppRouteKey const RN_Family_FamilySetting = @"RN_Family_FamilySetting";
KLCAppRouteKey const RN_Family_FamilyUserListVC = @"RN_Family_FamilyUserListVC";
KLCAppRouteKey const RN_Family_FamilyApplyList= @"RN_Family_FamilyApplyList";
KLCAppRouteKey const RN_Family_FamilyNotice= @"RN_Family_FamilyNotice";


///影视视频
KLCAppRouteKey const RN_Television_SearchVideo = @"RN_Television_SearchVideo";
KLCAppRouteKey const RN_Television_PlayVideo = @"RN_Television_PlayVideo";
KLCAppRouteKey const RN_Television_MineTelevision = @"RN_Television_MineTelevision";

@implementation AppRouteName

@end
