//
//  RankingRoute.m
//  Ranking
//
//  Created by klc_sl on 2021/8/5.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "RankingRoute.h"
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>
#import "TotalRankMainVc.h"
#import "FamilyInternalRankVc.h"

@implementation RankingRoute

+ (void)registeRoute{
    
    //粉丝贡献榜
    [RouteManager addRouteForName:RN_activity_fansContributionAC vcClass:NSClassFromString(@"UserContributeRankVc")];
    
    ///排行榜
    [RouteManager addRouteForName:RN_center_Ranking handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        TotalRankMainVc *totalVC = [[TotalRankMainVc alloc] init];
        totalVC.selectType = [parameters[@"type"] intValue];
        totalVC.subSelectIndex = [parameters[@"subSelectIndex"] intValue];
        return totalVC;
    }];
    
    [RouteManager addRouteForName:RN_center_FamilyRanking handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        FamilyInternalRankVc *familyRank = [[FamilyInternalRankVc alloc] init];
        familyRank.familyId = [parameters[@"familyId"] longLongValue];
        return familyRank;
    }];

    
}

@end
