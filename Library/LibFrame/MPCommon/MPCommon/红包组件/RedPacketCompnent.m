//
//  RedPacketCompnent.m
//  LiveCommon
//
//  Created by klc_sl on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RedPacketCompnent.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LibProjView/OpenRedPacketView.h>
#import "LiveRedPacketView.h"
#import <LiveCommon/LiveManager.h>
#import <LibProjView/RedPacketSendView.h>

@interface RedPacketCompnent ()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, weak)UIView *secondView;

@property (nonatomic, strong)OneRedPacketVOModel *voModel;

@property (nonatomic, weak)LiveRedPacketView *packetView;

@end

@implementation RedPacketCompnent

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views {

    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    _secondView = views[1];

}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        case LM_LiveLeaveInfo:
        case LM_ExitRoom: /// 点击关闭
        {
        }
            break;
        case LM_SendRedPacket:
        {
            [RedPacketSendView showLiveRedPtForAnchorId:[LiveManager liveInfo].anchorId liveType:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId liveShowId:[LiveManager liveInfo].serviceShowId];
        }
            break;
        case LM_LiveRoomInfo:
        {
            [self onSendRedPacket:[LiveManager liveInfo].roomModel.oneRedPacketVO];
        }
            break;
        default:
            break;
    }
}



// MARK: - Socket -
- (void)onSendRedPacket:(OneRedPacketVOModel *)oneRedPacketVO {
    _voModel = oneRedPacketVO;
    if (oneRedPacketVO.redPacketAmount > 0) {
        [self.packetView showPacketInfo:oneRedPacketVO.redPacketAmount];
    }else{
        [_packetView removeFromSuperview];
    }
}

- (LiveRedPacketView *)packetView{
    if (!_packetView) {
        kWeakSelf(self);
        LiveRedPacketView *packet = [[LiveRedPacketView alloc] initWithFrame:CGRectMake(15, liveHeaderBannerH+liveHeaderBannerY+70, 65, 62)];
        [_secondView addSubview:packet];
        [packet klc_whenTapped:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [OpenRedPacketView showRedPicket:weakself.voModel openType:[LiveManager liveInfo].serviceLiveType openHandle:nil];
            });
        }];
        _packetView = packet;
    }
    return _packetView;
}

@end
