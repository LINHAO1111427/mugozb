//
//  AppVersion.m
//  LibProjView
//
//  Created by admin on 2019/12/13.
//  Copyright © 2019 . All rights reserved.
//

#import "AppVersion.h"

#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/ForceAlertController.h>

@implementation AppVersion

+ (void)versionJudgment{
    [HttpApiAppLogin getAppUpdateInfoNew:[IPhoneInfo appVersionNO] type:2 versionCode:[[IPhoneInfo appVersionBuild] intValue] callback:^(int code, NSString *strMsg, ApiVersionModel *model) {
        if (code == 1) {
            // -1:不需要更新,0:非强制,1:强制
            switch (model.isConstraint) {
                case 0:
                {
                    ForceAlertController *forceVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(model.des)];
                    [forceVC addOptions:kLocalizationMsg(@"使用旧版") textColor:ForceAlert_BlackColor clickHandle:nil];
                    [forceVC addOptions:kLocalizationMsg(@"前往更新") textColor:ForceAlert_NormalColor clickHandle:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                    }];
                    [[ProjConfig currentVC] presentViewController:forceVC animated:YES completion:nil];
                }
                    break;
                case 1:
                {
                    
                    ForceAlertController *forceVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(model.des)];
                    //                    forceVC.force = YES;
                    [forceVC addOptions:kLocalizationMsg(@"前往更新") textColor:ForceAlert_NormalColor clickHandle:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                    }];
                    [[ProjConfig currentVC] presentViewController:forceVC animated:YES completion:nil];
                }
                    break;
                default:
                {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"当前已是最新版本")];
                }
                    break;
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

@end
