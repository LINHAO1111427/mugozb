//
//  CommodityReommendListCell.h
//  Shopping
//
//  Created by klc_sl on 2021/10/14.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopGoodsDTOModel,CommodityReommendListCell;
NS_ASSUME_NONNULL_BEGIN

@protocol CommodityReommendListCellDelegate <NSObject>

- (void)CommodityReommendListCell:(CommodityReommendListCell *)cell selectOneGoods:(ShopGoodsDTOModel *)dtoModel;

@end

@interface CommodityReommendListCell : UITableViewCell

@property (nonatomic, weak)id<CommodityReommendListCellDelegate> delegate;

@property (nonatomic, copy)NSArray<ShopGoodsDTOModel *> *itemArr;

+ (CGFloat)viewHeight:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
