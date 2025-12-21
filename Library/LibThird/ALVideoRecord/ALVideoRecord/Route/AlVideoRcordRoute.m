//
//  AlVideoRcordRoute.m
//  ALVideoRecord
//
//  Created by swh_y on 2022/6/22.
//

#import "AlVideoRcordRoute.h"
#import <UIKit/UIKit.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>

#import "ALVideoRecordManager.h"
#import "AliyunIConfig.h"
#import "AliyunVideoBase.h"
#import "AliyunVideoCropParam.h"
#import "AliyunVideoRecordParam.h"
@interface AlVideoRcordRoute () 
 
@end

@implementation AlVideoRcordRoute

+ (void)registeRoute{
    ///阿里短视频拍摄
    [RouteManager addRouteForName:RN_shortVideo_aliRecord handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *recordVc = [[AliyunVideoBase shared] createRecordViewControllerWithRecordParam:[[ALVideoRecordManager share] getRecordConfig]];
        [AliyunVideoBase shared].delegate = [ALVideoRecordManager share];
        return recordVc;
    }];
    
    
    ///阿里短视频裁剪
    [RouteManager addRouteForName:RN_shortVideo_aliCrop handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *cropVc = [[AliyunVideoBase shared] createPhotoViewControllerCropParam:[ [ALVideoRecordManager share] getCropConfig]];
        [AliyunVideoBase shared].delegate = [ALVideoRecordManager share];
        [AliyunIConfig config].showCameraButton = NO;
        return cropVc;
    }];
}

@end
