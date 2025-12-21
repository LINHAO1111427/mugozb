//
//  PeivilegeGiftAppearView.h
//  LiveCommon
//
//  Created by ssssssss on 2020/8/29.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiGiftSenderModel;
@interface PrivilegeGiftAppearView : UIView
/// 设置视图的显示内容
- (void)showGiftModel:(ApiGiftSenderModel *)giftModel;
@end

NS_ASSUME_NONNULL_END
