//
//  CheckRoomPermissions.m
//  TCDemo
//
//  Created by admin on 2019/10/28.
//  Copyright © 2019 CH. All rights reserved.
//

#import "CheckRoomPermissions.h"
#import <LibProjModel/HttpApiHttpLive.h>
#import <LibProjView/ForceAlertController.h>

#import <TXImKit/TXImKit.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <objc/runtime.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiHome.h>
#import <LibProjBase/ProjBaseData.h>
#import <LibProjBase/HttpClient.h>

@interface CheckRoomPermissions ()

///加入房间的回调
@property (nonatomic, copy)void (^JoinRoomBlock)(AppJoinRoomVOModel * _Nonnull);
///加入房间失败回调
@property (nonatomic, copy)void (^failBlock)(JoinRoomFailType);

@property (nonatomic, assign) BOOL isRequestUrl;

@end

@implementation CheckRoomPermissions


+ (instancetype)share{
    static CheckRoomPermissions *_check = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_check) {
            _check = [[CheckRoomPermissions alloc] init];
        }
    });
    return _check;
}


- (BOOL)checkStop{
    ///yes说明调用了房间接口不能加入房间
    if (self.isRequestUrl) {
        return NO;
    }else{
        [HttpClient cancelRequest];
        return YES;
    }
}

///判断用户当前的状态
- (void)checkUserState:(int64_t)roomId stateBlock:(void(^)(BOOL success))stateBlock{
    
    switch ([ProjBaseData share].userState) {
        case 1: ///主播身份直播中
        {
            if (roomId == [ProjBaseData share].roomId) { ///是自己的房间
                [[NSNotificationCenter defaultCenter] postNotificationName:liveRoomMiniRecoverNotify object:nil];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"你正在直播中，不能进入其他直播间")];
            }
            if (stateBlock) {
                stateBlock(NO);
            }
        }
            break;
        case 2: /// 一对一中
        {
            if (roomId == [ProjBaseData share].roomId) { ///是自己当前的房间
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"你已经在当前直播间内")];
                if (stateBlock) {
                    stateBlock(NO);
                }
            }else{
                if (stateBlock) {
                    stateBlock(YES);
                }
            }
        }
            break;
        case 3: /// 用户身份在直播间内
        {
            if (roomId == [ProjBaseData share].roomId) { ///是自己当前的房间
                if ([ProjBaseData share].isMiniRoom) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:liveRoomMiniRecoverNotify object:nil];
                }else{
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"你已经在当前直播间内")];
                }
                
                if (stateBlock) {
                    stateBlock(NO);
                }
            }else{
                ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"去TA的直播间")];
                [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
                [alert addOptions:kLocalizationMsg(@"确认") textColor:ForceAlert_NormalColor clickHandle:^{
                    if (stateBlock) {
                        stateBlock(YES);
                    }
                }];
                [[ProjConfig currentVC] presentViewController:alert animated:YES completion:nil];
            }
        }
            break;
        default: ///空闲
        {
            if (stateBlock) {
                stateBlock(YES);
            }
        }
            break;
    }
}

///直播类型判断
- (void)liveModel:(AppHomeHallDTOModel *)model resultHandle:(void(^)(BOOL success, NSString *password))handle{
    
    UIViewController *vc = [ProjConfig currentVC];
    
    __block NSString *password = @"";
    ///房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
    switch (model.roomType) {
        case 1:   //1是私密直播
        {
            if (model.typeVal.length > 0) {
                
                if (handle) {
                    handle(YES, model.typeVal);
                }
                
            }else{
                
                CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"密码房间") message:@"" liveType:LiveTypeForPasswordOther];
                customAlert.clickCancelBlock = ^{
                    if (handle) {
                        handle(NO, password);
                    }
                };
                
                customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
                    if (handle) {
                        handle(YES, passwordStr);
                    }
                };
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [vc presentViewController:customAlert animated:YES completion:nil];
                });
                
            }
            
        }
            break;
        case 2:   //2是收费直播
        {
            if (model.freeWatchTime == 0 && model.isPay) {
                
                CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"门票房间") message:[NSString stringWithFormat:@"%.0f",[model.typeVal doubleValue]] liveType:LiveTypeForTicket];
                customAlert.clickCancelBlock = ^{
                    if (handle) {
                        handle(NO, password);
                    }
                };
                
                customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
                    if (handle) {
                        handle(YES, password);
                    }
                };
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [vc presentViewController:customAlert animated:YES completion:nil];
                });
            }else{
                
                if (handle) {
                    handle(YES, password);
                }
            }
            
        }
            break;
        case 3:   //3是计时直播
        {
            if (model.freeWatchTime == 0) {
                CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"计时房间") message:[NSString stringWithFormat:@"%.0f",[model.typeVal doubleValue]] liveType:LiveTypeForTime];
                customAlert.clickCancelBlock = ^{
                    if (handle) {
                        handle(NO, password);
                    }
                };
                customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
                    if (handle) {
                        handle(YES, password);
                    }
                };
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [vc presentViewController:customAlert animated:YES completion:nil];
                });
            }else{
                if (handle) {
                    handle(YES, password);
                }
            }
            
        }
            break;
        case 4:   //4是贵族房间
        {
            if (handle) {
                handle(YES, password);
            }
        }
            break;
        default:  // 0是一般直播
        {
            if (handle) {
                handle(YES, password);
            }
        }
            break;
    }
}


- (void)showDetail:(AppHomeHallDTOModel *)dtoModel currentVC:(UIViewController *)currentVC{
    switch (dtoModel.liveType) {
        case 3:  ///显示用户信息
        {
            [RouteManager routeForName:RN_user_userInfoVC currentC:currentVC parameters:@{@"id":@(dtoModel.userId)}];
        }
            break;
        case 1:  ///1:直播
        {
            //            [RouteManager routeForName:RN_user_userInfoVC currentC:currentVC parameters:@{@"id":@(dtoModel.userId)}];
            //            ///进入关播信息
            [RouteManager routeForName:RN_live_liveCloseVC currentC:currentVC parameters:@{@"model":dtoModel,@"liveType":@(1)}];
        }
            break;
        case 2:  ///2:语音
        {
            [RouteManager routeForName:RN_user_userInfoVC currentC:currentVC parameters:@{@"id":@(dtoModel.userId)}];
        }
            break;
        case LiveTypeForShortVideo:  ///短视频
        case LiveTypeForDynamic:    ///动态
        {
            
        }
            break;
        default:
            
            break;
    }
}

- (void)joinRoomForModel:(AppJoinRoomVOModel *)voModel currentVC:(UIViewController *)currentVC otherInfo:(LiveRoomListReqParam *)otherInfo{
    ///直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [muDic setObject:voModel forKey:@"model"];
    if (otherInfo) {
        [muDic setObject:otherInfo forKey:@"reqParam"];
    }
    
    switch (voModel.liveType) {
        case 1:
        {
            [RouteManager routeForName:RN_live_liveForAudienceVC currentC:currentVC parameters:muDic];
        }
            break;
        case 2:
        {
            [RouteManager routeForName:RN_live_audioForAudienceVC currentC:currentVC parameters:muDic];
        }
            break;
        default:
        {
            [RouteManager routeForName:RN_live_liveForAudienceVC currentC:currentVC parameters:muDic];
        }
            break;
    }
}

- (void)joinRoom:(int64_t)roomId liveDataType:(CheckLiveDataType)liveDataType joinRoom:(void (^)(AppJoinRoomVOModel * _Nonnull))joinRoom closeRoom:(void (^)(AppHomeHallDTOModel * _Nonnull))closeRoom fail:(void (^ _Nullable)(JoinRoomFailType))fail{
    kWeakSelf(self);
    if ([self checkStop]) {  ///如果已经暂停
        ///liveType类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
        int liveType = (liveDataType>0)?liveDataType:-1;
        if (liveType == -1) { ///短视频和动态
           // NSLog(@"过滤文字checkroomPermissions:未知数据类型"));
            fail?fail(JoinRoomFailTypeForOther):nil;
        } else if (liveType == 1 || liveType == 2) { ///视频和语音
            ///返回数据添加
            _JoinRoomBlock = joinRoom;
            _failBlock = fail;
            ///获取当前房间的最新数据
            [HttpApiHome getHomeDataInfo:liveType roomId:roomId callback:^(int code, NSString *strMsg, AppHomeHallDTOModel *model) {
                if (code == 1) {
                    if (liveType == 1 || liveType == 2) {//视频多人直播
                        
                        if (model.sourceState != 6) {
                            ///关播信息
                            closeRoom?closeRoom(model):nil;
                        }else{
                            ///判断用户的状态是否能进入直播间
                            [weakself checkUserState:roomId stateBlock:^(BOOL success) {
                                
                                if (success) {
                                    ///判断当前房间的类型
                                    [weakself liveModel:model resultHandle:^(BOOL success, NSString *password) {
                                        if (success) {
                                            ///加入房间
                                            [weakself joinRoom:model.roomId liveType:model.liveType roomType:model.roomType password:password];
                                            
                                        }else{
                                           // NSLog(@"过滤文字checkroomPermissions:取消进入房间"));
                                            fail?fail(JoinRoomFailTypeForOther):nil;
                                        }
                                    }];
                                    
                                }else{
                                   // NSLog(@"过滤文字checkroomPermissions:当前用户状态不能进入直播间"));
                                    fail?fail(JoinRoomFailTypeForOther):nil;
                                }
                            }];
                        }
                    }else{
                       // NSLog(@"过滤文字checkroomPermissions:非多人直播间类型"));
                        fail?fail(JoinRoomFailTypeForOther):nil;
                    }
                }else{
                    ///请求接口报错
                    [SVProgressHUD showInfoWithStatus:strMsg];
                   // NSLog(@"过滤文字checkroomPermissions:%@"),strMsg);
                    fail?fail(JoinRoomFailTypeForOther):nil;
                }
                
            }];
            
        } else { ///其他
           // NSLog(@"过滤文字checkroomPermissions:非多人直播间类型"));
            fail?fail(JoinRoomFailTypeForOther):nil;
        }
    }
}

///roomType 房间类型0是一般直播，1是私密直播，2是收费直播，3是计时直播4贵族房间
///liveType类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
- (void)joinRoom:(int64_t)roomId liveType:(int)liveType roomType:(int)roomType password:(NSString *)password{
    
    if (self.isRequestUrl) {
        return;
    }
    
    self.isRequestUrl = YES;
    
    kWeakSelf(self);
    
    switch (liveType) {
        case 1:  ///视频直播间
        {
            [HttpApiHttpLive joinRoom:roomId roomType:roomType roomTypeVal:password callback:^(int code, NSString *strMsg, AppJoinRoomVOModel *model) {
                if (code == 1) {
                    if (!weakself.noNotifyForOnceAtChangeRoom) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:liveChangeRoomNotify object:nil];
                    }else{
                        weakself.noNotifyForOnceAtChangeRoom = NO;
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakself joinImRoom:model.roomId frequency:3];
                    });
                    weakself.JoinRoomBlock?weakself.JoinRoomBlock(model):nil;
                }else if (code == 99){
                    weakself.failBlock?weakself.failBlock(JoinRoomFailTypeForVIP):nil;
                    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"贵族房间") message:@"" liveType:LiveTypeForNoble];
                    customAlert.clickCancelBlock = ^{};
                    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
                        [RouteManager routeForName:RN_User_buyVIP currentC:[ProjConfig currentVC] parameters:nil];
                    };
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[ProjConfig currentVC] presentViewController:customAlert animated:YES completion:nil];
                    });
                }else{
                    weakself.failBlock?weakself.failBlock(JoinRoomFailTypeForOther):nil;
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
                weakself.isRequestUrl = NO;
            }];
        }
            break;
        case 2:   ///语音房间
        {
            [HttpApiHttpVoice joinVoiceRoom:roomId roomType:roomType roomTypeVal:password callback:^(int code, NSString *strMsg, AppJoinRoomVOModel *model) {
                if (code == 1) {
                     
                    if (!weakself.noNotifyForOnceAtChangeRoom) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:liveChangeRoomNotify object:nil];
                    }else{
                        weakself.noNotifyForOnceAtChangeRoom = NO;
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakself joinImRoom:model.roomId frequency:3];
                    });
                    weakself.JoinRoomBlock?weakself.JoinRoomBlock(model):nil;
                }else if (code == 99){
                    weakself.failBlock?weakself.failBlock(JoinRoomFailTypeForVIP):nil;
                    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"贵族房间") message:@"" liveType:LiveTypeForNoble];
                    customAlert.clickCancelBlock = ^{};
                    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
                        [RouteManager routeForName:RN_User_buyVIP currentC:[ProjConfig currentVC] parameters:nil];
                    };
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[ProjConfig currentVC] presentViewController:customAlert animated:YES completion:nil];
                    });
                }else{
                    weakself.failBlock?weakself.failBlock(JoinRoomFailTypeForOther):nil;
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
                weakself.isRequestUrl = NO;
            }];
        }
            break;
        default:
        {
           // NSLog(@"过滤文字直播间类型不对"));
            weakself.failBlock?weakself.failBlock(JoinRoomFailTypeForOther):nil;
        }
            break;
    }
}

/// 加入房间
/// @param roomId 房间ID
/// @param num 已加入次数 默认最多加三次 超过三次报错
- (void)joinImRoom:(int64_t)roomId frequency:(int)num{
    kWeakSelf(self);
    num --;
    if ([[IMSocketIns getIns] isLogin]) {
        [[IMSocketIns getIns]joinGroupWithGroupId:[NSString stringWithFormat:@"%lld",roomId] msg:@"" sucess:^{
           // NSLog(@"过滤文字进群成功 == %lld"),roomId);
        } fail:^(int code, NSString * _Nonnull desc) {
            if (num > 0) {
                [weakself joinImRoom:roomId frequency:num];
            }else{
                [SVProgressHUD showErrorWithStatus:desc];
            }
        }];
    }else{
        [ProjConfig connectSocket];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[IMSocketIns getIns]joinGroupWithGroupId:[NSString stringWithFormat:@"%lld",roomId] msg:@"" sucess:^{

            } fail:^(int code, NSString * _Nonnull desc) {
                if (num > 0) {
                    [weakself joinImRoom:roomId frequency:num];
                }else{
                    [SVProgressHUD showErrorWithStatus:desc];
                }
            }];
        });
    }
}
 
///进入自己的房间
- (void)joinOwnRoom:(int64_t)roomId liveType:(int)liveType{
    switch (liveType) {
        case 1:  ///视频直播间
        {
            ///暂无回房间的方法
           // NSLog(@"过滤文字checkroomPermissions:视频直播间暂无回房间方法"));
        }
            break;
        case 2:   ///语音房间
        {
            kWeakSelf(self);
            [HttpApiHttpVoice joinVoiceRoom:roomId roomType:0 roomTypeVal:@"" callback:^(int code, NSString *strMsg, AppJoinRoomVOModel *model) {
                if (code == 1) {
                    if (!weakself.noNotifyForOnceAtChangeRoom) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:liveChangeRoomNotify object:nil];
                    }else{
                        weakself.noNotifyForOnceAtChangeRoom = NO;
                    }
                    [RouteManager routeForName:RN_live_audioForAudienceVC currentC:[ProjConfig currentVC] parameters:@{@"model":model}];
                }else{
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
        }
            break;
        default:
        {
           // NSLog(@"过滤文字checkroomPermissions:直播间类型不对"));
        }
            break;
    }
}


@end
