//
//  MicSeatManagerObj.m
//  MPAudioLive
//
//  Created by klc on 2020/6/10.
//  Copyright © 2020 klc. All rights reserved.
//

#import "MicSeatManagerObj.h"
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/ApiUsersVoiceAssistanModel.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjBase/LibProjBase.h>

@interface MicSeatManagerObj ()

@property (nonatomic, assign)BOOL isRequest;

@end

@implementation MicSeatManagerObj

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)clickMicSeat:(ApiUsersVoiceAssistanModel *)model {
    
    switch ([LiveManager liveInfo].roomRole) {
        case RoomRoleForAnchor:   /// -- 主播
        {
            if (model.uid == [ProjConfig userId]) {
                
                [LiveComponentMsgMgr sendMsg:(LM_ShowUserInfo) msgDic:@{@"userID":@(model.uid)}];
                
            }else{
                NSMutableArray *items = [[NSMutableArray alloc] init];
                if (model.status) { ///有人
                    [items addObject:@{@"type":@"3",@"title":kLocalizationMsg(@"让该用户下麦")}];
                    ///该麦位是否被禁言 1:是 0:否 默认0
                    if (model.noTalking == 1) {
                        [items addObject:@{@"type":@"6",@"title":kLocalizationMsg(@"解除禁麦")}];
                    }else{
                        [items addObject:@{@"type":@"5",@"title":kLocalizationMsg(@"禁麦")}];
                    }
                    [items addObject:@{@"type":@"4",@"title":kLocalizationMsg(@"查看用户信息")}];
                    
                }else{  ///无人
                    ///0封麦1未封麦
                    if (model.retireState) {
                        [items addObject:@{@"type":@"1",@"title":kLocalizationMsg(@"封麦")}];
                    }else{
                        [items addObject:@{@"type":@"2",@"title":kLocalizationMsg(@"解麦")}];
                    }
                }
                kWeakSelf(self);
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                for (NSDictionary *dic in items) {
                    [alertVC addAction:[UIAlertAction actionWithTitle:dic[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakself clickMicIdWithModel:model type:[dic[@"type"] intValue]];
                    }]];
                }
                [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
                [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
            }
        }
            break;
        case RoomRoleForBroadcaster:  ///-- 副播
        {
            if (model.status) { ///有人
                [self makeOhterUserInfo:model];
            }else{ ///无人
                [self authUpAssistan:model.no];
            }
        }
            break;
        default:   /// -- 观众
        {
            if (model.status) { ///有人
                [self makeOhterUserInfo:model];
            }else{ ///无人
                [self authUpAssistan:model.no];
            }
            
        }
            break;
    }
}

- (void)showOtherRoomUserInfo:(ApiUsersVoiceAssistanModel *)model{
    if (model.status) { ///有人
//        [LiveComponentMsgMgr sendMsg:(LM_ShowUserInfo) msgDic:@{@"userID":@(model.uid)}];
    }
}



///除了主播的其他人 点击其他人的头像
- (void)makeOhterUserInfo:(ApiUsersVoiceAssistanModel *)assistModel{
    ///管理员
    if ([LiveManager liveInfo].roomModel.role == 2 && (assistModel.uid != [ProjConfig userId] && assistModel.uid != [LiveManager liveInfo].anchorId) ) {
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:@{@"type":@"3",@"title":kLocalizationMsg(@"让该用户下麦")}];
        [items addObject:@{@"type":@"4",@"title":kLocalizationMsg(@"查看用户信息")}];
        kWeakSelf(self);
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSDictionary *dic in items) {
            [alertVC addAction:[UIAlertAction actionWithTitle:dic[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself clickMicIdWithModel:assistModel type:[dic[@"type"] intValue]];
            }]];
        }
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
        [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        [LiveComponentMsgMgr sendMsg:(LM_ShowUserInfo) msgDic:@{@"userID":@(assistModel.uid)}];
    }
}


- (void)authUpAssistan:(int)seatNo{
    if (!self.isRequest) {
        self.isRequest = YES;
        kWeakSelf(self);
        [HttpApiHttpVoice authUpAssistan:seatNo roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
            weakself.isRequest = NO;
            if (code != 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请稍等～")];
    }

}




- (void)clickMicIdWithModel:(ApiUsersVoiceAssistanModel *)model type:(int)type{
    
    switch (type) {
        case 1:   ///锁麦
        {
            [HttpApiHttpVoice lockAssistant:model.no retireState:0 roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
        }
            break;
        case 2:   ///解麦
        {
            [HttpApiHttpVoice lockAssistant:model.no retireState:1 roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
        }
            break;
        case 3:   ///让该用户下麦
        {
            [HttpApiHttpVoice kickOutAssistan:[LiveManager liveInfo].roomId userId:model.uid callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
        }
            break;
        case 4:   ///查看用户信息
        {
            [LiveComponentMsgMgr sendMsg:(LM_ShowUserInfo) msgDic:@{@"userID":@(model.uid)}];
        }
            break;
        case 5:   ///禁麦
        case 6:   ///解除禁麦
        {
            [HttpApiHttpVoice addNoTalking:model.anchorId roomId:model.roomId touid:model.uid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            }];
        }
            break;
        default:
            break;
    }
}


@end
