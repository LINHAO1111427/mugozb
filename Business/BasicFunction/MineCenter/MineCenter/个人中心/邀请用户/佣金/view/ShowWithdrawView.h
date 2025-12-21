//
//  ShowWithdrawView.h
//  MineCenter
//
//  Created by shirley on 2021/12/8.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RechargeCenterVOModel,ShowWithdrawView,AppUsersCashAccountModel;

NS_ASSUME_NONNULL_BEGIN

@protocol ShowWithdrawViewDelegate <NSObject>

- (void)selectAccountForWithdrawView:(ShowWithdrawView *)showV;
///成功
- (void)withdrawSuccess;

@end

@interface ShowWithdrawView : UIView

@property (nonatomic, weak)id<ShowWithdrawViewDelegate> delegate;

///需要先设置
@property (nonatomic, assign) double totalAmount; ///总收益佣金
@property (nonatomic, assign) double amount; ///剩余佣金



////fixedWithdrawRuleVOList 有值时此参数才有值
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, weak)UIView *contentBgV;
@property (nonatomic, weak)UIScrollView *scrollVBgV;
@property (nonatomic, strong)UITextField *commisionTextField;//佣金
@property (nonatomic, strong)UILabel *accountLabel;//提现方式



@property (nonatomic, strong,nullable)AppUsersCashAccountModel *selectedAccountModel;//提现账户

@property(nonatomic,strong)RechargeCenterVOModel *chargeRulesRespModel;


@end

NS_ASSUME_NONNULL_END
