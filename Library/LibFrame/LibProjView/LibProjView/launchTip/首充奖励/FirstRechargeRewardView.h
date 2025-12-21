//
//  FirstRechargeRewardView.h
//  LibProjView
//
//  Created by ssssssss on 2020/12/7.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^FirstRechargeRewardCallback)(BOOL isSucess);

@interface FirstRechargeRewardView : UIView

+ (void)launchShowFirstRechargeReward:(FirstRechargeRewardCallback)callBack;


+ (void)mainPageShowRechargeReward:(NSArray *)rewardArr;

@end

NS_ASSUME_NONNULL_END
 
 
 
