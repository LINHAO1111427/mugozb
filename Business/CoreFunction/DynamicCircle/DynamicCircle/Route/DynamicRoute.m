//
//  DynamicRoute.m
//  DynamicCircle
//
//  Created by klc_sl on 2021/7/31.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "DynamicRoute.h"
#import "DynamicPublishViewController.h"
#import "DynamicReportController.h"
#import "DynamicTopicListVC.h"
#import "DynamicPlayListViewController.h"

@implementation DynamicRoute

+ (void)registeRoute{
    
    ///发布动态
    [RouteManager addRouteForName:RN_dynamic_releaseDynamicVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        DynamicPublishViewController *release = [[DynamicPublishViewController alloc] init];
        if ([parameters[@"images"] count] > 0) {
            release.imgArr = parameters[@"images"];
        }else{
            release.videoUrl = parameters[@"videoUrl"];
            release.previewImg = parameters[@"preview"];
            release.videoDuration = parameters[@"duration"];
        }
        return release;
    }];
    
    ///动态举报
    [RouteManager addRouteForName:RN_dynamic_dynamicReportVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        DynamicReportController *report = [[DynamicReportController alloc] init];
        report.dynamicId = [parameters[@"id"] longLongValue];
        return report;
    }];
    
    ///动态视频播放
    [RouteManager addRouteForName:RN_dynamic_playVideoVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        DynamicPlayListViewController *list = [[DynamicPlayListViewController alloc] init];
        list.index = parameters[@"index"];
        list.touId = parameters[@"touId"];
        list.type = parameters[@"type"];
        list.hotId = parameters[@"hotId"];
        list.models = parameters[@"models"];
        list.hasLoading = parameters[@"hasLoading"];
        return list;
    }];
    
    ///动态话题
    [RouteManager addRouteForName:RN_dynamic_topic handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        DynamicTopicListVC *topicVc = [[DynamicTopicListVC alloc] init];
        topicVc.topicName = parameters[@"topicName"];
        topicVc.topic_id = parameters[@"topicId"];
        return topicVc;
    }];
}


@end
