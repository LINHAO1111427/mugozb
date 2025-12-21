//
//  CostBannerView.h
//  Message
//
//  Created by klc_tqd on 2020/6/5.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CostBannerView : UIView

@property(nonatomic,copy)void(^closeBtnClickBlock)(void);
@property (nonatomic, copy)NSString *privateChatDeductionTips;

@end

NS_ASSUME_NONNULL_END
