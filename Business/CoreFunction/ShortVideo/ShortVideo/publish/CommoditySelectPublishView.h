//
//  CommoditySelectPublishView.h
//  ShortVideo
//
//  Created by klc_sl on 2021/6/19.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopGoodsDTOModel;

@interface CommoditySelectPublishView : UIView

@property (nonatomic, strong)ShopGoodsDTOModel *_Nullable goodsModel;

@property (nonatomic, assign)BOOL selectGoods;

@end

NS_ASSUME_NONNULL_END
