//
//  ShowExchangeView.h
//  MineCenter
//
//  Created by shirley on 2021/12/8.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RechargeRulesVOModel;


NS_ASSUME_NONNULL_BEGIN

@interface ShowExchangeView : UIView

@property (nonatomic, assign)NSInteger selectedIndex;

@property (nonatomic, weak)UIScrollView *scrollVBgV;

@property (nonatomic, copy)void(^rechangeSuccessBlock)(void);

@property (nonatomic, copy)NSArray<RechargeRulesVOModel*> *rechargeRulesVOList;



@end

NS_ASSUME_NONNULL_END
