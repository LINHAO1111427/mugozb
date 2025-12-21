//
//  paySelectedBtn.h
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/RechargeRulesVOModel.h>
#import <LibProjModel/KLCAppConfig.h>
NS_ASSUME_NONNULL_BEGIN

@interface paySelectedBtn : UIButton

///金额
@property (nonatomic, strong)RechargeRulesVOModel *ruleModel;
@property (nonatomic, assign)BOOL isSelected;



@end

NS_ASSUME_NONNULL_END
