//
//  GiftGlobalBannerView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiGiftSenderModel;

@interface GiftGlobalBannerView : UIView

@property (nonatomic, strong, readonly)ApiGiftSenderModel *giftModel;

/// 设置视图的显示内容
- (void)showGiftModel:(ApiGiftSenderModel *)giftModel;

///更改连送数字
- (void)changeLiansongNumber:(NSInteger)liansongNumber;

@end

NS_ASSUME_NONNULL_END
