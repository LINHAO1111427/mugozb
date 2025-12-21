//
//  GiftBannerView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiGiftSenderModel;
typedef NS_ENUM(NSUInteger, GiftBannerType) {
     ///普通礼物
    GiftBannerForNormal,
    ///贵族礼物
    GiftBannerForVIP,
     ///守护礼物
    GiftBannerForGuard,
     ///粉丝团礼物
    GiftBannerForFans,
};


@interface GiftBannerView : UIView

@property (nonatomic, strong, readonly)ApiGiftSenderModel *giftModel;


@property (nonatomic, assign)NSInteger giftNum;


/// 设置视图的显示内容
/// @param type 礼物类型
- (void)showView:(GiftBannerType)type giftModel:(ApiGiftSenderModel *)giftModel;

///更改连送数字 更新幸运金币
- (void)changeLianSongNumber:(NSInteger)liansongNumber luckCoin:(double)coin;

@end

NS_ASSUME_NONNULL_END
