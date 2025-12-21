//
//  MPOtherLinkAnchorView.m
//  MPVideoLive
//
//  Created by klc_sl on 2021/8/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MPOtherLinkAnchorView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/CheckRoomPermissions.h>

@implementation MPOtherLinkAnchorView


- (void)dealloc
{
    [_moreBtn removeAllSubViews];
    _moreBtn = nil;
    [_playImgV stop];
    [_playImgV removeFromSuperview];
    _playImgV = nil;
}

- (instancetype)initWithFrame:(CGRect)frame interactionBgView:(UIView *)handleView
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI:handleView];
    }
    return self;
}

- (void)createUI:(UIView *)handleView{
    
    PlayVideoView *playVideoV = [[PlayVideoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    playVideoV.backgroundColor = [UIColor blackColor];
    playVideoV.userInteractionEnabled = NO;
    playVideoV.layer.masksToBounds = YES;
    playVideoV.layer.cornerRadius = 0.0;
    playVideoV.clipsToBounds = YES;
    [self addSubview:playVideoV];
    _playImgV = playVideoV;
    [playVideoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [playVideoV layoutIfNeeded];
    
    UIButton *jumpBtn = [UIButton buttonWithType:0];
//    [jumpBtn setTitle:kLocalizationMsg(@"进入对方直播间 >>") forState:UIControlStateNormal];
//    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [jumpBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    [jumpBtn addTarget:self action:@selector(jumpOtherAnchorRoom) forControlEvents:UIControlEventTouchUpInside];
    [handleView addSubview:jumpBtn];
    self.moreBtn = jumpBtn;
    jumpBtn.hidden = YES;
}

- (void)setOtherRoomId:(int64_t)otherRoomId{
    _otherRoomId = otherRoomId;
    self.moreBtn.hidden = NO;
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
        make.bottom.right.top.equalTo(self.superview);
    }];
}

- (void)jumpOtherAnchorRoom{
    [[CheckRoomPermissions share] joinRoom:self.otherRoomId liveDataType:LiveTypeForMPVideo joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
        req.joinPosition = 1;
        [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:req];
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [[CheckRoomPermissions share] showDetail:dtoModel currentVC:[ProjConfig currentVC]];
    } fail:nil];
    
}


@end

