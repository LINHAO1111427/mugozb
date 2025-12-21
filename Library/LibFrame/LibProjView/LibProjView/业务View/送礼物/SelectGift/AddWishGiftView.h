//
//  AddWishGiftView.h
//  MPVideoLive
//
//  Created by admin on 2019/8/2.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/GiftUserModel.h>

NS_ASSUME_NONNULL_BEGIN

//心愿单选择礼物
@class NobLiveGiftModel;

@interface AddWishGiftView : UIView


/// 显示选择的礼物列表
/// @param canSelectGiftNum 是否显示选择礼物数量
/// @param btnTitle 按钮显示文字
/// @param giftBlock 选择数据返回
+ (void)addWishGift:(BOOL)canSelectGiftNum sureTitle:(NSString *)sureTitle selectGiftBack:(void(^)(NobLiveGiftModel *giftModel, int selectNum))giftBlock;



@end

NS_ASSUME_NONNULL_END
