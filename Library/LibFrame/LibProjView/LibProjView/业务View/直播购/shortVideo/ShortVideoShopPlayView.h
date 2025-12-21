//
//  ShortVideoShopPlayView.h
//  LibProjView
//
//  Created by ssssssss on 2020/10/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ApiShortVideoDtoModel;
@class ShortVideoShopPlayView;
typedef void (^ShortVideoShopPlayViewCallback)(BOOL isCommoditySelected,ShortVideoShopPlayView *shopView);
@interface ShortVideoShopPlayView : UIView
+ (void)showInSuperV:(UIView *)superV level:(int)level modelWith:(ApiShortVideoDtoModel *)commodityModel pointY:(CGFloat)pointY callBack:(ShortVideoShopPlayViewCallback)callBack;
@end

NS_ASSUME_NONNULL_END
