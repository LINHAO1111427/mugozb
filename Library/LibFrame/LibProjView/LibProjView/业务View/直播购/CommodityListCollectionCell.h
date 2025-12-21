//
//  CommodityRecommendTable.h
//  Shopping
//
//  Created by KLC on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface CommodityListCollectionCell : UICollectionViewCell
@property (nonatomic, strong)ShopGoodsDTOModel *model;
@end

NS_ASSUME_NONNULL_END
