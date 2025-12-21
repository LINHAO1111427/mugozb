//
//  LiveComponentMsgListener.h
//  TCDemo
//
//  Created by shirley on 2019/9/27.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LiveComponentMsgListenerEnum) {
    

    // MARK: - 新组建通信
    /// 互动成功消息
    LM_SuccessfulInteraction,
    /// 互动关闭消息
    LM_CloseInteractionInfo,
    /// 发互动关闭
    LM_CloseInteraction,
    /// 发连麦关闭
    LM_LaunchCloseLinkMic,
    /// 发送允许/禁止连麦 state: 0 - 允许，1 - 禁止
    LM_SetLinkMicStatus,
    /// 主播离开或回来
    LM_AnchorStatus,
    ///更新连麦请求提示
    LM_UpdateConnectTip,
    
#pragma mark - 非业务消息 -
    
    ///清屏 @{@"animation":@(1/0)}   1:开始 ：0结束
    LM_ClearScreenAnimation,
    ///显示屏幕信息 @{@"animation":@(1/0)}   1:开始 ：0结束
    LM_ShowScreenAnimation,
    ///更新底部功能按钮
    LM_ReloadFunBtn,
    ///最小化
    LM_MiniLiveRoom,
    ///还原
    LM_RecoverLiveRoom,
    
    
#pragma mark - 计时中的消息 -
    ///定时关注
    LM_TimeAttention,
    ///定时加入粉丝团
    LM_TimeJoinFans,
    
#pragma mark - 直播云相关 -
    
    /// 美颜被点击
    LM_BeautyShow,
    /// 美颜视图关闭（开播组件视图显示，或直播间具体消息操作）
    LM_BeautyDismiss,
    /// 翻转前后摄像头被点击
    LM_RotateCamera,
    /// 预览状态@{@"status":@()}
    LM_PreviewStatus,
    
    
#pragma mark - 直播开始&结束 -
    
    /// 开播信息（显示视图）参数应传空 nil
    LM_LiveRoomInfo,
    /// 显示关闭直播信息（关播接口成功之后）
    LM_LiveLeaveInfo,
    /// 关闭直播间
    LM_CloseLive,
    /// 退出直播间
    LM_ExitRoom,
    ///异常退出房间@{@"userRole":@(),@"roomId":@(),@"liveType":@()}
    LM_AbnormalExit,
    ///用户加入消息
    LM_UserJoinPlay,
    

#pragma mark - 互动和连麦 -
    
    //  开始连麦
    LM_StartVideoConnMic,
    /// 连麦完成
    LM_CloseVideoConnMic,
    ///发起连麦
    LM_LaunchConnMic,

    
 #pragma mark - PK -
    
    /// PK按钮被点击
    LM_LaunchPK,
    // PK 开始
    LM_StartPK,
    // PK完成
    LM_FinishPK,
    ///PK过程中礼物数据变化
    LM_ChangePKValue,


#pragma mark - 直播间信息组件发出的消息 -
    
   ///分享按钮被点击
    LM_ShareView,
    ///设置
    LM_SetRoomInfo,
    ///红包
    LM_SendRedPacket,
    ///修改房间公告
    LM_ChangeNotice,
    ///修改背景图
    LM_ChangeBackground,
    ///显示播放时长
    LM_ShowLiveTime,
    ///购买VIP
    LM_BuyVIP,
    ///守护
    LM_GuardInfo,
    ///联系方式
    LM_ContactInfo,
    /// 互动按钮被点击
    LM_InviteVideoInteraction,
    ///任务按钮被点击
    LM_ShowTask,
    ///幸运转盘
    LM_LuckySpin,
    ///邀请主播列表被点击
    LM_UI_anchorOnlineList,
    ///申请连麦列表被点击
    LM_UI_applyOnlineList,
    ///玩法规则被点击
    LM_GameRule,
    ///赠送靓号
    LM_LiangNum,
    ///购买贵宾席
    LM_buyVIPSeat,
    ///贵宾席列表
    LM_VIPSeatList,
    ///表情包
    LM_EmojiShow,
    ///音效氛围
    LM_SoundEffect,
    ///点击功能清屏
    LM_FunctionClearScreen,
    ///点击显示屏幕
    LM_FunctionShowScreen,
    ///举报用户
    LM_UserReport,
    ///房间所有所得
    LM_RoomTotalVotes,
    
#pragma mark - 游戏消息 -
    ///百宝箱
    LM_MagicBox,
    
    
    
#pragma mark - 其他组件消息 -
    
    /// 充值按钮点击
    LM_GotoRecharge,
    ///有权限观看直播
    LM_PromissionShow,
    ///显示文字消息
    LM_MessageForOther,
    
    
#pragma mark - 公共组件消息 -
    
    ///更多
    LM_MoreFunction,
    ///更新自己RTC相关的状态（相机，麦克风）
    LM_UpdateOwnRtcState,
    ///更新贵宾席
    LM_updateVIPSeat,
    
///※※粉丝团※※
    ///加入粉丝团
    LM_JoinFans,
    ///粉丝团列表+粉丝团编辑
    LM_SetFans,
    ///话费设置
    LM_O2OFeeSetting,
    
///※※礼物※※
    /// 弹出送礼选择礼物的消息
    LM_ShowGiftView,
    /// 魅力值变化
    LM_AnchorGiftNumber,
    ///添加送礼人 @{@"model":<GiftUserModel>}
    LM_AddSendGiftUser,
    ///删除送礼人 @{@"model":<GiftUserModel>}
    LM_RemoveSendGiftUser,
    ///整体替换送礼人 @{@"models":@[<GiftUserModel>]}
    LM_ChangeAllSendGiftUser,
    ///用户求赏
    LM_UserAskGift,
    
    
///※※消息组件※※
    /// 发消息按钮 （弹出聊天输入框） @{@"msg":@""}
    LM_SendMessage,
    
///※※音乐组件※※
    /// 显示选择音乐
    LM_SelectMusic,
    /// 关闭音乐的消息
    LM_StopMusic,
    
    
///※※用户信息组件※※
    /// 查看用户信息 （查看用户信息） @{@"userID":@(userID)}
    LM_ShowUserInfo,
    /// 发送观众主播
    LM_AttentionAnchor,
    
    
///※※心愿单※※
    /// 心愿单列表  @{@"models":NSArray <ApiUsersLiveWishModel>}
    LM_UpdateWishList,
    /// 心愿单添加被点击
    LM_AddWish,

    
#pragma mark - 一对一独有组件消息 -
    ///更改直播间内金币数  @{@"coin":@(coin)}
    LM_UpdateUserCoin,
    ///SVIP
    LM_OpenSVIP,
    ///福播用户加入
    LM_SvipUserJoin,
    ///福播用户推出
    LM_SvipUserExit,
    ///所有用户麦克风状态
    LM_UpdateOtoMicStatus,
    
    
#pragma mark - 语音间独有组件消息 - 
    
    ///麦位更新 @{@"model":NSArray<ApiUsersVoiceAssistanModel>}
    LM_UpdateSeats,
    ///更新PK麦位 @{@"model":<VoicePkVOModel>}
    LM_UpdatePKSeats,
    // 房间内PK准备
    LM_PrepareRoomPK,
    ///用户上下麦@{@"status":@(1/0)} 0下麦 1上麦
    LM_UpdateUserOnline,
    ///更新主播和副播的mic状态 ///用户上下麦@{@"status":@(1/0),@"userId":@(userId)} 0关麦 1开麦
    LM_UpdateUserMicState,
    ///更新主播表情包显示@{@"emoji":@""}
    LM_UpdateAnchorEmoji,
    ///点击下麦按钮
    LM_VoiceDowmMic,
    ///点击上麦按钮
    LM_VoiceUpMic,
    
    
#pragma mark - 视频间独有组件消息 -
    
    
#pragma mark - 直播购独有组件消息 -
    
    ///添加横幅
    LM_AddActivityBanner,
    ///展示商品
    LM_ShowShoppingGoods,
    ///设置直播商品
    LM_SetLiveGoods,
    ///商店商品详情
    LM_ShoppingGoodsDetail,
    ///讲解中的
    LM_GoodExplanation,
    ///横幅展示
    LM_ShoppingBanner,
    ///商店主页
    LM_StoreHomePage,
    
};


@protocol LiveComponentMsgListener <NSObject>

/// 监听事件
/// @param msgType 事件名称
/// @param msgDic 传递的参数
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary*)msgDic;


@end

NS_ASSUME_NONNULL_END
