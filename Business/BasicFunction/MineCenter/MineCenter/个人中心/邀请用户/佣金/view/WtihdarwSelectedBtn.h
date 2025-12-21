//
//  WtihdarwSelectedBtn.h
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/FixedWithdrawRuleVOModel.h>
#import <LibProjModel/KLCAppConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface WtihdarwSelectedBtn : UIButton

///金额
@property (nonatomic, strong)FixedWithdrawRuleVOModel *ruleModel;
@property (nonatomic, assign)BOOL isSelected;



@end

NS_ASSUME_NONNULL_END
