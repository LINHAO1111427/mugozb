//
//  CommodityInfoTable.h
//  Shopping
//
//  Created by klc on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol CommodityInfoTableDelegate <NSObject>
@optional
- (void)CommodityInfoTableSelectedAttriModelChange:(ShopAttrComposeModel*)model;
- (void)commodityInfoRefresh;
@end

@interface CommodityInfoTable : UIView

@property (nonatomic, strong)ShopGoodsDetailDTOModel *detailModel;
@property (nonatomic, assign)int num;
@property (nonatomic, strong)id superVc;
@property (nonatomic, strong)ShopAttrComposeModel *selectedAttriModel;
@property (nonatomic, weak)id<CommodityInfoTableDelegate> delegate;

- (void)changeSelectedAttriBute:(ShopAttrComposeModel *)attriModel num:(int)num;



@end

NS_ASSUME_NONNULL_END
