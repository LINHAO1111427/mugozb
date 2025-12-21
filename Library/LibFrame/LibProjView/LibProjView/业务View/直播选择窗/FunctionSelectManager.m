//
//  FunctionSelectManager.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "FunctionSelectManager.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjBase/ProjBaseData.h>
#import <LibProjBase/KLCNavgationContoller.h>

#import "CustomPopUpAlert.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/CustomCameraController.h>

static FunctionSelectManager *_functionManager = nil;

@interface FunctionSelectManager ()

@property (nonatomic, weak) UIView *functionSelectView;

@property (nonatomic, copy) NSArray<MainFunctionModel *> *items;

@end

@implementation FunctionSelectManager

+ (FunctionSelectManager *)share{
    if (_functionManager == nil) {
        _functionManager = [[FunctionSelectManager alloc] init];
    }
    return _functionManager;
}

+ (void)showFunction:(NSArray<MainFunctionModel *> *)function{
    [[FunctionSelectManager share] showFunctionView:function];
}

 

///显示功能选择
- (void)showFunctionView:(NSArray<MainFunctionModel *> *)function{
    if (!_functionSelectView) {
        self.items = function;
        [self creatUI];
    }
}

- (void)creatUI{
    
    CGFloat viewH = 200;
    UIView *functionSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, viewH+kSafeAreaBottom)];
    functionSelectView.userInteractionEnabled = YES;
    functionSelectView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98];
    [[PopupTool share] createPopupViewWithLinkView:functionSelectView allowTapOutside:YES popupBgViewAction:@selector(hidBtnClick) popupBgViewTarget:self cover:YES];
    _functionSelectView = functionSelectView;
    
    CGFloat btnW = 85;
    CGFloat space = ((functionSelectView.width-24) - _items.count*btnW)/((_items.count+1) *1.0) ;
    for (int i = 0; i < _items.count; i++) {
        
        MainFunctionModel *model = _items[i];
        
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(12 + space + (btnW+space)*i, 18, btnW, btnW);
        btn.tag = 95588+i;
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [functionSelectView addSubview:btn];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:btn.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *iconName = @"";
        NSString *defaultTitle = @"";
        switch (model.type) {
            case MainFunctionForMPVideo://视频直播
                iconName = @"main_more_zhibo";
                defaultTitle = kLocalizationMsg(@"视频直播");
                break;
            case MainFunctionForMPAudio://语音直播
                iconName = @"main_more_yuyin";
                defaultTitle = kLocalizationMsg(@"语音直播");
                break;
            case MainFunctionForDynamic://发动态
                iconName = @"main_more_xiaoshipig";
                defaultTitle = kLocalizationMsg(@"拍摄");
                break;
            case MainFunctionForShortAll://发布短视频
                iconName = @"main_more_xiaoshipig";
                defaultTitle = kLocalizationMsg(@"短视频");
                break;
            case MainFunctionForShortPhoto://发段视频照片
                iconName = @"main_more_zhaopian";
                defaultTitle = kLocalizationMsg(@"相册");
                break;
            case MainFunctionForShortVideo://发布短视频
                iconName = @"main_more_xiaoshipig";
                defaultTitle = kLocalizationMsg(@"短视频");
                break;
            case MainFunctionForDynamicPic://发动态照片
                iconName = @"main_more_zhaopian";
                defaultTitle = kLocalizationMsg(@"图片");
                break;
            case MainFunctionForDynamicVideo://发布动态视频
                iconName = @"main_more_xiaoshipig";
                defaultTitle = kLocalizationMsg(@"短视频");
                break;
            default:
                break;
        }
        imgView.image = model.icon?model.icon:[UIImage imageNamed:iconName];
        [btn addSubview:imgView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.height-17, btn.width, 17)];
        label.text = model.title.length>0?model.title:defaultTitle;
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:label];
    }
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(functionSelectView.frame.size.width/2-20, viewH-40-10, 40, 40);
    closeBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    [closeBtn addTarget:self action:@selector(hidBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"main_close_jinshan"] forState:0];
    [functionSelectView addSubview:closeBtn];
    [functionSelectView cornerRadii:CGSizeMake(10, 10) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight];
    [[PopupTool share] animationShowPopupView:functionSelectView];
}

#pragma mark - 按钮
- (void)itemBtnClick:(UIButton *)sender{
    [self hidBtnClick];
    MainFunctionModel *model = _items[sender.tag-95588];
    [self functionOne:model.type];
}


- (void)hidBtnClick{
    [[PopupTool share] closePopupView:_functionSelectView animate:YES];
}


- (void)functionOne:(MainFunctionItemType)type {
    
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    
    kWeakSelf(self);
    switch (type) {
        case MainFunctionForMPVideo:
        {
            if ([ProjBaseData share].userState == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您正在直播")];
            }else{
                [self livePermission:^(OpenAuthDataVOModel *voModel) {
                    //点击直播
                    [[NSNotificationCenter defaultCenter] postNotificationName:liveChangeRoomNotify object:nil];
                    [RouteManager routeForName:RN_live_liveForAnchorVC currentC: [ProjConfig currentVC] parameters:@{@"openData":voModel}];
                }];
            }
        }
            break;
        case MainFunctionForMPAudio:
        {
            if ([ProjBaseData share].userState == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您正在直播")];
            }else{
                [self voicePermission:^(OpenAuthDataVOModel *voModel) {
                    //点击直播
                    [[NSNotificationCenter defaultCenter] postNotificationName:liveChangeRoomNotify object:nil];
                    [RouteManager routeForName:RN_live_audioForAnchorVC currentC: [ProjConfig currentVC] parameters:@{@"openData":voModel}];
                }];
            }
        }
            break;
        case MainFunctionForShortAll://短视频(全)
        {
            [self shortVideoPermission:^{
                [weakself pushALShortVideoCamera:300 type:CameraFunction_all routeName:RN_shortVideo_aliRecord];
            }];
        }
            break;
        case MainFunctionForShortPhoto://照片
        {
            [self shortVideoPermission:^{
                [weakself pushALShortVideoCamera:0 type:CameraFunction_onlyCamera routeName:RN_shortVideo_aliCrop];
            }];
        }
            break;
        case MainFunctionForShortVideo://短视频
        {
            [self shortVideoPermission:^{ 
                [weakself pushALShortVideoCamera:300 type:CameraFunction_onlyRecord routeName:RN_shortVideo_aliRecord];
            }];
        }
            break;
        case MainFunctionForDynamic: ///动态（全）
        {
            [self videoPermission:^{
                //发布动态
                [weakself pushCamreaVC:300 type:CameraFunction_all routeName:RN_dynamic_releaseDynamicVC];
            }];
        }
            break;
        case MainFunctionForDynamicPic://动态照片
        {
            [self videoPermission:^{
                [weakself pushCamreaVC:0 type:CameraFunction_onlyCamera routeName:RN_dynamic_releaseDynamicVC];
            }];
        }
            break;
        case MainFunctionForDynamicVideo://动态视频
        {
            [self videoPermission:^{
                [weakself pushCamreaVC:300 type:CameraFunction_onlyRecord routeName:RN_dynamic_releaseDynamicVC];
            }];
        }
            break;
        default:
            break;
    }
}
+ (void)pushViewControllerForType:(MainFunctionItemType)type{
    [[FunctionSelectManager share] functionOne:type];
}
 
#pragma mark - 验证
///短视频权限
- (void)shortVideoPermission:(void(^)(void))successHandle{
    kWeakSelf(self);
    [HttpApiAnchorController openAuth:4 callback:^(int code, NSString *strMsg, OpenAuthDataVOModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            if (successHandle) {
                successHandle();
            }
        }else if (code == 2) {
            [weakself authAcDeal:strMsg];
        }else if (code == 3) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///动态权限
- (void)videoPermission:(void(^)(void))successHandle{
    kWeakSelf(self);
    [HttpApiAnchorController openAuth:2 callback:^(int code, NSString *strMsg, OpenAuthDataVOModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            if (successHandle) {
                successHandle();
            }
        }else if (code == 2) {  ///认证
            [weakself authAcDeal:strMsg];
        }else if (code == 3) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///直播权限
- (void)livePermission:(void(^)(OpenAuthDataVOModel *voModel))successHandle{
    kWeakSelf(self);
    [SVProgressHUD show];
    [HttpApiAnchorController openAuth:1 callback:^(int code, NSString *strMsg, OpenAuthDataVOModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            if (model.roomId > 0) { ///里面是房间号（房间号说明有自己的其他直播间）回到自己直播间
                [weakself backUserBeforeRoom:model.roomId];
            }else{
                if (successHandle) {
                    successHandle(model);
                }
            }
        }else if (code == 2) { //需要认证
            [weakself authAcDeal:strMsg];
        }else if (code == 3) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)voicePermission:(void(^)(OpenAuthDataVOModel *voModel))successHandle{
    kWeakSelf(self);
    [SVProgressHUD show];
    [HttpApiAnchorController openAuth:5 callback:^(int code, NSString *strMsg, OpenAuthDataVOModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            if (model.roomId > 0) { ///里面是房间号（房间号说明有自己的其他直播间）回到自己直播间
                [weakself backUserBeforeRoom:model.roomId];
            }else{
                if (successHandle) {
                    successHandle(model);
                }
            }
        }else if (code == 2) {  //需要认证
            [weakself authAcDeal:strMsg];
        }else if (code == 3) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



- (void)authAcDeal:(NSString *)strMsg{
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:strMsg.length?strMsg:kLocalizationMsg(@"未认证")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"去认证") textColor:ForceAlert_NormalColor clickHandle:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            ApiUserInfoModel *user = KLCUserInfo.getUserInfo;
            APPConfigModel *config =KLCAppConfig.appConfig;
            if (config.adminLiveConfig.authIsSex == 0 && user.sex != 2) {//只允许女性
                //弹框
                CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"温馨提示") message:kLocalizationMsg(@"暂时只支持小姐姐认证哦~") liveType:LiveTypeForCommon];
                customAlert.clickCancelBlock = ^{
                    
                };
                customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
                };
                UIViewController *vc = [ProjConfig currentVC];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [vc presentViewController:customAlert animated:YES completion:nil];
                });
            }else{
                [RouteManager routeForName:RN_center_anchorAuthAC currentC:[ProjConfig currentVC]];
            }
        });
    }];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];

}



- (void)backUserBeforeRoom:(int64_t)roomId{
    if (roomId > 0) {
        ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"您正在直播中哦~")];
        [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
        [alert addOptions:kLocalizationMsg(@"返回房间") textColor:ForceAlert_NormalColor clickHandle:^{
            [[CheckRoomPermissions share] joinOwnRoom:roomId liveType:2];
        }];
        [[ProjConfig currentVC] presentViewController:alert animated:YES completion:nil];
    }
}


- (void)pushCamreaVC:(CFTimeInterval)maxTime type:(CameraFunctionType)type routeName:(NSString *)routeName{
   
    CustomCameraController *camera = [[CustomCameraController alloc] init];
    camera.showPhotoAlbum = YES;
    camera.functionType = type;
    camera.maxRecordTime = maxTime;
    [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
        [cameraVC dismissViewControllerAnimated:NO completion:nil];
        [RouteManager routeForName:routeName currentC:[ProjConfig currentVC] parameters:@{@"images":images}];
    }];
    [camera selectVideoDidComplete:^(CustomCameraController *cameraVC, NSURL *videoUrl, UIImage *preview, CGFloat duration) {
        [cameraVC dismissViewControllerAnimated:NO completion:nil];
        [RouteManager routeForName:routeName currentC:[ProjConfig currentVC] parameters:@{@"videoUrl":videoUrl,@"preview":preview,@"duration":@(duration)}];
    }];
    KLCNavgationContoller *klcCamera = [[KLCNavgationContoller alloc] initWithRootViewController:camera];
    klcCamera.modalPresentationStyle = UIModalPresentationFullScreen;
    [[ProjConfig currentVC] presentViewController:klcCamera animated:YES completion:nil];
    
}

- (void)pushALShortVideoCamera:(CFTimeInterval)maxTime type:(CameraFunctionType)type routeName:(NSString *)routeName{
    if (type == CameraFunction_onlyRecord) {
        [RouteManager routeForName:routeName currentC:[ProjConfig currentVC] parameters:nil];
    }else{
        [RouteManager routeForName:routeName currentC:[ProjConfig currentVC] parameters:nil];
    }
}


@end


#pragma mark - MainFunctionModel
@implementation MainFunctionModel

- (instancetype)initWithType:(MainFunctionItemType)type title:(NSString *)title icon:(UIImage *)icon {
    self = [super init];
    if (self) {
        _type = type;
        _title = title;
        _icon = icon;
    }
    return self;
    
}

@end
