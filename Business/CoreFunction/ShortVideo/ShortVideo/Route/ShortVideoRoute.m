//
//  ShortVideoRoute.m
//  ShortVideo
//
//  Created by klc_sl on 2021/7/31.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ShortVideoRoute.h"
#import "SVTrySeeAlertVC.h"
#import "ShortVideoReportVC.h"
#import "MyshortVideoVc.h"
#import "ShortVideoListViewController.h"

@implementation ShortVideoRoute

+ (void)registeRoute{

    ///发布短视频
    [RouteManager addRouteForName:RN_shortVideo_release handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *release = [[NSClassFromString(@"ShortVideoPublishViewController") alloc] init];
        if ([parameters[@"images"] count] > 0) {
            [release setValue:parameters[@"images"] forKey:@"imgArr"];
        }else{
            [release setValue:parameters[@"videoUrl"] forKey:@"videoUrl"];
            [release setValue:parameters[@"preview"] forKey:@"previewImg"];
            [release setValue:parameters[@"duration"] forKey:@"videoDuration"];
        }
        return release;
    }];
    
    ///短视频分类
    [RouteManager addRouteForName:RN_shortVideo_sort_List handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *costom = [[NSClassFromString(@"SVSortListViewController") alloc] init];
        [costom setValue:parameters[@"title"] forKey:@"titleName"];
        [costom setValue:parameters[@"classfyId"] forKey:@"classifyId"];
        [costom setValue:parameters[@"sort"] forKey:@"sort"];
        return costom;
    }];
    
    ///我的短视频列表
    [RouteManager addRouteForName:RN_shortVideo_mylist handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MyshortVideoVc *myShortVc = [[MyshortVideoVc alloc] init];
        myShortVc.navTitle = parameters[@"title"];
        myShortVc.userId = [parameters[@"id"] longLongValue];
        return myShortVc;
    }];
    
    ///短视频举报
    [RouteManager addRouteForName:RN_shortVideo_report handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ShortVideoReportVC *report = [[ShortVideoReportVC alloc] init];
        report.videoId = [parameters[@"id"] longLongValue];
        return report;
    }];
    
    ///短视频播放列表
    [RouteManager addRouteForName:RN_shortVideo_play_List handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ShortVideoListViewController *svlist = [[ShortVideoListViewController alloc] init];
        svlist.parameters = parameters;
        return svlist;
    }];
    
    ///付费提示弹窗
    [RouteManager addRouteForName:RN_shortVideo_payAlert complete:^(NSDictionary<NSString *,id> * _Nullable parameters, UIViewController * _Nonnull lastVC) {
        SVTrySeeAlertVC *alertVC = [[SVTrySeeAlertVC alloc] init];
        alertVC.dtoModel = parameters[@"model"];
        alertVC.isPlayBlock = parameters[@"isPlayBlock"];
        [lastVC presentViewController:alertVC animated:NO completion:nil];
    }];
}



@end
