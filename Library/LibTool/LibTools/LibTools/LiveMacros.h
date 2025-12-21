//
//  LiveMacros.h
//  LiveCommon
//
//  Created by klc_sl on 2020/4/28.
//  Copyright © 2020 . All rights reserved.
//

#ifndef LiveMacros_h
#define LiveMacros_h


#define liveChangeRoomNotify          @"liveChangeRoomNotify"
#define liveRoomExitNotify            @"liveRoomExitNotify"
#define liveRoomWillAppearNotify      @"liveRoomWillAppearNotify"
#define liveRoomMiniRecoverNotify     @"liveRoomMiniRecoverNotify"

//**  相对全屏的尺寸计算  **/

///主播互动视图
#define liveConnectViewH                (kScreenHeight * (238.0/640.0))
#define liveConnectViewY                (130 + kStatusBarHeight)

///观众连麦视图
#define liveLinkMicViewY                (kScreenHeight - kSafeAreaBottom - liveBottomViewH - liveLinkMicViewH - 10)
#define liveLinkMicViewW                ((kScreenWidth - 40 - 24)/3.0)
#define liveLinkMicViewH                (liveLinkMicViewW * 4.0 /3.0)

///直播间内banner的Y
#define liveFullSiteBanner              (kStatusBarHeight+55)  ///全站广播
#define liveOpenVIPBannerY              (kStatusBarHeight + 70)   ///贵族开通
#define liveGlobalGiftBannerY           (liveOpenVIPBannerY + 50)   ///世界礼物
#define liveRechangeBannerY             (liveGlobalGiftBannerY + 50)   ///充值礼物

#define liveNormal2GiftBannerY          (liveGlobalGiftBannerY +  88)   ///普通礼物2
#define liveNormal1GiftBannerY          (liveNormal2GiftBannerY + 100)   ///普通礼物1

#define liveGuardGiftBannerY            (kScreenHeight/2.0 - 60)   ///守护礼物
#define liveFansGiftBannerY             (kScreenHeight/2.0)         ///粉丝团礼物
#define liveVIPGiftBannerY              (liveFansGiftBannerY + 60)   ///贵族礼物
#define liveVIPJoinBannerY              (liveOpenVIPBannerY + 50)   ///贵族入场
#define liveMountJoinBannerY            (liveVIPJoinBannerY + 100)   ///坐骑入场
#define liveRichManJoinBannerY          (liveVIPJoinBannerY + 50)   ///土豪进场
 
///主播间头像视图宽度
#define liveHeaderBannerW                (160)   //贵族开通
#define liveHeaderBannerY                (kStatusBarHeight + 5)
#define liveHeaderBannerH                (44)

///底部视图的高度
#define liveBottomViewH                  (50)





//**  socket group name **/

/// 直播
#define socketGroupLive                  @"socketGroupLive"
/// 消息
#define socketGroupMessage               @"socketGroupMessage"
///短视频
#define socketShortVideo                @"socketShortVideo"
/// 全局
#define socketGroupGlobal                @"socketGroupGlobal"



#define kLocalizationMsg(key) NSLocalizedString(key, nil)








#endif /* LiveMacros_h */
