//
//  LiveShoppingAccrossCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopLiveGoodsModel;
@interface LiveShoppingAccrossCell : UICollectionViewCell

///图标
@property (nonatomic, weak)UIImageView *imageV;

///讲解状态按钮
@property (nonatomic, weak)UIButton *stateBtn;

///标题
@property (nonatomic, weak)UILabel *titleL;

///内容
@property (nonatomic, weak)UILabel *priceL;


- (void)showGoods:(ShopLiveGoodsModel *)goods;

@end

NS_ASSUME_NONNULL_END
