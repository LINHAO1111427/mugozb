//
//  MessageShowGiftInfoView.h
//  Message
//
//  Created by klc_sl on 2021/7/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendGiftInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MessageShowGiftInfoView : UIView

@property (nonatomic , weak) UIView *giftBgView;
@property (nonatomic , weak) UIImageView *giftIconV;
@property (nonatomic , weak) UIImageView *giftHeadV;
@property (nonatomic , weak) UIImageView *giftOtherHeadV;
@property (nonatomic , weak) UILabel *giftdecL;
@property (nonatomic , weak) UILabel *giftCountL;


- (void)showGiftInfo:(SendGiftInfoModel *)giftInfo isGroup:(BOOL)isGroup isOwn:(BOOL)isOwn;


@end

NS_ASSUME_NONNULL_END
