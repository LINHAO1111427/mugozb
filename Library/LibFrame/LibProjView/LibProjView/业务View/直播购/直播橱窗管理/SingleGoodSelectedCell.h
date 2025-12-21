//
//  SingleGoodSelectedCell.h
//  LibProjView
//
//  Created by ssssssss on 2020/10/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopGoodsDTOModel;
@protocol SingleGoodSelectedCellDelegate <NSObject>
@optional
- (void)SingleGoodSelectedCellDidSelected:(ShopGoodsDTOModel *)selectedGoods;
@end
@interface SingleGoodSelectedCell : UITableViewCell
@property (nonatomic, strong)ShopGoodsDTOModel *goods;
@property (nonatomic, weak)id<SingleGoodSelectedCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
