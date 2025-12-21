//
//  CommodityDetailTable.h
//  Shopping
//
//  Created by klc on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopGoodsModel.h>

NS_ASSUME_NONNULL_BEGIN
 
@interface CommodityDetailTable : UITableViewCell

@property (nonatomic, strong)ShopGoodsModel *shopGoods;


+ (void)getWebImageWith:(NSString *)url callBack:(void(^_Nullable)(BOOL success,CGFloat imgHeight))callBack;


@end

NS_ASSUME_NONNULL_END
