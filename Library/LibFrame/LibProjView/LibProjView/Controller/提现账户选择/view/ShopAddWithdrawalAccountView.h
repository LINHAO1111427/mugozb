//
//  AddWithdrawalAccountView.h
//  CapitalMarket
//
//  Created by klc on 2020/3/26.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopAddWithdrawalAccountView : UIView

//支付宝
@property (nonatomic,strong)UIView *alipayView;
@property (nonatomic,strong)UITextField *alipayNameText;
@property (nonatomic,strong)UITextField *alipayAccountText;

//微信
@property (nonatomic,strong)UIView *weChatView;
@property (nonatomic,strong)UITextField *weChatNameText;
@property (nonatomic,strong)UITextField *weChatAccountText;

//银行
@property (nonatomic,strong)UIView *bankView;
@property (nonatomic,strong)UITextField *bankNameText;//银行名称
@property (nonatomic,strong)UITextField *bankBranchText;//开户支行
@property (nonatomic,strong)UITextField *bankAccountText;//银行卡号
@property (nonatomic,strong)UITextField *bankAccountNameText;//银行姓名



@end

NS_ASSUME_NONNULL_END
