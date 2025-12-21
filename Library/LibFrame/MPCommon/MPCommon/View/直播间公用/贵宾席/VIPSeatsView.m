//
//  VIPSeatsView.m
//  LiveCommon
//
//  Created by klc on 2020/6/8.
//  Copyright © 2020 . All rights reserved.
//

#import "VIPSeatsView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjBase/ProjConfig.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>
#import <SDWebImage/SDWebImage.h>

@interface VIPSeatsView ()

@property (nonatomic, weak)UIImageView *userIcon;

@property (nonatomic, assign)BOOL isBuyVIPSeat;

@end

@implementation VIPSeatsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        ///默认需要购买
        _isBuyVIPSeat = 1;
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _userIcon.layer.cornerRadius = _userIcon.height/2.0;
}

- (void)createUI{
    
    ///贵宾席
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgV];
    _userIcon = imgV;
    imgV.userInteractionEnabled = YES;
    imgV.layer.masksToBounds = YES;
    imgV.image = [UIImage imageNamed:@"live_guibingxi_icon"];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    UIImageView *borderV = [[UIImageView alloc] init];
    borderV.image = [UIImage imageNamed:@"live_vipseat_border"];
    borderV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:borderV];
    [borderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imgV);
        make.size.equalTo(imgV).multipliedBy(7/5.0);
    }];
    
    [imgV layoutIfNeeded];

    kWeakSelf(self);
    [imgV klc_whenTapped:^{
        [weakself clickVipSeats];
    }];
}

- (void)clickVipSeats{
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
        [LiveComponentMsgMgr sendMsg:LM_VIPSeatList msgDic:nil];
    }else{
        if (self.isBuyVIPSeat) {
            [LiveComponentMsgMgr sendMsg:LM_buyVIPSeat msgDic:nil];
        }else{
            [LiveComponentMsgMgr sendMsg:LM_VIPSeatList msgDic:nil];
        }
    }
}


- (void)reloadVIPSeat:(NSDictionary *)dic{
    _isBuyVIPSeat = [dic[@"isNeed"] intValue]>0?YES:NO;
    if ([dic[@"avatar"] length] > 0) {
        [self.userIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]] placeholderImage:[ProjConfig getDefaultImage]];
    }else{
        self.userIcon.image = [UIImage imageNamed:@"live_guibingxi_icon"];
    }
}


@end
