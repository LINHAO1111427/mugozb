//
//  UserMsgComponent.m
//  LiveCommon
//
//  Created by kalacheng on 2020/9/22.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserMsgComponent.h"

#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveManager.h>
#import "PresentNumberObj.h"
#import "PresentedGoodNumber.h"

@interface UserMsgComponent()<LiveComponentMsgListener,LiveComponentInterface>

///赠送靓号
@property (nonatomic, copy) PresentNumberObj *presentObj;

/// 第四层
@property (nonatomic, weak) UIView *fourthView;

@end

@implementation UserMsgComponent

- (void)dealloc{
    _presentObj = nil;
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    [LiveComponentMsgMgr addMsgListener:self];
    
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];

    // 第四层
    _fourthView = views[3];
}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
        case LM_LiangNum:{   ///靓号
            [self presentLiangNumber];
        }
            break;
        case LM_ExitRoom:
        case LM_LiveLeaveInfo:{
            _presentObj = nil;
        }
            break;
        default:
            break;
    }
}


- (PresentNumberObj *)presentObj{
    if (!_presentObj) {
        _presentObj = [[PresentNumberObj alloc] initWithSuperView:_fourthView];
    }
    return _presentObj;;
}

/**
 赠送靓号推送公告内容
 @param user null
 */
- (void)onUsersBeautifulNumber:(ApiBeautifulNumberModel *)user {
    [self.presentObj playPresentNumberView:user];
}

- (void)presentLiangNumber{
    [PresentedGoodNumber presentNumber:[LiveManager liveInfo].anchorId userName:[LiveManager liveInfo].anchorName userIcon:[LiveManager liveInfo].anchorIcon];
}


@end
