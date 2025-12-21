//
//  LivePayTipsView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/11/5.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiExitRoomModel;
@interface LivePayTipsView : UIView

- (instancetype)initWithSuperView:(UIView *)superV;

@property (nonatomic, assign)int showType;  ///0:无  1:免费试看 2:房间模式改变

@property (nonatomic, copy)void(^paymengBlock)(BOOL success);

///显示试看结束扣费
- (void)showFeeTips;

///显示改变房间模式
- (void)showChangeTips:(ApiExitRoomModel *)roomModel;

///充值金币成功
- (void)rechargeSuccess;


- (void)dismissView;

@end

NS_ASSUME_NONNULL_END
