//
//  LiveInfomation.m
//  TCDemo
//
//  Created by CH on 2019/10/31.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveInfomation.h"
#import <libProjModel/OOOReturnModel.h>
#import <libProjModel/OTMAssisRetModel.h>
#import <libProjBase/ProjConfig.h>
#import <LibTools/LibTools.h>
#import <LibTools/BaseMacroDefinition.h>
#import <LibProjModel/ApiUsersVoiceAssistanModel.h>

@implementation LiveInfomation

- (void)dealloc
{
    _o2oModel = nil;
    _roomModel = nil;
    _oneViewConfig = nil;
    _mpViewConfig = nil;
}


- (void)setRoomModel:(AppJoinRoomVOModel *)roomModel{
    _roomModel = roomModel;
    
    {
        switch (roomModel.liveType) {
            case 1:
                _liveType = roomModel.liveFunction?LiveTypeForShoppingLive:LiveTypeForMPVideoLive;
                break;
            case 2: ///语音
                _liveType = LiveTypeForMPAudioLive;
                break;
            default:
                break;
        }
    }

    _roomId = roomModel.roomId;
    _serviceLiveType = roomModel.liveType;
    _serviceShowId = [roomModel.showid length]?roomModel.showid:@"";
    _anchorId = roomModel.anchorId;
    _anchorIcon = [roomModel.anchorAvatar length]?roomModel.anchorAvatar:@"";
    _anchorName = [roomModel.anchorName length]?roomModel.anchorName:@"";
}


- (void)setO2oModel:(OOOReturnModel *)o2oModel{
    _o2oModel = o2oModel;
    
    _liveType = LiveTypeForOneToOne;
    
    _roomId = o2oModel.roomId;
    _serviceLiveType = o2oModel.type;
    _serviceShowId = [o2oModel.showid length]?o2oModel.showid:@"";
    for (OTMAssisRetModel *userModel in o2oModel.otmAssisRetList) {
        if (userModel.userToRoomRole == 1) {
            _anchorId = userModel.userId;
            _anchorIcon = [userModel.userAvatar length]?userModel.userAvatar:@"";
            _anchorName = [userModel.userName length]?userModel.userName:@"";
        }
    }
}


- (CGRect)getAudioSeatFrame{
    CGFloat viewH = 0;
    CGFloat viewY = liveConnectViewY+40;
    switch (_pkType) {
        case LivePKTypeForRoom:
        {
            viewH = 220;
        
            CGFloat height = (viewH-160-2)/2.0;
            if (height > 20) {
                viewH -= (height-20);
            }
            
        }
            break;
        case LivePKTypeForTeam:
        {
//            viewH = 240;
            viewH = kScreenHeight * 260/480.0;
            viewY -= 30;
        }
            break;
        case LivePKTypeForSingle:
        {
            viewH = 120;
        }
            break;
        default:
        {
            viewH = 220;
            CGFloat height = (viewH-160-2)/2.0;
            if (height > 20) {
                 viewH -= (height-20);
            }
        }
            break;
    }
    viewH = MIN((liveConnectViewH - 40), viewH);
    CGRect pkRc = CGRectMake(0, viewY, kScreenWidth, viewH);
    return pkRc;
}


@end
