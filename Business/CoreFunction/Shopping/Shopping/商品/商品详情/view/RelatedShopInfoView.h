//
//  RelatedShopInfoView.h
//  Shopping
//
//  Created by klc on 2020/7/8.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RelatedShopInfoView;
@protocol RelatedShopInfoViewDelegate <NSObject>
@optional
- (void)RelatedShopInfoViewShopClick:(RelatedShopInfoView *)shopInfoView shopId:(int64_t)shopId;
- (void)RelatedShopInfoViewCommodityClick:(RelatedShopInfoView *)shopInfoView commodity:(ShopGoodsDTOModel *)model;
@end
@interface RelatedShopInfoView : UIView
@property (nonatomic, assign)CGFloat nameH;
@property (nonatomic, strong)ShopGoodsDetailDTOModel *detailModel;
@property (nonatomic, assign)id<RelatedShopInfoViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
