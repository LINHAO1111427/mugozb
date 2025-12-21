//
//  LiveGoodsItemCell.h
//  LibProjView
//
//  Created by klc_sl on 2020/7/10.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopGoodsDTOModel;
@interface LiveGoodsItemCell : UITableViewCell

@property (nonatomic, strong)ShopGoodsDTOModel *goods;

@end

NS_ASSUME_NONNULL_END
