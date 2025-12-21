//
//  OverallObserver.m
//  LibProjView
//
//  Created by klc on 2020/5/23.
//  Copyright © 2020 . All rights reserved.
//

#import "OverallObserver.h"
#import <LibProjView/RechangeSuccessNotice.h>
#import <LibProjView/OpenNobilityNotice.h>
#import <LibProjView/GiftGlobalNotice.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/ProjBaseData.h>
#import <LibProjView/OTOMessageBannerView.h>
#import <LibProjView/FullSiteNotice.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <TXImKit/TXImKit.h>
#import <LibProjView/UserTipObj.h>

@class AnchorMsgObserver;
@class MoneyMsgAllObserver;
@class PublicMsgAllObserver;
@class GradeRightMsgObserver;

@implementation OverallObserver

+ (void)addAllBanner{
    
    ///全局
    [[IMSocketIns getIns] addReceiver:socketGroupGlobal receiver:[[AnchorMsgObserver alloc] init]];

    [[IMSocketIns getIns] addReceiver:socketGroupGlobal receiver:[[MoneyMsgAllObserver alloc] init]];
    
    [[IMSocketIns getIns] addReceiver:socketGroupGlobal receiver:[[PublicMsgAllObserver alloc] init]];
    
    [[IMSocketIns getIns] addReceiver:socketGroupGlobal receiver:[[GradeRightMsgObserver alloc] init]];
}

@end



#pragma mark - 用户更新的全局消息 -

@implementation AnchorMsgObserver

/**
 主播认证成功推送socket
 @param user null
 */
- (void)onAnchorAuthUser:(ApiUserInfoModel* )user {
    [KLCUserInfo updateUserInfo:nil];
}

@end



#pragma mark - 消费的全局消息 -

@interface MoneyMsgAllObserver()

@property (nonatomic, copy)RechangeSuccessNotice *rechangeNotice;

@property (nonatomic, copy)OpenNobilityNotice *openNobilityNotice;

@end

@implementation MoneyMsgAllObserver


- (void)dealloc
{
    _rechangeNotice = nil;
    _openNobilityNotice = nil;
}

- (RechangeSuccessNotice *)rechangeNotice{
    if (!_rechangeNotice) {
        _rechangeNotice = [[RechangeSuccessNotice alloc] initWithSuperView:[ProjBaseData share].allBannerBgView];
    }
    return _rechangeNotice;
}


- (OpenNobilityNotice *)openNobilityNotice{
    if (!_openNobilityNotice) {
        _openNobilityNotice = [[OpenNobilityNotice alloc] initWithSuperView:[ProjBaseData share].allBannerBgView];
    }
    return _openNobilityNotice;
}

/**
 充值金币成功后通知前端
 @param coin 充值的金币数
 @param user null
 */
- (void)onUserRechargeCallbackMsg:(double)coin user:(ApiUserInfoModel *)user{
    [self.rechangeNotice playCongratulation:user coin:coin];
}

/**
 开通会员提示飘窗
 @param elasticFrame null
 */
-(void) onElasticFrameMember:(ApiElasticFrameModel *)elasticFrame{
    [self.openNobilityNotice playNotice:elasticFrame];
}

@end






#pragma mark - 直播间发出的全局消息 -

@interface PublicMsgAllObserver ()

@property (nonatomic, copy)FullSiteNotice *allSiteNotice;

@property (nonatomic, copy)GiftGlobalNotice *globalGiftNotice;
 
@end

@implementation PublicMsgAllObserver

- (void)dealloc
{
    _allSiteNotice = nil;
    _globalGiftNotice = nil;
}

/**
 直播间发消息全站广播
 @param roomId null
 @param apiSimpleMsgRoom null
 */
-(void) onMsgAllForBroadCast:(int64_t)roomId apiSimpleMsgRoom:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom {
    if (apiSimpleMsgRoom.type == 11) {
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:[ProjBaseData share].allBannerBgView];
        [self.allSiteNotice fullStationCongratulation:apiSimpleMsgRoom];
    }
}

/**
 全直播间飘屏信息
 @param apiGiftSender null
 */
-(void) onMsgAll:(ApiGiftSenderModel* )apiGiftSender {
    [self.globalGiftNotice playGlobalGift:apiGiftSender];
}

-(GiftGlobalNotice *)globalGiftNotice{
    if (!_globalGiftNotice) {
        _globalGiftNotice = [[GiftGlobalNotice alloc] initWithSuperView:[ProjBaseData share].allBannerBgView];
    }
    return _globalGiftNotice;
}

- (FullSiteNotice *)allSiteNotice{
    if (!_allSiteNotice) {
        _allSiteNotice = [[FullSiteNotice alloc]initWithSuperView:[ProjBaseData share].allBannerBgView];
    }
    return _allSiteNotice;
}



@end


#pragma mark - 全局任务升级提示 -
@interface GradeRightMsgObserver ()
///提示
@property (nonatomic, copy) UserTipObj *tipsObj;
 
@end

@implementation GradeRightMsgObserver

// MARK: - Socket -
/** 升级提示弹窗 */
-(void) onElasticFrameUpgrade:(ApiElasticFrameModel* )elasticFrame{
    [self.tipsObj showTipView:elasticFrame];
}

/** 完成任务弹框 */
-(void) onElasticFrameFinshTask:(ApiElasticFrameModel* )elasticFrame{
    [self.tipsObj showTipView:elasticFrame];
}

/** 获得勋章提示弹窗 */
-(void) onElasticFrameMedal:(ApiElasticFrameModel* )elasticFrame{
    [self.tipsObj showTipView:elasticFrame];
}

- (UserTipObj *)tipsObj{
    if (!_tipsObj) {
        _tipsObj = [[UserTipObj alloc] initWithSuperView:[ProjBaseData share].allBannerBgView];
    }
    return _tipsObj;
}


@end
