//
//  InviteRollTableView.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/PGIndexBannerSubiew.h>

NS_ASSUME_NONNULL_BEGIN

@class AppUserIncomeRankingDtoModel;

@interface InviteRollTableView : PGIndexBannerSubiew

- (void)showInfoData:(NSArray<AppUserIncomeRankingDtoModel *> *)infoData;

@end

NS_ASSUME_NONNULL_END
