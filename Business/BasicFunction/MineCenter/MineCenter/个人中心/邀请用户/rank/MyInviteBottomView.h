//
//  MyInviteBottomView.h
//  MineCenter
//
//  Created by shirley on 2021/12/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppUserIncomeRankingDtoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyInviteBottomView : UIView

@property (nonatomic, weak)UIButton *indexBtn;
@property (nonatomic, weak)UILabel *nameL;
@property (nonatomic, weak)UIImageView *avaterImgV;
@property (nonatomic, weak)UILabel *inviteNumL;
@property (nonatomic, weak)UILabel *getNumL;

@property (nonatomic, strong)AppUserIncomeRankingDtoModel *myInviteInfoM;

@end

NS_ASSUME_NONNULL_END
