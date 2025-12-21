//
//  MPVideoInfoHeaderView.m
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MPVideoInfoHeaderView.h"
#import <LiveCommon/MPLiveInfoHeaderInterface.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjModel/ApiUserBasicInfoModel.h>
#import <LiveCommon/LiveManager.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>

#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <MPCommon/RoomAudienceFlowShowView.h>
#import <MPCommon/GuardUserShowView.h>
#import <LiveCommon/AnchorWealthView.h>
#import <MPCommon/VIPSeatsView.h>
#import <MPCommon/LiangNumShowView.h>

#import <LibProjView/WishShowFlowView.h>
#import <LibTools/LiveMacros.h>
#import <MPCommon/TrySeeCountDownView.h>
#import <LiveCommon/LiveTimekeeping.h>
#import "AnchorHeaderView.h"

@interface MPVideoInfoHeaderView ()<MPLiveInfoHeaderInterface>


@property (nonatomic, weak) AnchorWealthView *hotV;     /// 火力值
@property (nonatomic, weak) AnchorHeaderView *headerV; /// 主播信息view

@property (nonatomic, weak) RoomAudienceFlowShowView *userView;
@property (nonatomic, weak) GuardUserShowView *guardView;   ///守护视图
@property (nonatomic, weak) WishShowFlowView *wishView;     ///心愿单视图
@property (nonatomic, weak) VIPSeatsView *vipSeats;          ///贵宾席
@property (nonatomic, weak) LiangNumShowView *liangV;    ///靓号

@property (nonatomic, weak) TrySeeCountDownView *timeCountDownV;    ///试看倒计时

@end

@implementation MPVideoInfoHeaderView


+ (instancetype)register{
    return [[MPVideoInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight+100)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    ////用户信息
    // 头像背景图
    AnchorHeaderView *headerV = [[AnchorHeaderView alloc] init];
    headerV.layer.masksToBounds = YES;
    [self addSubview:headerV];
    _headerV = headerV;
    
    ///主播火力值
    AnchorWealthView *hotV = [[AnchorWealthView alloc] init];
    [self addSubview:hotV];
    _hotV = hotV;
    
    ///房间用户列表
    RoomAudienceFlowShowView *userListV = [[RoomAudienceFlowShowView alloc] init];
    [self addSubview:userListV];
    _userView = userListV;
    
    ///守护按钮
    GuardUserShowView *guardView = [[GuardUserShowView alloc] init];
    [self addSubview:guardView];
    _guardView = guardView;
    
    ///心愿单视图
    WishShowFlowView *wishView = [[WishShowFlowView alloc] init];
    [self addSubview:wishView];
    _wishView = wishView;
    
    ///贵宾席
    VIPSeatsView *vipSeats = [[VIPSeatsView alloc] init];
    [self addSubview:vipSeats];
    _vipSeats = vipSeats;
    
    //靓号
    LiangNumShowView *lianghaoV = [[LiangNumShowView alloc] init];
    [self addSubview:lianghaoV];
    _liangV = lianghaoV;
    
    TrySeeCountDownView *countDown = [[TrySeeCountDownView alloc] init];
    countDown.hidden = YES;
    [self addSubview:countDown];
    _timeCountDownV = countDown;
    
    // 动态计算
    kWeakSelf(self);
    [headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).mas_offset(12);
        make.top.equalTo(weakself).mas_offset(liveHeaderBannerY);
        make.size.mas_equalTo(CGSizeMake(liveHeaderBannerW, liveHeaderBannerH));
    }];
    
    [hotV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.equalTo(headerV.mas_bottom).mas_offset(10);
        make.left.equalTo(headerV);
    }];
    
    [userListV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerV);
        make.right.equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(30);
    }];
    
    [wishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerV);
        make.top.equalTo(hotV.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [guardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(-12);
        make.centerY.equalTo(hotV);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [vipSeats mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userListV);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.right.equalTo(userListV.mas_left).mas_offset(-10);
    }];
    
    [lianghaoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(guardView);
        make.top.equalTo(guardView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_greaterThanOrEqualTo(90);
    }];
    
    [countDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(105, 105));
        make.top.equalTo(lianghaoV.mas_bottom).mas_offset(10);
        make.right.equalTo(lianghaoV);
    }];
    
    if ([ProjConfig userId] == [LiveManager liveInfo].roomModel.anchorId) {
        _liangV.hidden = YES;
    }
    
}


- (void)reloadRoomData{
    AppJoinRoomVOModel *model = [LiveManager liveInfo].roomModel;
    // 头像
    [_headerV.iconBtn sd_setImageWithURL:[NSURL URLWithString:model.anchorAvatar] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    // 名称
    _headerV.nameL.text = model.anchorName;
   // NSLog(@"过滤文字=====主播名称=====%@"),model.anchorName);
    [_headerV anchorSelfShowFollowBtn:(model.anchorId == [KLCUserInfo getUserId])?NO:YES];
    [_headerV attentionAnchor:model.isFollow];
    
    [self.wishView loadWishList:[LiveManager liveInfo].anchorId];
    [self.guardView reloadData];
    _hotV.hotL.text = [NSString stringWithFormat:@"%0.0lf",model.votes];
    
    if ([model.anchorGoodNum hasValue]) {
        _liangV.liangNumL.text = model.anchorGoodNum;
    }else{
        _liangV.liangNumL.text = [NSString stringWithFormat:@"%lld",model.anchorId];
    }

    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
    }else{
        kWeakSelf(self);
       // NSLog(@"过滤文字试看时长～～～～～～～%d"),model.freeWatchTime);
        if (model.freeWatchTime > 0) {
            __block int trialTime = model.freeWatchTime;
            [LiveManager liveInfo].roomModel.freeWatchTime = -1;
            _timeCountDownV.hidden = NO;
            weakself.timeCountDownV.lastTimeL.text = [NSString stringWithFormat:@"%d",trialTime];
            [[LiveTimekeeping share] addTimerObserver:self timeBlock:^(int64_t currentTime) {
                if (trialTime >= 0) {
                    weakself.timeCountDownV.lastTimeL.text = [NSString stringWithFormat:@"%d",trialTime];
                    --trialTime;
                }else{
                    [LiveComponentMsgMgr sendMsg:LM_PromissionShow msgDic:nil];
                    [[LiveTimekeeping share] removeTimerObserver:weakself];
                    weakself.timeCountDownV.hidden = YES;
                    [weakself.timeCountDownV removeFromSuperview];
                }
            }];
        }
    }
    
}

///更新贵宾席
- (void)reloadVipSeat:(NSDictionary *)vipSeatDic{
    [_vipSeats reloadVIPSeat:vipSeatDic];
}


- (void)attentionAnchor:(BOOL)isAtten{
    [_headerV attentionAnchor:isAtten];
}


- (void)reloadAnchorWishList:(NSArray<ApiUsersLiveWishModel *> *)wishList{
    _wishView.wishList = wishList;
}

- (void)reloadGuardUserList:(NSArray<GuardUserVOModel *> *)guardList {
    [_guardView showGuardUser:guardList];
}

- (void)reloadAudienceNumber:(NSArray<ApiUserBasicInfoModel *> *)audienceListModel userWatchNumber:(int)userWatchNumber {
    [LiveManager liveInfo].roomModel.watchNumber = userWatchNumber;
    [_userView showUserInfo:audienceListModel userWatchNumber:userWatchNumber];
}


///更新主播的魅力值
- (void)updateAnchorVotesNumber:(double)coin {
    _hotV.hotL.text = [NSString stringWithFormat:@"%0.0lf",coin];
}

- (void)updateRoomVotesNumber:(double)coin{
//    _hotV.hotL.text = [NSString stringWithFormat:@"%0.0lf",coin];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}

@end
