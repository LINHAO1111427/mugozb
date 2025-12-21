//
//  AppRouteName.h
//  LibProjBase
//
//  Created by admin on 2019/12/9.
//  Copyright © 2019 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

////防止宏定义产生过多的二进制文件
typedef NSString * KLCAppRouteKey NS_STRING_ENUM;

//通用controller
FOUNDATION_EXPORT KLCAppRouteKey const RN_general_webView;


//login
FOUNDATION_EXPORT KLCAppRouteKey const RN_login_welcome; ///登陆页

FOUNDATION_EXPORT KLCAppRouteKey const RN_general_location;   ///地图定位

FOUNDATION_EXPORT KLCAppRouteKey const RN_login_losePassword;   ///忘记密码
FOUNDATION_EXPORT KLCAppRouteKey const RN_login_changePassword;   ///修改密码
FOUNDATION_EXPORT KLCAppRouteKey const RN_login_userRegister; ///用户注册
FOUNDATION_EXPORT KLCAppRouteKey const RN_login_userBindPhone;///绑定手机号
FOUNDATION_EXPORT KLCAppRouteKey const RN_login_setUserProfile;///设置用户形象
FOUNDATION_EXPORT KLCAppRouteKey const RN_login_userInterestLabel;///兴趣标签
FOUNDATION_EXPORT KLCAppRouteKey const RN_login_ShowLoginVC;///显示登录页面

//base
FOUNDATION_EXPORT KLCAppRouteKey const RN_base_userReportVC; //举报
FOUNDATION_EXPORT KLCAppRouteKey const RN_base_searchAnchorVC;//搜索
FOUNDATION_EXPORT KLCAppRouteKey const RN_Base_BannedTheAppeal;//申诉

// 1v1直播
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_LaunchOneLive;

//1v1 求聊抢聊
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_launchScrambleChat;  ///发起抢聊
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_launchSeekChat;       ///发起求聊


FOUNDATION_EXPORT KLCAppRouteKey const RN_live_otoLive;  ///一对一直播或语音

//1v1遇见（匹配）
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_1v1UserMatch;
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_1v1UserMutiMatch;
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_1v1ChatSquare; ///女(或主播)聊场
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_1v1AnchorMatch;
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_otoSeekChatOrder; ///求聊
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_otoRobChatOrder; ///抢聊


//1v1聊天视频播放
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_1v1AnchorVideoPlay;
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_otoCallRecord;

//语音
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_audioForAnchorVC;
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_audioForAudienceVC;

//视频
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_liveForAnchorVC;
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_liveForAudienceVC;
FOUNDATION_EXPORT KLCAppRouteKey const RN_live_liveCloseVC;


FOUNDATION_EXPORT KLCAppRouteKey const RN_user_userInfoVC;//主播信息
FOUNDATION_EXPORT KLCAppRouteKey const RN_user_setUserRemark;//标记
FOUNDATION_EXPORT KLCAppRouteKey const RN_User_UserRelationList;//标记


//粉丝 关注 动态
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_followAC;//关注列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_fansAC;//粉丝列表

//动态
FOUNDATION_EXPORT KLCAppRouteKey const RN_dynamic_releaseDynamicVC;//发布动态
FOUNDATION_EXPORT KLCAppRouteKey const RN_dynamic_playVideoVC;//动态视频播放
FOUNDATION_EXPORT KLCAppRouteKey const RN_dynamic_dynamicReportVC;//动态举报
FOUNDATION_EXPORT KLCAppRouteKey const RN_dynamic_topic;//动态每个话题的动态列表

//短视频
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_release;//发布短视频
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_sort_List;//短视频分类
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_play_List;//短视频播放列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_mylist;//我的短视频列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_report;//短视频举报
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_payAlert;//短视频提示
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_aliRecord;//阿里短视频拍摄
FOUNDATION_EXPORT KLCAppRouteKey const RN_shortVideo_aliCrop;//阿里短视频裁剪

FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_privilegeSetting;//特权设置
 //粉丝团
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_fansGroupAC;
///我的粉丝团
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_MineFansGroupList;
//粉丝贡献榜
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_fansContributionAC;

//直播数据
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_LiveBroadcastDataAC;
//1v1 付费通话
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_OBOCallSettingAC;
//1v1 付费设置
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_PaymentSetAC;
//1v1 美颜设置
FOUNDATION_EXPORT KLCAppRouteKey const RN_activity_setUpBeautyAC;


//收益 贡献
FOUNDATION_EXPORT KLCAppRouteKey const RN_aux_personalContributionVC;

 
//center
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_editProfile;//我的修改
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_editProfileUsername;//修改昵称
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_youthMethod;//青少年模式
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_giftWall;//礼物墙
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_allMedalWall;//勋章墙
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_lookMeMore;//更多看过我
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_userGuard;//ta的守护
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_guardPrivilege;//守护特权
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_buyGuard;//购买守护
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_Ranking;//排行榜
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_FamilyRanking;//家族排行榜
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_myAccountAC;//我的账号
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_myPropAC;//我的道具
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_marketAC;//在线商城
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_activityCenterAC;//活动中心
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_myGradeAC;//我的等级
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_myGuardAC;//守护中心
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_anchorAuthAC;//主播认证
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_anchorAuthStatusTipAC;//认证状态
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_lineExtensionAC;//在线推广
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_serviceAC;//服务热线
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_settingAC;//设置
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_inviteCode;//我的邀请码
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_InviteRecode;//邀请记录
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_pictureSharingAC;//我的邀请码
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_taskCenter;//任务中心
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_incomeRank;//收入排行榜
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_hostCenter;//主播中心
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_timeActivity;//我的时间轴
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_svip;//sVIP
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_SafeAndPrivacy;//sVIP
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_privilegeLevel;//等级特权
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_mineLike;//我的喜欢

//setting
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_anchorProtocol;//主播协议
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_changePassword;//密码修改
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_cancelAccount;//账户注销
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_verifyAccount;//账户验证
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_contactService;//联系客服(静态页面)
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_onLineService;//在线客服（H5）
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_bindOrModifyPhone;//手机号绑定与修改
FOUNDATION_EXPORT KLCAppRouteKey const RN_center_setting_messageSet; //消息设置



FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_ConversationChatVC;//会话
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_MessageChatListVC;//私信
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_ChatSettingsVC;//聊天设置
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_MessageList;//聊天列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_MyDynamicComment;//我的动态评论列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_SystemNotice;///系统通知
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_OfficialNotice;///官方消息
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_OfficialDetailNotice;///官方消息详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_OneSystemNoticeList;///官方消息详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_MsgSquareList;///官方消息详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_SquareUserList;///广场成员列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Message_FansGroupUserList;///粉丝团成员列表


FOUNDATION_EXPORT KLCAppRouteKey const RN_User_buyVIP;///贵族（VIP）
FOUNDATION_EXPORT KLCAppRouteKey const RN_User_MineBlackList; ///我的黑名单



//官方小店
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_OfficialShopVC;
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_SubmitShopInfoVC;
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_ShopContentVC;
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_AddingGoodsVC;//添加商品
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Commodity_ManagerVC;//商品管理
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Commodity_DetailVC;//商品详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_PurchaseCar_ListVC;//购物车列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_ShopOrder_ConfirmVC;//确认订单
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Address_EditeVC;//地址编辑与增加
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Address_ListVC;//地址列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Store_Home_DetailVC;//商家主页
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Order_ListVC;//订单列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Order_DetailInfoVC;//订单详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Order_DeliverVC;//立即发货
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Order_LogisticDetailVC;//物流详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Order_MyShopIncomeVC;//我的小店收入
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_Order_myShopWithdrawVC;//商家提现
FOUNDATION_EXPORT KLCAppRouteKey const RN_Shopping_LiveTradePreviewFrameVC;//直播预告
 



///寻觅
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_InviteInfoVC; ///邀约详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_InviteListVC; ///邀约列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_OrderCancel;  ///订单取消
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_OrderAppeal;  ///订单申诉
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_OrderAddComment;  ///订单评论
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_OrderShowComment;  ///订单评论
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_QuickInviteVC;  ///快速预约
FOUNDATION_EXPORT KLCAppRouteKey const RN_Seek_ShowSkillInfoVC;  ///显示技能详情




/// 家族
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_CommentListVC; ///家族推荐
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_EditFamilyVC; ///家族创建和编辑
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_FamilySearchVC; ///家族搜索
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_FamilyInfoVC; ///家族详情
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_FamilyReportVC; ///家族举报
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_FamilySetting; ///家族设置
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_FamilyUserListVC; ///家族成员列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_FamilyApplyList; ///家族申请列表
FOUNDATION_EXPORT KLCAppRouteKey const RN_Family_FamilyNotice;   ///家族公告


///影视视频
FOUNDATION_EXPORT KLCAppRouteKey const RN_Television_SearchVideo;   ///搜索视频
FOUNDATION_EXPORT KLCAppRouteKey const RN_Television_PlayVideo;     ///播放视频
FOUNDATION_EXPORT KLCAppRouteKey const RN_Television_MineTelevision;   ///我的剧集



@interface AppRouteName : NSObject

@end

NS_ASSUME_NONNULL_END
