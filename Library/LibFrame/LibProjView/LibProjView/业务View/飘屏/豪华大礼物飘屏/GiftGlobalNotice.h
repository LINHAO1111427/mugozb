//
//  GiftGlobalNotice.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class ApiGiftSenderModel;
@interface GiftGlobalNotice : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)playGlobalGift:(ApiGiftSenderModel *)giftModel;

@end

NS_ASSUME_NONNULL_END
