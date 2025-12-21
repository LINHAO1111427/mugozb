//
//  PayResultView.h
//  LibProjView
//
//  Created by klc_sl on 2020/11/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/PaymentManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PayResultSelectType) {
    PayResultSelectCancel,  ///取消
    PayResultSelectSuccess,  ///确认
    PayResultSelectAgain,  ///再次支付
};

@interface PayResultView : UIView


/// 购买结果展示
/// @param isSuccess 成功失败
/// @param payType 支付类型
/// @param value 数额/内容
/// @param reason 失败原因
/// @param btnClickBlock 返回
+ (void)showResult:(BOOL)isSuccess payType:(BusinessType)payType value:(double)value failReason:(NSString *)reason btnClick:(void(^)(PayResultSelectType selectType))btnClickBlock;

@end

NS_ASSUME_NONNULL_END
