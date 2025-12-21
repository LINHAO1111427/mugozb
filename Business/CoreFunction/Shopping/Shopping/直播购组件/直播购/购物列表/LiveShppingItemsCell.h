//
//  LiveShppingItemsCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopLiveGoodsModel;
@protocol LiveShppingItemsCellDelegate <NSObject>
@optional
- (void)LiveShppingItemsCellGotoBuy:(ShopLiveGoodsModel*)good;

@end
@interface LiveShppingItemsCell : UITableViewCell

@property (nonatomic, strong)ShopLiveGoodsModel *goods;

@property (nonatomic, weak)UIButton *selectBtn;

@property (nonatomic, weak)id<LiveShppingItemsCellDelegate> deleagte;
@end

NS_ASSUME_NONNULL_END
