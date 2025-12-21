//
//  StoreCommodityListTable.h
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagingView/JXPagerView.h>
@class ShopGoodsDTOModel;
NS_ASSUME_NONNULL_BEGIN

@interface StoreCommodityListTable : UICollectionView<JXPagerViewListViewDelegate>
@property (nonatomic, strong)NSArray<ShopGoodsDTOModel*> *dataArray;
@property (nonatomic, weak)UIViewController *superVc;
@end

NS_ASSUME_NONNULL_END
