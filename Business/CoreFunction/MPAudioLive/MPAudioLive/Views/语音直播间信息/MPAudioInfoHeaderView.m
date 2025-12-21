//
//  MPAudioInfoHeaderView.m
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MPAudioInfoHeaderView.h"
#import <LiveCommon/MPLiveInfoHeaderInterface.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjModel/ApiUserBasicInfoModel.h>
#import <LiveCommon/LiveManager.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>

#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <LibProjView/WishShowFlowView.h>
#import <LibTools/LiveMacros.h>
#import <LibProjView/SoundWaveView.h>

#import <LiveCommon/LiveTimekeeping.h>
#import <LiveCommon/AnchorWealthView.h>

#import <MPCommon/VIPSeatsView.h>
#import <MPCommon/LiangNumShowView.h>
#import <MPCommon/TrySeeCountDownView.h>
#import <MPCommon/GuardUserShowView.h>
#import <MPCommon/RoomAudienceFlowShowView.h>

#import "YYLiveHeaderView.h"

@interface MPAudioInfoHeaderView ()<MPLiveInfoHeaderInterface>


@property (nonatomic, weak) AnchorWealthView *roomHotV;     /// 火力值
@property (nonatomic, weak) YYLiveHeaderView *headerV; /// 主播信息view

@property (nonatomic, weak) RoomAudienceFlowShowView *userView;
@property (nonatomic, weak) GuardUserShowView *guardView;   ///守护视图
@property (nonatomic, weak) WishShowFlowView *wishView;     ///心愿单视图
//@property (nonatomic, weak) LiangNumShowView *liangV;    ///靓号
@property (nonatomic, weak) VIPSeatsView *vipSeats;          ///贵宾席

@property (nonatomic, weak) TrySeeCountDownView *timeCountDownV;    ///试看倒计时

@end

@implementation MPAudioInfoHeaderView


+ (instancetype)register{
    return [[MPAudioInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight+100)];
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
    AppJoinRoomVOModel *model = [LiveManager liveInfo].roomModel;
    NSString *colorHex = @"#FFFFFF";
    ///性别1男2女3其他
    Class<MPLiveInterface> cls = [LiveManager liveInfo].mpViewConfig;
    if ([cls respondsToSelector:@selector(soundWaveColor:)]) {
        colorHex = [cls soundWaveColor:model.anchorSex];
    }
    YYLiveHeaderView *headerV = [[YYLiveHeaderView alloc] init];
    headerV.layer.masksToBounds = YES;
    [self addSubview:headerV];
    _headerV = headerV;
    
    ///火力值
    AnchorWealthView *hotV = [[AnchorWealthView alloc] init];
    [self addSubview:hotV];
    _roomHotV = hotV;
    
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
    
    ///靓号
//    LiangNumShowView *lianghaoV = [[LiangNumShowView alloc] init];
//    [self addSubview:lianghaoV];
//    _liangV = lianghaoV;
    
    //试看时长
    TrySeeCountDownView *countDown = [[TrySeeCountDownView alloc] init];
    countDown.hidden = YES;
    [self addSubview:countDown];
    _timeCountDownV = countDown;
    
    ///玩法按钮
    UIButton *addBtn = [UIButton buttonWithType:0];
    addBtn.layer.masksToBounds = YES;
    [addBtn setTitle:kLocalizationMsg(@"+ 玩法") forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    addBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    
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
    
    [wishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerV);
        make.top.equalTo(hotV.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

    
//    [lianghaoV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(guardView);
//        make.top.equalTo(guardView.mas_bottom).mas_offset(10);
//        make.height.mas_equalTo(20);
//    }];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(hotV);
//        make.left.equalTo(hotV.mas_right).mas_offset(10);
//        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.right.equalTo(guardView);
        make.top.equalTo(guardView.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [countDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(105, 105));
        make.top.equalTo(addBtn.mas_bottom).inset(10);
        make.right.equalTo(addBtn);
    }];
    [addBtn layoutIfNeeded];
    addBtn.layer.cornerRadius = addBtn.height/2.0;
}


- (void)reloadRoomData{
    AppJoinRoomVOModel *model = [LiveManager liveInfo].roomModel;
    // 头像
    [_headerV.iconBtn sd_setImageWithURL:[NSURL URLWithString:(model.liveThumb.length>0?model.liveThumb:model.anchorAvatar)] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    // 名称
    _headerV.nameL.text = model.title;
    _headerV.roomID.text = [NSString stringWithFormat:kLocalizationMsg(@"房间ID:%lld"),model.roomId];
   // NSLog(@"过滤文字=====主播名称=====%@"),model.anchorName);
    [_headerV anchorSelfShowFollowBtn:(model.anchorId == [KLCUserInfo getUserId])?NO:YES];
    [_headerV attentionAnchor:model.isFollow];
    
    [self.wishView loadWishList:[LiveManager liveInfo].anchorId];
    [self.guardView reloadData];
    
    _roomHotV.hotL.text = [NSString stringWithFormat:@"%0.0lf",model.roomTotalVotes];
    
//    if ([model.goodnum hasValue]) {
//        _liangV.liangNumL.text = model.goodnum;
//    }else{
//        _liangV.liangNumL.text = [NSString stringWithFormat:@"%lld",model.anchorId];
//    }

    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor || [LiveManager liveInfo].anchorId == [ProjConfig userId]) {

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

- (void)reloadVipSeat:(NSDictionary *)vipSeatDic{
    [_vipSeats reloadVIPSeat:vipSeatDic];
}


- (void)addBtnClick{
    [LiveComponentMsgMgr sendMsg:LM_GameRule msgDic:nil];
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
   ///空
}

- (void)updateRoomVotesNumber:(double)coin{
    _roomHotV.hotL.text = [NSString stringWithFormat:@"%0.0lf",coin];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}


@end
